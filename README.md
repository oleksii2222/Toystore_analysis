# 🧸 ToyStore Analysis

## 📊 Project Overview

This project presents an end-to-end data analysis of an online toy store.

The main goal of the project is to analyze sales, profitability, refunds, product performance, website activity, and customer behavior, and present the key findings in an interactive Power BI dashboard.

The project demonstrates a complete analytical workflow:

**Raw Data → SQL Server → Bronze Layer → Golden Layer → Python Analysis → Power BI**

---

## 🎯 Business Objectives

The analysis focuses on several key business questions:

- 💰 How much profit does the store generate?
- 🧸 Which products generate the highest profit?
- 🛒 Which products are ordered most frequently?
- 🔄 How significant are product refunds?
- 💻📱 How does profitability differ between desktop and mobile users?
- 📈 How does profit change over time?
- 📅 Are there seasonal patterns in profitability?
- 🌐 How do users move through the website funnel?
- 🚪 Where are the largest drop-offs in the customer journey?

---

## 🛠️ Tools & Technologies

- **SQL Server** — data storage, transformation, and preparation
- **SQL** — DDL, DML, JOINs, aggregations, and stored procedures
- **Python** — additional data analysis and transformation
- **pandas** — data manipulation and analysis
- **NumPy** — conditional transformations
- **SQLAlchemy** — connection between Python and SQL Server
- **pyodbc** — SQL Server connectivity
- **Power BI** — interactive dashboard and visualization
- **Excel** — intermediate analytical outputs
- **GitHub** — project version control and documentation

---

## 📂 Data Source

The dataset was provided by **Maven Analytics** and represents activity from an online toy store.

The dataset contains information about:

- 🛒 Orders
- 📦 Order items
- 🧸 Products
- 🔄 Refunds
- 🌐 Website sessions
- 👀 Website pageviews

The data was used as the source for the SQL Server data pipeline and subsequent analysis.

---

# 🔄 Data Pipeline

The project follows an end-to-end analytical workflow:

Raw CSV Files

      ↓
      
🥉 Bronze Layer

      ↓
      
🥇 Golden Layer

      ↓
      
🐍 Python Analysis

      ↓
      
📊 Analytical Tables

      ↓
      
📈 Power BI Dashboard

# 🗄️ SQL Server
## 🥉 Bronze Layer

The Bronze layer contains the raw data loaded from CSV files into SQL Server.

The main purpose of this layer is to preserve the original structure of the source data and provide a foundation for further transformations.

The Bronze layer contains tables for:

Orders
Order items
Order item refunds
Products
Website sessions
Website pageviews

The Bronze scripts are located in:

scripts/
└── bronze/
    ├── bronze_DDL.sql
    └── bronze_load.sql
bronze_DDL.sql

Creates the required Bronze layer tables.

bronze_load.sql

Loads the raw CSV data into the Bronze layer.

## 🥇 Golden Layer

The Golden layer contains transformed and business-oriented data prepared for analysis.

The main analytical tables created in this layer are:

golden.order_info

Combines information from:

- Orders
- Order items
- Refunds
- Products

This table is used for:

- 💰 Sales analysis
- 📈 Profit analysis
- 🧸 Product analysis
- 🔄 Refund analysis
- golden.website_visits

Combines website session and pageview information.

This table is used for:

🌐 Website activity analysis
🏠 Landing page analysis
🔽 Funnel analysis
💻📱 Desktop vs mobile analysis

The Golden scripts are located in:

scripts/
└── golden/
    ├── golden_DDL.sql
    └── golden_load_data.sql

## 🐍 Python Analysis

Python is used for additional transformations and analytical calculations after the data has been prepared in SQL Server.

The main Python script is:

scripts/python/tables.py

The script connects to SQL Server using SQLAlchemy and retrieves data from the Golden layer.

The analysis is performed using pandas and NumPy.

## 💰 Profit Analysis

The project calculates product-level profit using:

Item price
Cost of goods sold
Refund amount

The resulting data is used to analyze overall and product-level profitability.

## 🔄 Refund Analysis

The project analyzes refunds by product and calculates refund-related metrics.

This allows products with higher refund quantities and refund ratios to be identified.

## 🧸 Product Analysis

Products are analyzed based on:

Number of orders
Revenue
Profit
Refunds

This helps identify the products that contribute most to the store's performance.

## 💻📱 Desktop vs Mobile Analysis

The project compares website activity and profitability between:

- 💻 Desktop users
- 📱 Mobile users

This allows differences in customer behavior and profitability between device types to be identified.

## 🔽 Landing Page Funnel

Website pageviews are used to construct a simplified customer journey.

The main funnel stages are:

Landing
   ↓
Products
   ↓
Cart
   ↓
Checkout
   ↓
Purchase

Several landing pages are grouped into the Landing stage, while billing and shipping pages are combined into the Checkout stage.

The resulting funnel data is prepared for visualization in Power BI.


# 📊 Power BI Dashboard

The final analytical results are presented in an interactive Power BI dashboard.

The dashboard contains several key metrics and visualizations.

🎯 Main KPIs
💰 Total Profit

Shows the total profit generated by the store during the analyzed period.

🛒 Total Count of Sales

Shows the total number of sales analyzed.

## 📈 Profit Analysis
📅 Profit Seasonality

Shows how profit changes throughout the year and helps identify seasonal patterns.

💻 Profit from Desktop Users

Shows the development of profit generated by desktop users over time.

📱 Profit from Mobile Users

Shows the development of profit generated by mobile users over time.

## 🧸 Product Analysis
💰 Products by Profit

Compares products based on the amount of profit they generate.

🛒 Count Orders with Products

Shows the distribution of orders between different products.

## 🔽 Website Funnel

The website funnel focuses on the main stages of the customer journey:

Landing
   ↓
Products
   ↓
Cart
   ↓
Checkout
   ↓
Purchase

The funnel helps identify where users leave the website before completing a purchase.

💡 Key Findings

The analysis provides several important insights:

💰 Total profit reached approximately $1.16M during the analyzed period.
🧸 The Original Mr. Fuzzy generated the highest profit among the analyzed products.
💻 Desktop users generated significantly more profit than mobile users.
📅 Profit demonstrates noticeable seasonal variation throughout the year.
🔽 The website funnel shows a significant drop-off between the landing stage and subsequent product interactions.
🛒 The most frequently ordered product is not necessarily the most profitable product.

## 📁 Project Structure
ToyStore_analysis/
│
├── 📊 dashboard/
│   └── dashboard.pbix
│
├── 📂 datasets/
│   ├── cust_info.csv
│   ├── landing_funnels.xlsx
│   ├── order_info.csv
│   ├── orders_profit_usd.csv
│   └── product_info.xlsx
│
├── 🗄️ scripts/
│   │
│   ├── 🥉 bronze/
│   │   ├── bronze_DDL.sql
│   │   └── bronze_load.sql
│   │
│   ├── 🥇 golden/
│   │   ├── golden_DDL.sql
│   │   └── golden_load_data.sql
│   │
│   └── 🐍 python/
│       └── tables.py
│
└── 📖 README.md

# 🚀 How to Reproduce the Project
1️⃣ Prepare SQL Server

Create a SQL Server database named:

toystore
2️⃣ Create Bronze Tables

Run:

scripts/bronze/bronze_DDL.sql

This creates the Bronze layer tables.

3️⃣ Load Raw Data

Run:

scripts/bronze/bronze_load.sql

Before executing the script, update the CSV file paths according to your local environment.

4️⃣ Create Golden Tables

Run:

scripts/golden/golden_DDL.sql

This creates the Golden layer tables.

5️⃣ Load Golden Data

Run:

scripts/golden/golden_load_data.sql

This transforms and combines the Bronze data into analytical tables.

6️⃣ Run Python Analysis

Install the required Python packages:

pip install pandas numpy sqlalchemy pyodbc openpyxl

Then run:

python scripts/python/tables.py

The script retrieves data from SQL Server and performs additional analysis using pandas and NumPy.

7️⃣ Open Power BI

Open:

dashboard/dashboard.pbix

The Power BI dashboard contains the final visualizations and analytical results.

## 🧠 Skills Demonstrated
- SQL
- CREATE TABLE
- INSERT
- SELECT
- JOINs
- GROUP BY
- CASE WHEN
- Window functions
- Stored procedures
- Data transformation
- Database layering
- Data aggregation
  
## 🐍 Python
- pandas
- NumPy
- DataFrame transformations
- Grouping and aggregation
- Merging datasets
- Pivot tables
- Conditional calculations
- SQL Server integration

## 📊 Power BI
- KPI cards
- Line charts
- Funnel analysis
- Product analysis
- Time-series analysis
- Desktop vs mobile comparison
- Interactive filters
- Dashboard design

## 📈 Data Analytics
- Profitability analysis
- Product performance analysis
- Refund analysis
- Customer journey analysis
- Funnel analysis
- Time-series analysis
- Seasonality analysis
- KPI analysis

# 🎓 What I Learned

During this project, I practiced building a complete analytical workflow rather than performing analysis on a single prepared dataset.

The main areas of practical experience included:

- Designing SQL Server data layers
- Loading raw data into a Bronze layer
- Transforming data into a Golden analytical layer
- Combining multiple relational tables using SQL JOINs
- Creating analytical tables for reporting
- Connecting Python to SQL Server
- Using pandas for data transformation and aggregation
- Creating business-oriented metrics
- Preparing data for Power BI
- Building an interactive analytical dashboard
- Structuring and documenting a data analytics project on GitHub

# 🏁 Conclusion

This project demonstrates an end-to-end approach to data analysis, starting with raw CSV data and ending with an interactive business intelligence dashboard.

SQL Server was used for data storage and transformation, Python and pandas were used for additional analytical calculations, and Power BI was used to visualize the final results.

The project demonstrates how multiple analytical tools can be combined into a single data workflow:

SQL Server
     ↓
Data Transformation
     ↓
Python / pandas
     ↓
Analytical Tables
     ↓
Power BI
     ↓
Business Insights

The main objective was not only to create visualizations, but to build a complete analytical process from raw data to actionable business insights.

# 👨‍💻 Author

Oleksiy Radchenko

Junior Data Analyst

Skills: SQL | Python | pandas | Power BI | Excel

