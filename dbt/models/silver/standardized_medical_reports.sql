SELECT
  patient_id,

  {{ resolve_column(source('bronze','medical_reports'),
     ['diagnosis_description','diagnosis']) }} 
  AS diagnosis_description,

  diagnosis_code,

  report_date

FROM {{ source('bronze','medical_reports') }}