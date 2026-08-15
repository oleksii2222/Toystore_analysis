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

```text
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
      ↓
💡 Business Insights
