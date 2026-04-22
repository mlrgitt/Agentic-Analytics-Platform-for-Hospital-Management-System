from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    'schema_evolution_pipeline',
    start_date=datetime(2024,1,1),
    schedule_interval='@hourly',
    catchup=False
) as dag:

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='cd /opt/airflow/dbt && dbt run'
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='cd /opt/airflow/dbt && dbt test'
    )

    dbt_run >> dbt_test