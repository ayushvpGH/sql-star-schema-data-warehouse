# sql-star-schema-data-warehouse

## Project Overview
This repository contains the complete SQL Server relational schema and dimensional data warehouse architecture designed to process high-volume digital media streaming transactions and promotional analytics. The system decouples transactional business events from analytical reporting, utilizing an OLAP star schema framework.

## Key Architectural Features
- **Dimensional Modeling:** Implemented master dimension entities (`Customer_Dim`, `Video_Dim`, `Time_Dim`) and core fact tables (`Video_Streaming_Transaction_Fact`, `Streaming_Quality_Anomaly_Fact`, `Video_Watchlist_Event_Fact`, `Customer_Promo_Eligibility_Fact`).
- **Surrogate Keys:** Applied artificial, non-business surrogate primary keys across dimension tables to handle slowly changing dimensions (SCD) and preserve historical record integrity.
- **Composite Fact Keys:** Enforced foreign key integrity across transaction-grained fact tables using composite primary key constraints.
- **Temporal Tracking:** Integrated dual foreign-key paths (`Start_Time_key` and `End_Time_key`) referencing the standalone time ledger to manage promotional eligibility intervals without synthetic auto-incrementing dependencies.

## Data Warehouse Schema Diagram
=============================================================
             ENTERPRISE DATA WAREHOUSE STAR SCHEMA
=============================================================

                   +------------------+
                   |   Customer_Dim   |
                   +------------------+
                   | PK: Customer_key |
                   +--------+---------+
                            |
                            | (1 to Many)
                            v
+-------------------------------------------------------+
|           Video_Streaming_Transaction_Fact            |
+-------------------------------------------------------+
| PK, FK: Customer_key                                  |
| PK, FK: Video_key                                     |
| PK, FK: Time_key                                      |
| Metrics: Minutes_Streamed, Pause_Count                |
+---------------------------+---------------------------+
                            ^
                            | (1 to Many)
                            |
                   +--------+---------+
                   |    Video_Dim     |
                   +------------------+
                   | PK: Video_key    |
                   +------------------+
                            ^
                            | (1 to Many)
                            |
                   +--------+---------+
                   |     Time_Dim     |
                   +------------------+
                   | PK: Time_key     |
                   +------------------+

                   ## Tech Stack
- **Database Engine:** Microsoft SQL Server (T-SQL)
- **Data Architecture:** Dimensional Modeling, OLAP Star Schema, Relational Integrity Constraints
- **Development Tools:** SQL Server Management Studio (SSMS)

## Repository File Structure
- `streaming_star_schema.sql` — Full DDL script containing table creation statements, primary keys, and foreign key constraints.
