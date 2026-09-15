
import pandas as pd

print("Pandas version:", pd.__version__)
print("Python + Pandas are working!")

import pandas as pd

# Load the inventory dataset
df = pd.read_csv("SQL_Data CSV.csv")

print("Dataset loaded successfully!")
print("Rows:", df.shape[0])
print("Columns:", df.shape[1])

import pandas as pd

# Load the dataset
df = pd.read_csv("SQL_Data CSV.csv")

# Display basic dataset information
print("Dataset Shape:", df.shape)

print("\nColumn Names:")
print(df.columns.tolist())

print("\nData Types:")
print(df.dtypes)


# Check for missing values
print("\nMissing Values:")
print(df.isnull().sum())

# Calculate Total Sales Value

df["Sales Value"] = df["Units Sold"] * df["Price"]

total_sales = df["Sales Value"].sum()

print("\nTotal Sales Value:", round(total_sales, 2))


# Top 5 Products by Sales

top_products = (
    df.groupby("Product ID")["Sales Value"]
    .sum()
    .sort_values(ascending=False)
    .head(5)
)

print("\nTop 5 Products by Sales:")
print(top_products)

# Sales by Category
category_sales = (
    df.groupby("Category")["Sales Value"]
    .sum()
    .sort_values(ascending=False)
)

print("\nSales by Category:")
print(category_sales)

# Sales by Region

region_sales = (
    df.groupby("Region")["Sales Value"]
    .sum()
    .sort_values(ascending=False)
)

print("\nSales by Region:")
print(region_sales)

# Out-of-Stock (OOS) Analysis
oos_records = (df["Inventory Level"] == 0).sum()
total_records = len(df)

oos_percentage = (oos_records / total_records) * 100

print("\nOut-of-Stock Analysis:")
print("OOS Records:", oos_records)
print("OOS Percentage:", round(oos_percentage, 2), "%")


# Replenishment Priority Analysis
product_analysis = (
    df.groupby("Product ID")
    .agg(
        total_sales=("Sales Value", "sum"),
        total_records=("Product ID", "count"),
        oos_records=("Inventory Level", lambda x: (x == 0).sum())
    )
)

product_analysis["oos_percentage"] = (
    product_analysis["oos_records"]
    / product_analysis["total_records"]
) * 100

product_analysis["replenishment_priority"] = product_analysis["oos_percentage"].apply(
    lambda x: "High Priority" if x >= 0.80
    else "Medium Priority" if x >= 0.50
    else "Low Priority"
)

product_analysis = product_analysis.sort_values(
    ["oos_percentage", "total_sales"],
    ascending=[False, False]
)

print("\nReplenishment Priority:")
print(
    product_analysis[
        ["total_sales", "oos_records", "oos_percentage", "replenishment_priority"]
    ].round(2)
)

# Identify High-Value Products Needing Attention

high_value_products = product_analysis[
    product_analysis["replenishment_priority"].isin(
        ["High Priority", "Medium Priority"]
    )
].sort_values("total_sales", ascending=False)

print("\nHigh-Value Products Needing Attention:")
print(
    high_value_products[
        ["total_sales", "oos_records", "oos_percentage", "replenishment_priority"]
    ].head(10).round(2)
)

# Visualize Top 5 Products by Sales

import matplotlib.pyplot as plt

top_products.plot(kind="bar", title="Top 5 Products by Sales")

plt.xlabel("Product ID")
plt.ylabel("Sales Value")
plt.xticks(rotation=0)
plt.tight_layout()
plt.show()