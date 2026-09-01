CREATE DATABASE IF NOT EXISTS tn_hr;
USE tn_hr;

CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  name VARCHAR(100),
  gender CHAR(1),
  state VARCHAR(50),
  department VARCHAR(50),
  position VARCHAR(50),
  base_salary DECIMAL(10,2),
  annual_increase_rate DECIMAL(5,4),
  join_date DATE,
  end_date DATE
);

CREATE TABLE attendance (
  employee_id INT,
  `date` DATE,
  status VARCHAR(20),
  hours_worked INT
);

CREATE TABLE bonuses (
  employee_id INT,
  festival VARCHAR(30),
  `date` DATE,
  amount DECIMAL(10,2)
);

CREATE TABLE deductions (
  employee_id INT,
  `year_month` VARCHAR(7),
  provident_fund DECIMAL(10,2),
  insurance DECIMAL(10,2),
  pension DECIMAL(10,2),
  other_deductions DECIMAL(10,2)
);

CREATE TABLE performance_reviews (
  employee_id INT,
  review_date DATE,
  rating DECIMAL(3,2),
  bonus DECIMAL(10,2),
  comments TEXT
);

CREATE TABLE leave_balance (
  employee_id INT,
  earned_leave_balance DECIMAL(5,2)
);
