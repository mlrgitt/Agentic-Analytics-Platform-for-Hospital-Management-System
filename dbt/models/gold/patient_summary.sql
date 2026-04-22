SELECT
  patient_id,
  COUNT(*) AS total_visits,
  MAX(diagnosis_description) AS latest_diagnosis,
  MAX(diagnosis_code) AS latest_diagnosis_code
FROM {{ ref('standardized_medical_reports') }}
GROUP BY patient_id