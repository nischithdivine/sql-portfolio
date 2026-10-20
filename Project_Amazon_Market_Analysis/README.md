# Amazon Brazil → India Market Analysis using SQL

End-to-end SQL analysis of Brazilian e-commerce data (customers, orders, products, sellers, payments) to find patterns that could guide Amazon India's strategy.

---

## Problem

Brazil and India are both large, diverse, price-sensitive markets. The goal is to learn from Brazilian e-commerce behaviour (payments, products, customers, seasons) and turn it into ideas for Amazon India.

**Questions answered**
- Which payment methods do customers use, and does that change with order value?
- Which product categories drive revenue, and how much do prices vary?
- How many customers come back, and how can they be segmented?
- Which months and seasons sell the most?

---

## Data

Six related tables, about 99,000 orders placed between September 2016 and October 2018:

| Table | Rows | What it holds |
|---|---|---|
| Customers | 99,441 | Customer IDs and location (zip prefix) |
| Orders | 99,441 | Order status and timestamps |
| Order Items | 112,650 | Price, freight, product and seller per item |
| Payments | 103,886 | Payment type, instalments and value |
| Product | 32,951 | Category and physical specs |
| Sellers | 3,095 | Seller IDs and location |

Schema:
<img width="2254" height="1418" alt="Schema of the six tables" src="https://github.com/user-attachments/assets/90c05ef3-78b2-4feb-9be4-4f963ac75610" />

---

## Approach

### Analysis I — Basic SQL
- Rounded average payment values
- Share of orders by payment type
- Products filtered by price range and keyword
- Monthly sales trends
- Price variation across categories
- Payment consistency using standard deviation

### Analysis II — Joins and segmentation
- Payment behaviour by order-value segment
- Price range and average price by category
- Repeat customers
- Customer segments (new, returning, loyal)
- Top revenue categories

### Analysis III — Advanced SQL
- Seasonal sales comparison
- Products selling above the average
- Monthly revenue trends
- Customer segmentation with CTEs
- Top customer ranking
- Cumulative sales with a recursive CTE
- Month-over-month growth by payment method

---

## Key results

| Question | Result |
|---|---|
| Payment methods | Credit card 73.9% · boleto (bank slip) 19.0% · voucher 5.6% · debit card 1.5% |
| Average payment value | 154.10 Brazilian real per payment |
| Revenue concentration | 17 of 78 categories make 80% of item revenue |
| Top categories by revenue | Health & beauty 9.4% · watches & gifts 9.0% · bed, bath & table 7.7% · sports & leisure 7.4% · computer accessories 6.8% |
| Repeat customers | Only 3.3% of 95,077 customers ordered more than once |
| Busiest month | November 2017 (7,544 orders), followed by January 2018 and March 2018 |

---

## Insights

- **A few categories carry the business.** About a fifth of categories bring in 80% of revenue, so assortment and promotion effort should focus there.
- **Credit cards dominate, but offline-style payment matters.** About 1 in 5 payments uses boleto, a local bank-slip method. Local payment options clearly matter; in India the equivalents would be UPI and cash on delivery.
- **Retention is the biggest gap.** With only 3.3% of customers coming back, growth depends almost entirely on new customers. A loyalty programme has a lot of room to improve this.
- **Seasonality is real.** The November peak lines up with Black Friday promotions.

---

## What this suggests for Amazon India

- Push local and flexible payment methods, not just cards
- Concentrate promotions on the few categories that drive revenue
- Invest in repeat purchase and loyalty, the weakest area in this data
- Plan inventory and campaigns around festive peaks

---

## Limitations

- Brazilian data: culture, competition and payment habits in India differ.
- The first and last months of the period have very few orders, so monthly trends at the edges are unreliable.
- Revenue here is item price only; freight and returns are not included.
- Category names are in Portuguese in the raw data (translated above).
- Historical data, so it shows what happened, not why.

---

## Tools

PostgreSQL (pgAdmin) · SQL: joins, CTEs, window functions, recursive CTE · Excel for some charts
