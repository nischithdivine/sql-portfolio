# US Hospital Quality Analysis using SQL

> **End-to-End SQL Analysis of US Hospital Performance, Safety Metrics, and Quality Ratings** 📊

---

## Project Overview
This project involves analyzing the **US Hospital General Information** dataset to understand facility performance, patient safety patterns, and overall quality trends across the country. 

The United States healthcare system is massive and diverse. The goal of this analysis is to evaluate how different types of hospitals operate, identify regional strengths, and uncover what differentiates top-tier facilities from the rest.

---

## Problem Statement
The main goal is to analyze different parts of the hospital data—such as overall ratings, mortality, safety, and readmission measures—to identify patterns that can help healthcare administrators and policymakers make better decisions.

**Key questions we are trying to answer:**
* Which regions or states have the best safety records?
* How does hospital ownership (Government, Non-Profit, Proprietary) impact overall quality?
* Do hospitals with higher patient volumes struggle more with quality ratings?
* Which facilities qualify as "elite" multi-metric performers?

---

## Dataset
The dataset consists of a comprehensive flat file containing national hospital metrics:

**Overview of the Schema**
The `hospital_info` table provides insights into the operations of US hospitals:
* **Facility Information:** Holds basic information, including unique identifiers, state, and county, to study regional distribution.
* **Categorization:** Captures details about `Hospital Type`, `Hospital Ownership`, and `Emergency Services` availability.
* **Overall Ratings:** Contains the 1-to-5 star `overall_rating` for holistic facility evaluation.
* **Domain Metrics:** Provides specific counts of "Better", "Worse", and "No Different" measures across four key domains: **Mortality (MORT)**, **Safety**, **Readmission (READM)**, and **Patient Experience (Pt Exp)**.

> **Note on Data Quality:** *The raw dataset contained missing numeric values coded as the text string `'Not Available'`, requiring dynamic data cleaning during SQL querying.*

---

## Tools & Technologies
* **Database:** PostgreSQL (pgAdmin / SQL Server compatible)
* **Language:** SQL (Data Cleaning, Joins, CTEs, Window Functions)
* **Documentation:** Markdown (for reporting and GitHub presentation)

---

## Analysis Approach
The analysis is divided into 3 parts based on SQL complexity:

### Analysis I (Basic SQL - Filtering & Aggregation)
* State distribution of total hospital counts.
* Service availability (Emergency Services) by hospital type.
* Filtering facilities with perfect 5-star overall ratings.

### Analysis II (Intermediate SQL - Groupings & Ratios)
* Average overall ratings grouped by hospital ownership type.
* Percentage of 'Birthing Friendly' facilities per ownership category.
* Identifying hospitals with negative mortality measure imbalances.
* Top 5 states with the highest average "Better" safety measures.
* *Techniques used: On-the-fly cleaning using `NULLIF()` and `CAST()`, `CASE WHEN` statements.*

### Analysis III (Advanced SQL - Window Functions & Benchmarking)
* State-by-state ranking of top 3 hospitals using `DENSE_RANK()`.
* Calculating custom composite "Safety Scores" for national rankings.
* Peer Group Benchmarking: Comparing individual hospitals to their specific ownership group averages.
* Volume vs. Quality: Segmenting readmission volumes into quartiles using `NTILE()`.
* Identifying "Elite" multi-metric facilities using `CROSS JOIN` to establish national averages.

---

## Key Insights
* **Regional Safety Leaders:** Certain states, like New Jersey (NJ), lead the nation in average "Better" safety measures, indicating stronger standardized safety protocols in those regions.
* **Ownership Impacts Quality:** Non-profit and Government-operated hospitals display different baselines for consistent patient satisfaction and overall ratings compared to proprietary networks.
* **Volume Challenges:** Facilities in the highest volume quartile for readmissions face unique challenges in maintaining top-tier overall ratings compared to specialized, lower-volume facilities.
* **The "Elite" Performers:** A highly exclusive group of hospitals managed to score above the national average in Mortality, Safety, *and* Readmissions simultaneously, proving that excellence in one area does not have to come at the expense of another.

---

## Business Impact
* Helps healthcare administrators understand national benchmarks and peer performance.
* Supports regional expansion or resource-allocation planning for hospital networks.
* Improves understanding of how volume and ownership structures affect patient outcomes.
* Enables targeted improvements in specific domains (like Mortality or Safety) for underperforming facilities.

---

## Limitations
* The raw data contained `"Not Available"` values, meaning some hospitals were excluded from specific mathematical averages.
* The analysis is based on historical, aggregated snapshot data rather than real-time, granular patient-level data.
* External factors like local demographics, funding, and state-specific healthcare laws are not included in this dataset.

---

## Conclusion
This analysis gives useful insights into how US hospitals perform and what quality metrics define top-tier facilities. Even though healthcare is complex, many patterns—like the impact of ownership models and regional safety protocols—can be used as a reference to improve administrative decisions. Some metrics may not capture the full picture, but overall, it gives a strong direction for quality improvement.

---

## Final Note
This project helped me understand how to work with messy, real-world datasets using SQL. I learned how to clean text data on the fly so it doesn't break aggregate functions, and how to connect complex data analysis (using CTEs and Window Functions) with real healthcare business problems. Still learning and improving more!
