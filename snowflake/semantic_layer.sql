CREATE TABLE semantic_metadata (
  table_name STRING,
  column_name STRING,
  description STRING
);

INSERT INTO semantic_metadata VALUES
('patient_summary','patient_id','Unique patient identifier'),
('patient_summary','diagnosis_code','ICD-10 diagnosis code'),
('patient_summary','diagnosis_description','Diagnosis description'),
('patient_summary','total_visits','Total visits');