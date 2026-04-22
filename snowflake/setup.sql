CREATE DATABASE HMS_DB;

CREATE SCHEMA BRONZE;
CREATE SCHEMA SILVER;
CREATE SCHEMA GOLD;

CREATE WAREHOUSE compute_wh
WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60;

-- Raw table
CREATE TABLE BRONZE.medical_reports (
  patient_id STRING,
  diagnosis STRING,
  diagnosis_description STRING,
  diagnosis_code STRING,
  report_date DATE
);