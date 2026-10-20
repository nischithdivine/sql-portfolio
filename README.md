# US Hospital Quality Analysis using SQL

End-to-end SQL analysis of US hospital ratings, safety, mortality and readmission measures, to find what separates strong hospitals from the rest.

---

## Problem

Healthcare administrators and policymakers need to know where quality is strong, where it is weak, and whether hospital type or ownership makes a difference.

**Questions answered**
- Which states have the most hospitals, and the best safety records?
- Does ownership (government, non-profit, for-profit) relate to overall rating?
- Do hospitals that report more readmission measures get lower ratings?
- Which hospitals beat the national average on mortality, safety *and* readmission at the same time?

---

## Data

- **Source:** US CMS *Hospital General Information* file, one flat table (`hospital_info`)
- **Size:** 5,432 hospitals, 38 columns
- **Key fields:** state, hospital type, ownership, emergency services, birthing-friendly designation, 1–5 star overall rating, and counts of "Better / No different / Worse" measures for Mortality (MORT), Safety, Readmission (READM) and Patient Experience
- **Data quality:** missing numbers are stored as the text `'Not Available'`. They are cleaned inside each query with `NULLIF()` and `CAST()`.
- **Important:** only **3,182 of 5,432** hospitals (59%) have an overall rating, so every rating average covers rated hospitals only.

---

## Approach

### Analysis I — Filtering and aggregation
- Hospitals per state (top 10)
- Emergency services by hospital type
- Hospitals with a perfect 5-star rating

### Analysis II — Grouping, ratios and cleaning
- Average rating by ownership
- % of birthing-friendly hospitals by ownership
- Hospitals with more "Worse" than "Better" mortality measures
- Rating distribution for acute care hospitals
- Top 5 states by average "Better" safety measures

### Analysis III — Window functions and benchmarking
- Top 3 hospitals per state with `DENSE_RANK()`
- Custom safety score = (Better − Worse) ÷ Total measures, minimum 5 measures
- Each hospital vs its ownership group's average (peer benchmarking)
- Readmission-measure quartiles with `NTILE(4)`
- "Elite" hospitals above the national average on all three domains, using a `CROSS JOIN` to national averages

---

## Key results

| Question | Result |
|---|---|
| Most hospitals | Texas 468, California 378, Florida 221, Ohio 196, Illinois 194 |
| Emergency services | 2,838 acute care and 1,339 critical access hospitals offer them |
| 5-star hospitals | 384 |
| Average rating by ownership | Veterans Health 4.16 (112 rated) · Voluntary non-profit 3.31 (2,085) · Government 2.91 (460) · Proprietary 2.80 (504) |
| Birthing-friendly share | Highest for church non-profits (60.1%); lowest for government-state (14.8%) |
| More "Worse" than "Better" mortality measures | 447 hospitals |
| Best average "Better" safety measures | New Jersey 1.79 (62 hospitals), Connecticut 1.69, Florida 1.58 |
| Rating by readmission-measure quartile | 3.25 · 3.18 · 3.19 · 3.19: almost no difference |
| "Elite" on all three domains | 287 hospitals |

---

## Insights

- **Ownership matters.** Veterans Health hospitals score about 1.4 stars higher than for-profit hospitals on average, and non-profits score about 0.5 higher than for-profits.
- **Reporting more readmission measures does not mean a lower rating.** The quartiles are nearly flat. Note: this column counts how many measures a hospital reports, not how many patients it treats, so it is not a measure of patient volume.
- **Safety leaders are a small group of states.** New Jersey leads, with Connecticut and Florida next.
- **Excellence across domains is possible.** 287 hospitals beat the national average on mortality, safety and readmission together.

---

## Business impact

- Gives administrators a benchmark against peers of the same ownership type
- Points improvement work at specific domains (for example, the 447 hospitals with net-negative mortality measures)
- Helps hospital networks compare states when planning expansion or resources

---

## Limitations

- 41% of hospitals have no overall rating, so rating results describe rated hospitals only.
- Birthing-friendly shares include hospitals that don't deliver babies, which lowers the share for some groups (for example, Veterans Health and Department of Defense show 0%).
- Small groups (Tribal: 2 rated hospitals; Physician: 19) give unstable averages.
- A single snapshot of aggregated data, so no trends over time and no patient-level detail.
- Association only: ownership may go along with other factors (size, location, funding) that this data doesn't include.

---

## Tools

PostgreSQL (pgAdmin) · SQL: `NULLIF`, `CAST`, `CASE WHEN`, CTEs, `DENSE_RANK`, `NTILE`, `CROSS JOIN`
