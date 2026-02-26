## 🍕 Pizza Sales SQL Analytics

*A Hands-on SQL Project on the IDC Pizza Sales Dataset*

Welcome to the **Pizza Sales SQL Analytics** project.  
This mini-project showcases a complete SQL-driven analysis of a pizza sales database, focusing on data inspection, exploration, and core business insights using clean, well-structured SQL queries.

The project is organized into **3 analytical phases + additional business insights**, all implemented in a single, production-ready SQL script: [`Pizza analysis.sql`](Pizza%20analysis.sql).

---

## 📂 Project Overview

This project is designed for practicing and showcasing:

- Relational querying on transactional sales data.
- Data inspection and quality checks (NULLs, missing prices, basic profiling).
- Filtering and conditional logic across dates, times, prices, and text fields.
- Joins across multiple tables to derive revenue and category-level metrics.
- Aggregations and group-level analysis (SUM, AVG, HAVING).
- Business-focused insights such as top sellers and high-performing categories.

The entire analysis is written in **SQL (MySQL-compatible)** and is suitable for portfolio demonstration or learning advanced querying patterns.

---

## 🗃️ Dataset Structure

The analysis assumes a pizza sales schema with four main tables:

**1. `pizza_types`** — Contains base information about each pizza type:
- `pizza_type_id`
- `name`
- `category`
- `ingredients`

**2. `pizzas`** — Links pizza types to their sizes and prices:
- `pizza_id`
- `pizza_type_id`
- `size`
- `price`

**3. `orders`** — Captures order-level metadata:
- `order_id`
- `date`
- `time`

**4. `order_details`** — Stores line-item details for each order:
- `order_details_id`
- `order_id`
- `pizza_id`
- `quantity`

---

## 🎯 Phase 1: Foundation & Inspection

**Focus:** Initial data understanding, structure checks, and basic data quality validation.

Key queries in this phase:

1. **Select active database and inspect categories**
   - Use `USE PIZZA;` to select the working database.
   - List all unique pizza categories using `SELECT DISTINCT category FROM pizza_types;`.

2. **Inspect pizza type metadata with NULL handling**
   - Display `pizza_type_id`, `name`, and `ingredients`.
   - Replace missing ingredients with `"MISSING DATA"` using `COALESCE` and preview the first 5 rows.

3. **Check for missing price data**
   - Identify pizzas where `price IS NULL` to detect potential data quality issues.

This phase ensures you understand the schema and highlights any incomplete or inconsistent entries before deeper analysis.

---

## 🔍 Phase 2: Filtering & Exploration

**Focus:** Applying filters on dates, prices, sizes, names, and time-of-day to explore behavioral patterns.

Representative queries include:

- **Date-based order retrieval**
  - Fetch all orders placed on a specific date such as `'2015-01-01'`.

- **Price-based exploration**
  - List all pizzas ordered by price in descending order.
  - Retrieve pizzas priced between `15.00` and `17.00` using `BETWEEN`.

- **Size and name-based filters**
  - Select pizzas available only in `L` or `XL` sizes.
  - Search for pizza types with `"CHICKEN"` in the name using `LIKE`.

- **Date and time logic**
  - Retrieve orders placed on `'2015-02-15'` or those placed after a given evening time threshold (e.g., 8 PM).

This phase reveals how customers interact with different pizza sizes, price ranges, and specific product names over particular dates and times.

---

## 📊 Phase 3: Sales Performance & Metrics

**Focus:** Quantifying performance using aggregations, joins, and grouped metrics.

Core analyses:

1. **Total quantity of pizzas sold**
   - Compute global sales volume using `SUM(quantity)` on `order_details`.

2. **Average pizza price**
   - Calculate the overall average price across all pizzas using `AVG(price)`.

3. **Order-level revenue calculation**
   - Join `orders`, `order_details`, and `pizzas` to compute `price * quantity` per line and sum at the `order_id` level.

4. **Category-wise quantity sold**
   - Join `order_details` → `pizzas` → `pizza_types` and aggregate total quantity by `category`.

5. **High-performing categories (volume threshold)**
   - Apply `HAVING` to filter categories with more than 5,000 units sold.

6. **Unordered pizzas (zero-demand items)**
   - Use a `LEFT JOIN` between `pizzas` and `order_details` to find pizzas that were never ordered.

7. **Price differences across sizes (self-join)**
   - Perform a self-join on `pizzas` by `pizza_type_id` to measure the price difference between the smallest and largest sizes per pizza type.

These queries answer questions about market leaders, underperforming items, and pricing consistency across sizes.

---

## ➕ Additional Business Insights

Beyond the core phases, the script includes targeted business questions to translate raw data into actionable insight:

1. **Highest revenue-generating pizza category**
   - Aggregates `price * quantity` by `category` and returns the top revenue contributor.

2. **Top 5 best-selling pizza types (by quantity)**
   - Ranks pizza types by total quantity sold and returns the top five performers.

3. **Revenue contribution by size**
   - Groups revenue by `size` to determine which sizes drive the most sales value.

4. **Average Order Value (AOV)**
   - Computes order-level totals, then calculates the average of these totals to derive AOV using a subquery.

These additional insights bring a strong business analytics flavor, allowing stakeholders to reason about category strategy, assortment optimization, and pricing impacts.

---

## ⭐ Key Analytical Themes

From the queries in [`Pizza analysis.sql`](Pizza%20analysis.sql), the project emphasizes:

- Clean inspection of categories, prices, and ingredient data using `DISTINCT`, `COALESCE`, and `IS NULL`.
- Rich filtering logic with `WHERE`, `IN`, `BETWEEN`, `LIKE`, and time-based conditions.
- Robust multi-table joins (`INNER`, `LEFT`, self-join) for revenue and category analysis.
- Aggregations and `HAVING` for segment-level performance evaluation.
- Business KPI calculations such as total quantity, revenue by category/size, and AOV.
- Identification of zero-demand products and price spread across sizes to guide menu and pricing decisions.

---

## 🛠️ Tech Stack

- **SQL (MySQL-style syntax)** for all querying and analytics.
- **Relational schema design concepts** (dimension and fact style tables).
- **Data quality handling** with NULL-safe operations.
- **Analytical SQL patterns** involving joins, aggregations, and subqueries.

---

## 🚀 How to Use This Project

1. Set up a MySQL-compatible environment and create the `PIZZA` database with the described tables.
2. Load your pizza sales data using the provided SQL and CSV files into `pizza_types`, `pizzas`, `orders`, and `order_details` tables.
3. Run the [`Pizza analysis.sql`](Pizza%20analysis.sql) script in your SQL client (e.g., MySQL Workbench, DBeaver, VS Code with SQL extension).
4. Review query outputs phase by phase to understand structure, exploration, and performance insights.
5. Extend the script with your own custom questions, visualizations, or dashboard connectors.

---

## 📎 File Overview

| File | Description |
|------|-------------|
| [`Pizza analysis.sql`](Pizza%20analysis.sql) | Main analysis script containing all phases and business insight queries |
| [`create_table.sql`](create_table.sql) | SQL script to create all required database tables |
| [`pizza_types.sql`](pizza_types.sql) | SQL insert statements for the `pizza_types` table |
| [`pizza_types.csv`](pizza_types.csv) | CSV data file for the `pizza_types` table |
| [`pizzas.sql`](pizzas.sql) | SQL insert statements for the `pizzas` table |
| [`pizzas.csv`](pizzas.csv) | CSV data file for the `pizzas` table |
| [`orders.sql`](orders.sql) | SQL insert statements for the `orders` table |
| [`orders.csv`](orders.csv) | CSV data file for the `orders` table |
| [`order_details.sql`](order_details.sql) | SQL insert statements for the `order_details` table |
| [`order_details.csv`](order_details.csv) | CSV data file for the `order_details` table |

---

If you like this project, consider ⭐ starring it on GitHub and adapting the queries to your own sales datasets for further experimentation.
