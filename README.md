# hr-analytics-manufacturing-project
SQL + Power BI HR Analytics project
# HR Analytics — Manufacturing Company

A real-time Data Analyst project analyzing HR data of a Tamil Nadu manufacturing company using **MySQL** and **Power BI**. The project covers employee attrition, absenteeism, payroll, and performance analysis across 1,450 employees.

## 📊 Project Overview

This project analyzes 6 interconnected datasets to answer key business questions:
- Where is attrition and absenteeism highest?
- How is payroll cost distributed?
- Is there a relationship between performance and attendance?

## 🛠️ Tools Used
- **MySQL** — Database design, data cleaning, and 30+ SQL queries
- **Power BI** — 4-page interactive dashboard
- **Excel** — Initial data inspection

## 🗂️ Dataset
6 tables, linked by `employee_id`:
- `employees` — 1,450 records (department, position, salary, join/end date)
- `attendance` — Daily attendance status and hours worked
- `bonuses` — Festival bonus payouts
- `deductions` — Monthly PF, insurance, pension deductions
- `performance_reviews` — Employee ratings and review comments
- `leave_balance` — Earned leave balance per employee

## 📈 Dashboard Pages
1. **Overview** — Headcount, gender split, department distribution
2. **Attrition & Absenteeism** — Attendance trends, status breakdown
3. **Payroll & Bonus** — Deduction totals, festival bonus comparison, PF trend
4. **Performance Analysis** — Rating distribution, department-wise averages

## 🔍 Key Insights
- 964 of 1,450 employees are currently active (66.5%)
- Present rate is 84.97%, indicating healthy overall attendance
- Administration department shows higher absenteeism than other departments
- Provident Fund is the largest payroll deduction (₹441.13M total)
- Diwali bonus payout is higher than Pongal bonus
- Performance ratings are fairly consistent across all departments

## 📁 Repository Structure
- sql/01_create_tables.sql - Database schema
- sql/02_analysis_queries.sql - All SQL queries
- Screenshots - Dashboard page images

## Dashboard Screenshots
See the screenshot files in this repository for all 4 dashboard pages.

Built as a self-driven Data Analyst portfolio project.
