# Retail Sales Analysis using SQL

## Project Overview

**Project Title**: Retail Sales Analysis
**Level**: Beginner → Intermediate
**Database**: `retail_sales_db`
**Tools Used**: MySQL

This project demonstrates practical SQL skills used by data analysts to **clean, explore, and analyze retail sales data**.
The project focuses on answering **real business questions** using SQL concepts such as **filtering, aggregation, joins, subqueries, window functions, and CASE statements**.

This project is suitable for **college placements, internships, and non-tech analyst roles**.

---

## Objectives

1. Create and structure a retail sales database
2. Perform **data cleaning and validation**
3. Conduct **exploratory data analysis (EDA)**
4. Solve **business-driven SQL problems**
5. Extract **meaningful insights** from sales data

---

## Project Structure

### 1. Database Setup

#### Database Creation

```sql
CREATE DATABASE retail_sales_db;
```

#### Table Creation

```sql
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(30),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

## 2. Data Exploration & Cleaning

### Total Records

```sql
SELECT COUNT(*) FROM retail_sales;
```

### Unique Customers

```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

### Unique Product Categories

```sql
SELECT DISTINCT category FROM retail_sales;
```

### Null Value Check

```sql
SELECT *
FROM retail_sales
WHERE sale_date IS NULL 
   OR sale_time IS NULL 
   OR customer_id IS NULL 
   OR gender IS NULL 
   OR age IS NULL 
   OR category IS NULL 
   OR quantity IS NULL 
   OR price_per_unit IS NULL 
   OR cogs IS NULL 
   OR total_sale IS NULL;
```

### Remove Incomplete Records

```sql
DELETE FROM retail_sales
WHERE sale_date IS NULL 
   OR sale_time IS NULL 
   OR customer_id IS NULL 
   OR gender IS NULL 
   OR age IS NULL 
   OR category IS NULL 
   OR quantity IS NULL 
   OR price_per_unit IS NULL 
   OR cogs IS NULL 
   OR total_sale IS NULL;
```

---

## 3. Data Analysis & Business Queries

### 1️⃣ Sales made on **2022-11-05**

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

---

### 2️⃣ Clothing transactions with quantity > 4 in **Nov 2022**

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 4
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

---

### 3️⃣ Total sales and order count per category

```sql
SELECT 
    category,
    SUM(total_sale) AS total_sales,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

---

### 4️⃣ Average age of customers purchasing **Beauty** products

```sql
SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

---

### 5️⃣ Transactions with total sale greater than 1000

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

---

### 6️⃣ Transactions by gender and category

```sql
SELECT 
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender;
```

---

### 7️⃣ Best selling month (average sales) for each year

```sql
SELECT year, month, avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM retail_sales
    GROUP BY year, month
) t
WHERE rnk = 1;
```

---

### 8️⃣ Top 5 customers by total sales

```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

### 9️⃣ Unique customers per category

```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

---

### 🔟 Orders by time-based shift

```sql
WITH shift_data AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM shift_data
GROUP BY shift;
```

---

## Findings

* **Clothing and Beauty** are among the highest-performing categories
* Certain months consistently show **higher average sales**
* A small group of customers contributes significantly to total revenue
* Evening hours have higher transaction volumes

---

## Conclusion

This project showcases **end-to-end SQL analysis**, from database creation to advanced analytical queries.
It demonstrates the ability to **think like a data analyst**, translate business problems into SQL, and extract actionable insights.

---

## How to Use

1. Import the SQL file into **MySQL Workbench**
2. Run database and table creation scripts
3. Execute analysis queries step by step
4. Modify queries to explore additional insights

---

## Author

**Harshit Kamra**
SQL & Data Analytics Enthusiast

This project is part of my portfolio showcasing **SQL skills for internships, placements, and analyst roles**.

---
