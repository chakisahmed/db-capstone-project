## Little Lemon Capstone — Setup & Files

This project contains:
- MySQL database schema + SQL scripts (views, procedures, prepared statements)
- A Python notebook demonstrating database queries
- Tableau workbook + exported charts/dashboards
- MySQL Workbench data model files

---

## Repository contents (what each file is)

### Database (MySQL)
- `LittleLemonDB.sql` — creates the **LittleLemonDB** schema and tables
- `views.sql` — creates project views
- `procedures.sql` — creates stored procedures (if required by your capstone section)
- `prepared_statements.sql` — prepared-statement queries used in the project / practice

### Python (Database Client)
- `mysql_client.ipynb` — connects to MySQL and runs the required queries:
  - Task 1: connect + cursor
  - Task 2: `SHOW TABLES`
  - Task 3: JOIN query for customers with orders `TotalCost > 60`

### Tableau (Analytics)
- `analytics-capstone.twb` — Tableau workbook
- `~analytics-capstone__7792.twbr` — Tableau packaged workbook (if your Tableau version exported it)

Exports (images):
- `Cuisine Sales and Profits.png`
- `Profit chart.png`
- `Sales Bubble Chart.png`
- `bar chart.png`
- `dashboard.png`

### Data model (MySQL Workbench)
- `data_model.mwb` / `data_model.mwb.bak` — Workbench model
- `datamodel.png`, `LittleLemonDM.png` — exported diagrams/screenshots

---

## Setup (Local MySQL Workbench)

### 1) Create the database & tables
1. Open MySQL Workbench
2. Run:
   - `LittleLemonDB.sql`

### 2) Create views (if required / included in grading)
Run:
- `views.sql`

### 3) Create stored procedures (optional unless required by your rubric)
Run:
- `procedures.sql`

### 4) (Optional) Prepared statements
Run:
- `prepared_statements.sql`

> Note: If your `orders` table is empty, insert a small sample dataset (customer + order + orderitems)
> so the JOIN query in the notebook returns at least one row for reviewers.

---

## Run the Python notebook (Queries exercise)

1. Install dependency:
```bash
pip install mysql-connector-python
