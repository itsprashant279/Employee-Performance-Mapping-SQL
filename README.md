# Employee Database Management System — MySQL Project

A structured MySQL project that demonstrates core SQL concepts including database design,
querying, stored functions, indexing, and views using an employee dataset from a data science organization.

---

## 📁 Dataset

Three CSV files are imported into the `employee` database:

- **emp_record_table** — Core employee records
- **data_science_team** — Data science department employees
- **proj_table** — Project assignments

---

## 🗂️ ER Diagram

An Entity-Relationship diagram is included to visualize the relationships between the three tables.

---

## 📋 Queries Covered

### Basic Queries
- Fetch employee details (ID, name, gender, department)
- Filter employees by EMP_RATING (< 2, > 4, between 2 and 4)
- Concatenate first and last names for Finance department employees (aliased as `NAME`)

### Intermediate Queries
- Retrieve employees in leadership roles (Manager, President, CEO)
- List Healthcare and Finance employees using `UNION`
- Group employees by department with max rating per department
- Calculate minimum and maximum salary per role

### Advanced Queries
- Rank employees by experience using window functions
- Create a **View** for employees earning more than $6,000 by country
- Nested query to find employees with 10+ years of experience
- Calculate bonuses: `5% of salary × employee rating`
- Average salary distribution by continent and country

### Stored Function
Validates whether each data science team employee's job profile matches the standard:

| Experience       | Expected Role               |
|------------------|-----------------------------|
| ≤ 2 years        | Junior Data Scientist       |
| 2 – 5 years      | Associate Data Scientist    |
| 5 – 10 years     | Senior Data Scientist       |
| 10 – 12 years    | Lead Data Scientist         |
| 12 – 16 years    | Manager                     |

### Indexing
Created an index on `FIRST_NAME` in the employee table to optimize query performance,
with before/after execution plan analysis.

---

## 🛠️ Concepts Used

- DDL & DML (CREATE, INSERT, SELECT)
- Filtering with WHERE, BETWEEN, comparison operators
- String functions (`CONCAT`)
- `UNION`
- Aggregate functions (`MIN`, `MAX`, `AVG`)
- `GROUP BY`
- Window functions (`RANK`)
- Views
- Subqueries / Nested queries
- Stored Functions
- Indexing & Execution Plans

---

## 🚀 How to Run

1. Install [MySQL](https://dev.mysql.com/downloads/) or use MySQL Workbench
2. Create the database:
```sql
   CREATE DATABASE employee;
   USE employee;
```
3. Import the CSV files into the respective tables
4. Run the SQL scripts in order

---

## 📌 Tools Used

- MySQL / MySQL Workbench
- CSV data files (provided in `/data` folder)
