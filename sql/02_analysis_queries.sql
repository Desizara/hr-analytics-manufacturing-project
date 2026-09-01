-- ==========================================
-- BASIC QUERIES
-- ==========================================

-- Total employee count
SELECT COUNT(*) AS total_employees FROM employees;

-- Active vs Left employees
SELECT
  SUM(CASE WHEN end_date IS NULL THEN 1 ELSE 0 END) AS active_count,
  SUM(CASE WHEN end_date IS NOT NULL THEN 1 ELSE 0 END) AS left_count
FROM employees;

-- Department-wise headcount
SELECT department, COUNT(*) AS headcount
FROM employees
GROUP BY department
ORDER BY headcount DESC;

-- Gender distribution
SELECT gender, COUNT(*) AS cnt
FROM employees
GROUP BY gender;

-- 2024 Attendance status distribution
SELECT status, COUNT(*) AS days
FROM attendance
WHERE YEAR(`date`) = 2024
GROUP BY status
ORDER BY days DESC;

-- ==========================================
-- INTERMEDIATE QUERIES
-- ==========================================

-- Annual attrition count
SELECT YEAR(end_date) AS yr, COUNT(*) AS left_cnt
FROM employees
WHERE end_date IS NOT NULL
GROUP BY YEAR(end_date)
ORDER BY yr;

-- Department-wise average leave balance
SELECT e.department, ROUND(AVG(lb.earned_leave_balance),2) AS avg_el_balance
FROM leave_balance lb
JOIN employees e ON e.employee_id = lb.employee_id
GROUP BY e.department
ORDER BY avg_el_balance DESC;

-- Department-wise 2024 absenteeism rate
WITH dept_days AS (
  SELECT e.department, COUNT(*) AS total_days
  FROM attendance a
  JOIN employees e ON e.employee_id = a.employee_id
  WHERE YEAR(a.`date`) = 2024
  GROUP BY e.department
),
dept_absent AS (
  SELECT e.department, COUNT(*) AS absent_days
  FROM attendance a
  JOIN employees e ON e.employee_id = a.employee_id
  WHERE YEAR(a.`date`) = 2024 AND a.status IN ('Absent','LOP')
  GROUP BY e.department
)
SELECT d.department,
       ROUND(100.0 * COALESCE(ab.absent_days,0)/d.total_days, 2) AS absenteeism_pct
FROM dept_days d
LEFT JOIN dept_absent ab ON ab.department = d.department
ORDER BY absenteeism_pct DESC;

-- ==========================================
-- ADVANCED QUERIES
-- ==========================================

-- Monthly salary estimate from PF (PF = 12% of salary)
SELECT `year_month`,
       ROUND(AVG(provident_fund/0.12),2) AS est_avg_monthly_salary
FROM deductions
GROUP BY `year_month`
ORDER BY `year_month`;

-- Cohort retention analysis by join year
WITH cohort AS (
  SELECT YEAR(join_date) AS join_year, COUNT(*) AS cohort_size
  FROM employees
  GROUP BY YEAR(join_date)
),
retained AS (
  SELECT YEAR(join_date) AS join_year, COUNT(*) AS retained_cnt
  FROM employees
  WHERE end_date IS NULL OR end_date > '2024-12-31'
  GROUP BY YEAR(join_date)
)
SELECT c.join_year, c.cohort_size, COALESCE(r.retained_cnt,0) AS retained,
       ROUND(100.0 * COALESCE(r.retained_cnt,0)/c.cohort_size,2) AS retention_pct
FROM cohort c
LEFT JOIN retained r USING (join_year)
ORDER BY c.join_year;

-- ==========================================
-- COMPLEX QUERIES
-- ==========================================

-- 2024 Top 10 overtime hours
SELECT employee_id, SUM(GREATEST(0, hours_worked-8)) AS overtime_hours
FROM attendance
WHERE YEAR(`date`)=2024
GROUP BY employee_id
ORDER BY overtime_hours DESC
LIMIT 10;

-- 2024 Attendance compliance index
SELECT employee_id,
       ROUND((SUM(CASE WHEN status='Present' THEN 1 WHEN status='Half-Day' THEN 0.5 ELSE 0 END)
              / COUNT(*))*100, 2) AS compliance_index
FROM attendance
WHERE YEAR(`date`)=2024
GROUP BY employee_id
ORDER BY compliance_index DESC
LIMIT 10;
