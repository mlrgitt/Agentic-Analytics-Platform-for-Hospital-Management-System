SELECT
    {{ dynamic_select(source('bronze','medical_reports')) }}
FROM {{ source('bronze','medical_reports') }}