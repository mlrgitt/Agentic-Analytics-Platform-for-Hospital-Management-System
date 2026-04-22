-- =========================================================
-- 1. STREAM: Capture CDC from Bronze (Medical Reports)
-- =========================================================

CREATE OR REPLACE STREAM BRONZE.medical_reports_stream
ON TABLE BRONZE.medical_reports
APPEND_ONLY = FALSE;

-- =========================================================
-- 2. TABLE: Audit / CDC Logging (for compliance)
-- =========================================================

CREATE OR REPLACE TABLE SILVER.medical_reports_cdc_audit (
    patient_id STRING,
    diagnosis STRING,
    diagnosis_description STRING,
    diagnosis_code STRING,
    report_date DATE,
    metadata$action STRING,
    metadata$isupdate STRING,
    processed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- =========================================================
-- 3. TASK: Process CDC into Silver Audit Layer
-- =========================================================

CREATE OR REPLACE TASK SILVER.process_medical_reports_cdc
WAREHOUSE = compute_wh
SCHEDULE = '1 MINUTE'
WHEN SYSTEM$STREAM_HAS_DATA('BRONZE.medical_reports_stream')
AS

INSERT INTO SILVER.medical_reports_cdc_audit
SELECT
    patient_id,
    diagnosis,
    diagnosis_description,
    diagnosis_code,
    report_date,
    metadata$action,
    metadata$isupdate,
    CURRENT_TIMESTAMP()
FROM BRONZE.medical_reports_stream;

-- =========================================================
-- 4. TABLE: Schema History Tracking (VERY IMPORTANT)
-- =========================================================

CREATE OR REPLACE TABLE UTIL.schema_history (
    table_name STRING,
    column_name STRING,
    data_type STRING,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- =========================================================
-- 5. TASK: Capture Schema Changes Automatically
-- =========================================================

CREATE OR REPLACE TASK UTIL.capture_schema_changes
WAREHOUSE = compute_wh
SCHEDULE = '5 MINUTE'
AS

INSERT INTO UTIL.schema_history (table_name, column_name, data_type)
SELECT
    table_name,
    column_name,
    data_type
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_schema = 'BRONZE'
AND table_name = 'MEDICAL_REPORTS';

-- =========================================================
-- 6. VIEW: Detect Schema Differences (NEW vs OLD)
-- =========================================================

CREATE OR REPLACE VIEW UTIL.schema_diff AS
SELECT
    s1.table_name,
    s1.column_name,
    s1.data_type,
    'NEW_COLUMN' AS change_type
FROM UTIL.schema_history s1
LEFT JOIN UTIL.schema_history s2
ON s1.table_name = s2.table_name
AND s1.column_name = s2.column_name
AND s1.recorded_at > s2.recorded_at
WHERE s2.column_name IS NULL;

-- =========================================================
-- 7. TASK: Trigger Flag for Schema Evolution
-- =========================================================

CREATE OR REPLACE TABLE UTIL.schema_change_flag (
    change_detected BOOLEAN,
    detected_at TIMESTAMP
);

CREATE OR REPLACE TASK UTIL.detect_schema_evolution
WAREHOUSE = compute_wh
SCHEDULE = '5 MINUTE'
AS

INSERT INTO UTIL.schema_change_flag
SELECT TRUE, CURRENT_TIMESTAMP()
FROM UTIL.schema_diff
LIMIT 1;

-- =========================================================
-- 8. GOLD REFRESH TASK (Optional - Lightweight Refresh)
-- =========================================================

CREATE OR REPLACE TASK GOLD.refresh_patient_summary
WAREHOUSE = compute_wh
SCHEDULE = '10 MINUTE'
AS

MERGE INTO GOLD.patient_summary tgt
USING (
    SELECT
        patient_id,
        COUNT(*) AS total_visits,
        MAX(diagnosis_description) AS latest_diagnosis,
        MAX(diagnosis_code) AS latest_diagnosis_code
    FROM SILVER.standardized_medical_reports
    GROUP BY patient_id
) src
ON tgt.patient_id = src.patient_id

WHEN MATCHED THEN UPDATE SET
    tgt.total_visits = src.total_visits,
    tgt.latest_diagnosis = src.latest_diagnosis,
    tgt.latest_diagnosis_code = src.latest_diagnosis_code

WHEN NOT MATCHED THEN INSERT (
    patient_id,
    total_visits,
    latest_diagnosis,
    latest_diagnosis_code
) VALUES (
    src.patient_id,
    src.total_visits,
    src.latest_diagnosis,
    src.latest_diagnosis_code
);

-- =========================================================
-- 9. ENABLE TASKS (IMPORTANT)
-- =========================================================

ALTER TASK SILVER.process_medical_reports_cdc RESUME;
ALTER TASK UTIL.capture_schema_changes RESUME;
ALTER TASK UTIL.detect_schema_evolution RESUME;
ALTER TASK GOLD.refresh_patient_summary RESUME;