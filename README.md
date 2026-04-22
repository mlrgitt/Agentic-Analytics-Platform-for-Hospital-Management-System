1. # Agentic-Analytics-Platform-for-Hospital-Management-System

               Tech Stack: AWS + Snowflake + dbt + QuickSight + Cortex AI
2. # Problem Statement
                Fragmented hospital systems (EHR, Labs, Appointments)
                Schema changes breaking reports
                No real-time insights
                Manual analytics (slow decision-making)
                
   👉 Add:
                
                HIPAA compliance pressure
                Multi-location inconsistency
3. # Solution Overview
          👉 “We built a Lambda + Agentic Analytics Platform”

                Batch + Streaming ingestion
                Schema evolution handled automatically
                Semantic layer for consistency
                AI-driven analytics via Cortex
4. # Architecture
   <img width="801" height="625" alt="image" src="https://github.com/user-attachments/assets/1f026151-75cd-4043-b844-83a49fccdf63" />

   <img width="1417" height="807" alt="image" src="https://github.com/user-attachments/assets/d5e40e67-0f52-4415-a133-d7f37e660f6f" />

   <img width="733" height="496" alt="image" src="https://github.com/user-attachments/assets/26e8c0df-e6b8-4d8a-a037-70785aa144d1" />

   <img width="844" height="476" alt="image" src="https://github.com/user-attachments/assets/391bcef4-2e08-4888-8ab5-bd2456d15272" />

   <img width="380" height="491" alt="image" src="https://github.com/user-attachments/assets/a13283d6-8494-4567-950b-d70492965731" />

   <img width="1536" height="951" alt="image" src="https://github.com/user-attachments/assets/306bf06f-24c0-4fa3-9461-cb4a022fa743" />
   
5. # Data Flow
            Hospital Systems → AWS (S3/Kinesis)
                    → Snowflake Bronze
                    → dbt Silver (dynamic schema)
                    → dbt Gold (semantic layer)
                    → QuickSight + Cortex AI
6. # Key Innovation
          👉 Schema Evolution Handling
              Dynamic dbt models
              Column mapping layer
              Zero pipeline break
            
         👉 Agentic AI            
              Natural language queries
              Auto SQL generation
              Insight generation
7. # Business Dashboards
        Patient Summary
        Diagnosis Trends
        Doctor Performance
        Appointment Analytics
8. # Cortex AI Demo
            User asks: “Show top diagnoses in last 7 days”
                System:
                      Generates SQL
                      Queries Snowflake
                      Returns insight 
9. # Compliance
                      HIPAA masking
                      Audit trails
                      Data lineage (dbt)
10. # Cost Optimization
                      Snowflake auto-suspend
                      S3 low-cost storage
                      Serverless ingestion
11. # Business Impact
          Faster diagnosis insights
          Reduced reporting failures
          AI-driven decision making
          Scalable across hospitals
----------------------------------------
# 🏥 Hospital Agentic Analytics Platform

## 🚀 Overview

This project implements a **production-grade healthcare analytics platform** using:

* AWS (S3, Kinesis)
* Snowflake (Data Warehouse)
* dbt (Transformation + Semantic Layer)
* Airflow (Orchestration)
* QuickSight (Reporting)
* Snowflake Cortex (AI Agent)

---

## 🧠 Key Features

* ✅ Schema Evolution Handling (Dynamic dbt)
* ✅ Semantic Layer for AI & BI
* ✅ Agentic Analytics (Cortex AI)
* ✅ Real-time + Batch Processing
* ✅ HIPAA-compliant design

---

## 🧱 Architecture

```
AWS → Snowflake Bronze → dbt Silver → dbt Gold → QuickSight + Cortex AI
```

---

## ⚙️ Setup

### 1. Install dependencies

```
pip install dbt-snowflake airflow streamlit
```

### 2. Run dbt

```
dbt seed
dbt run
dbt test
```

### 3. Start Airflow

```
docker-compose up airflow
```

---

## 🤖 AI Usage

Example:

> “Show top diagnoses in last 7 days”

---

## 📊 Dashboards

* Patient Summary
* Diagnosis Trends
* Doctor Performance

---

## 🔐 Compliance

* Data masking
* Audit logging
* Secure access

---

## 👨‍💻 Author

Lakshman Rao M

   


