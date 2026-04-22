pharma-hms-agentic/
│
├── airflow/
│   └── dags/
│       └── schema_evolution_dag.py
│
├── dbt/
│   ├── models/
│   │   ├── bronze/
│   │   │   └── sources.yml
│   │   │
│   │   ├── silver/
│   │   │   ├── dynamic_medical_reports.sql
│   │   │   └── standardized_medical_reports.sql
│   │   │
│   │   ├── gold/
│   │   │   └── patient_summary.sql
│   │
│   ├── macros/
│   │   ├── dynamic_select.sql
│   │   ├── resolve_column.sql
│   │   └── column_exists.sql
│   │
│   ├── dbt_project.yml
│   └── profiles.yml
│
├── snowflake/
│   ├── setup.sql
│   ├── streams_tasks.sql
│   ├── semantic_layer.sql
│
├── ingestion/
│   ├── s3_upload.py
│   └── kinesis_producer.py
│
├── cortex_agent/
│   └── agent.py
│
├── ui/
│   └── streamlit_app.py
│
└── README.md