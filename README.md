# Supply Chain Inventory Replenishment & Analytics System

##  Project Overview

This project analyzes retail inventory, sales, stock-out situations, and replenishment priorities using data analytics tools.

The goal is to identify high-value products, detect out-of-stock issues, analyze sales performance, and support better inventory replenishment decisions.

##  Tools & Technologies

- Microsoft Excel / Google Sheets
- PostgreSQL / pgAdmin
- Python / Pandas / Matplotlib
- Power BI
- GitHub

##  Power BI Dashboard

![Supply Chain Inventory Dashboard](06_Screenshots/PowerBI_Dashboard.png)
##  Dataset

The project uses the Retail Store Inventory and Demand Forecasting dataset.

The dataset contains 76,000 inventory records covering:

- 20 products
- Multiple stores
- Product categories
- Regions
- Inventory levels
- Units sold
- Units ordered
- Prices
- Discounts
- Promotions
- Weather conditions
- Demand

##  Key Analysis Performed

### Excel

- Data cleaning and validation
- Duplicate and missing-value checks
- Sales value calculation
- Out-of-stock analysis
- Days of Inventory (DOI) calculation
- FIFO priority identification
- Replenishment status classification
- ABC analysis

### SQL

- Total sales and units sold analysis
- Sales by product, category, and region
- Out-of-stock analysis
- Product-level replenishment priority
- JOIN operations
- Aggregation and filtering using PostgreSQL

### Python

- Dataset analysis using Pandas
- Sales analysis
- Product and category analysis
- Regional analysis
- Out-of-stock analysis
- Replenishment priority analysis
- Data visualization using Matplotlib

### Power BI

Interactive dashboard containing:

- Total Sales
- Total Units Sold
- OOS Records
- OOS Percentage
- High Priority Products
- Sales by Category
- Sales by Region
- Top 5 Products by Sales
- OOS Records by Product
- OOS Percentage by Product
- Category, Region, and Date filters

##  Key Business Insights

- Total Sales Value: 455.30M
- Total Units Sold: 6,750,876
- Out-of-Stock Records: 406
- Overall OOS Percentage: 0.53%
- High Priority Products: 3
- Groceries generated the highest category sales.
- North generated the highest regional sales.
- P0014 was the highest-selling product.
- P0016 had the highest out-of-stock percentage.

##  Business Objective

The analysis helps businesses:

- Identify products requiring urgent replenishment
- Reduce stock-out situations
- Prioritize high-value products
- Understand sales performance
- Improve inventory planning
- Support data-driven supply chain decisions

##  Project Structure

```text
Supply-Chain-Inventory-Replenishment-Analytics/
│
├── 02_Excel/
├── 03_SQL/
├── 04. Python/
├── 05_PowerBI/
├── 06_Screenshots/
└── README.md

##  Author
Ishwari Shahane
Data Analytics Project
