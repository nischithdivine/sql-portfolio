# amazon-cross-market-business-analysis-using-SQL
End-to-End SQL Analysis of Amazon Brazil Data for Customer Behavior, Sales Trends, and Market Adaptation in India

# 📊 Amazon Brazil to India Market Analysis

## Project Overview

This project is about analyzing Amazon Brazil data to understand customer behaviour, sales patterns and business trends, and then using those insights for improving Amazon India strategy.

Amazon Brazil and India are kind of similar in terms of large population and diverse customers, so idea is to see what is working there and how it can be used in India market also.

---

## Problem Statement

The main goal is to analyze different parts of Amazon Brazil operations like customers, orders, products, sellers and payments to identify patterns which can help Amazon India take better decisions.

We are trying to answer things like:

* How customers are behaving
* Which products are performing well
* What payment methods are popular
* Which regions have more activity

---

## Dataset

The dataset consists of multiple tables:

Overview of the Schema
The schema consists of seven interconnected tables that provide insights into the operations of Amazon Brazil:
**Customers**: Holds customer information, including unique identifiers and locations, to study customer demographics and behavior.
**Orders**: Captures details about each order, such as order status and timestamps, essential for tracking the order lifecycle.
**Order Items**: Lists each item in an order with details like price, seller, and shipping information.
**Product**: Contains product specifications, such as category, size, and weight, for product-level analysis.
**Seller**: Provides data about sellers, including their location and unique identifiers, to evaluate seller performance.
**Payments**: Records transaction details, such as payment type and value, to understand payment preferences and financial performance.

Schema
<img width="2254" height="1418" alt="image" src="https://github.com/user-attachments/assets/90c05ef3-78b2-4feb-9be4-4f963ac75610" />

---

## Tools & Technologies

* PostgreSQL (pgAdmin)
* SQL (Joins, CTEs, Window Functions)
* Excel (for visualization in some parts)

---

## Analysis Approach

The analysis is divided into 3 parts:

---

### Analysis I (Basic SQL)

* Rounded average payment values
* Percentage of orders by payment type
* Product filtering based on price and keyword
* Monthly sales trends
* Price variation across categories
* Payment consistency using standard deviation

---

### Analysis II (Joins & Segmentation)

* Payment behavior across order value segments
* Category-wise price analysis
* Identifying repeat customers
* Customer segmentation (New, Returning, Loyal)
* Top revenue generating categories

---

### Analysis III (Advanced SQL)

* Seasonal sales analysis
* Product performance vs average
* Monthly revenue trends
* Customer segmentation using CTE
* Top customers ranking
* Cumulative sales using recursive CTE
* Month-over-month growth by payment method

---

## Key Insights

* Few product categories contribute most of the revenue (Pareto effect)
* Payment preferences vary based on order value
* Loyal customers contribute significantly to sales
* Some regions have higher customer density and activity
* Seasonal trends affect sales performance

---

## Business Impact

* Helps Amazon India understand customer behavior better
* Supports targeted marketing strategies
* Improves product and pricing decisions
* Helps in identifying high-value customers
* Enables better regional expansion planning

---

## Limitations

* Data is from Brazil, so not everything may apply exactly to India
* Some external factors like culture, competition are not included
* Analysis is based on historical data only

---

## Conclusion

This analysis gives useful insights into how Amazon Brazil operates and what strategies are working there.

Even though markets are different, many patterns can still be used as a reference to improve Amazon India business decisions. Some things may not be perfect but overall it gives a strong direction.

---

## Final Note

This project helped me understand how to work with large(1L rows) relational datasets using SQL and how to connect data analysis with real business problems. Still learning and improving more.

---
