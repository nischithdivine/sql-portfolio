SELECT * FROM hospital_info;

/*Q1: Which 10 states have the highest total number of hospitals, 
and how many hospitals are in each?*/

SELECT 
    state, 
    COUNT(*) AS total_hospitals
FROM hospital_info
GROUP BY state
ORDER BY total_hospitals DESC
LIMIT 10;


/*Q2. How many hospitals of each hospital_type currently offer 
emergency_services?*/

SELECT 
    hospital_type, 
    COUNT(*) as hospital_count
FROM hospital_info
WHERE emergency_services = 'Yes'
GROUP BY hospital_type
ORDER BY hospital_count DESC;

/*Q3. List the facility_name, city_town, and state of all hospitals that have achieved a perfect '5' 
for their overall_rating.*/

SELECT 
    facility_name, 
    city_town, 
    state
FROM hospital_info
WHERE overall_rating = '5';


/*Q4. What is the average overall_rating for each hospital_ownership type?*/


SELECT 
    hospital_ownership,
    ROUND(AVG(CAST(NULLIF(overall_rating, 'Not Available') AS NUMERIC)), 2) AS avg_rating
FROM hospital_info
GROUP BY hospital_ownership
ORDER BY avg_rating DESC;


/*Q5. What percentage of hospitals within each hospital_ownership 
category meet the criteria for "birthing friendly designation"?*/

SELECT 
    hospital_ownership,
    ROUND(COUNT(CASE WHEN birthing_friendly = 'Y' THEN 1 END) * 100.0 / COUNT(*), 2) AS birthing_friendly_pct
FROM hospital_info
GROUP BY hospital_ownership
ORDER BY birthing_friendly_pct DESC;


/*Q6. Identify hospitals that have more "Worse" Mortality measures than "Better" 
Mortality measures.*/


SELECT 
    facility_name, 
    state,
    CAST(NULLIF(count_mort_worse, 'Not Available') AS NUMERIC) AS worse_mort,
    CAST(NULLIF(count_mort_better, 'Not Available') AS NUMERIC) AS better_mort
FROM hospital_info
WHERE CAST(NULLIF(count_mort_worse, 'Not Available') AS NUMERIC) > CAST(NULLIF(count_mort_better, 'Not Available') AS NUMERIC)
ORDER BY worse_mort DESC;


/*Q7. Create a report showing the count of hospitals for each overall_rating 
specifically for "Acute Care Hospitals".*/



SELECT 
    overall_rating, 
    COUNT(*) as rating_count
FROM hospital_info
WHERE hospital_type = 'Acute Care Hospitals'
GROUP BY overall_rating
ORDER BY overall_rating;


/*Q8. Which 5 states have the highest average number of "Better" 
Safety measures per hospital?*/


SELECT 
    state,
    ROUND(AVG(CAST(NULLIF(count_safety_better, 'Not Available') AS NUMERIC)), 2) AS avg_better_safety
FROM hospital_info
WHERE count_safety_better != 'Not Available'
GROUP BY state
ORDER BY avg_better_safety DESC
LIMIT 5;

/*Q9. Rank the top 3 hospitals within each state based on their overall_rating.*/

WITH RankedHospitals AS (
    SELECT 
        facility_name, 
        state, 
        overall_rating,
        DENSE_RANK() OVER(
            PARTITION BY state 
            ORDER BY CAST(NULLIF(overall_rating, 'Not Available') AS NUMERIC) DESC NULLS LAST
        ) as state_rank
    FROM hospital_info
)
-- Then we select from our CTE, filtering for only the top 3 in each state.
SELECT * FROM RankedHospitals 
WHERE state_rank <= 3;

/*Q10. Calculate a custom "Safety Score" ((Better - Worse) / Total) and 
find the top 10 hospitals nationwide (minimum 5 total measures).*/

SELECT 
    facility_name, 
    state,
    ROUND((CAST(NULLIF(count_safety_better, 'Not Available') AS NUMERIC) - CAST(NULLIF(count_safety_worse, 'Not Available') AS NUMERIC)) 
    / CAST(NULLIF(count_facility_safety_measures, 'Not Available') AS NUMERIC), 4) AS safety_score
FROM hospital_info
WHERE CAST(NULLIF(count_facility_safety_measures, 'Not Available') AS NUMERIC) >= 5
ORDER BY safety_score DESC NULLS LAST
LIMIT 10;


/*Q11. Peer Group Benchmarking: Show each hospital's rating, 
its ownership group's average rating, and the difference.*/

WITH PeerGroup AS (
    SELECT 
        hospital_ownership, 
        AVG(CAST(NULLIF(overall_rating, 'Not Available') AS NUMERIC)) as peer_avg
    FROM hospital_info
    GROUP BY hospital_ownership
)
SELECT 
    h.facility_name, 
    h.hospital_ownership, 
    h.overall_rating, 
    ROUND(p.peer_avg, 2) AS peer_group_avg,
    ROUND(CAST(NULLIF(h.overall_rating, 'Not Available') AS NUMERIC) - p.peer_avg, 2) AS diff_from_peer_avg
FROM hospital_info h
JOIN PeerGroup p ON h.hospital_ownership = p.hospital_ownership
WHERE h.overall_rating != 'Not Available'
ORDER BY diff_from_peer_avg DESC;

/*12. Divide hospitals into 4 quartiles based on their volume of 
Readmission measures. What is the average overall_rating for each quartile?*/

WITH VolumeQuartiles AS (
    SELECT 
        facility_name, 
        overall_rating,
        NTILE(4) OVER (
            ORDER BY CAST(NULLIF(count_facility_readm_measures, 'Not Available') AS NUMERIC) DESC NULLS LAST
        ) AS readm_volume_quartile
    FROM hospital_info
    WHERE count_facility_readm_measures != 'Not Available'
)

SELECT 
    readm_volume_quartile,
    ROUND(AVG(CAST(NULLIF(overall_rating, 'Not Available') AS NUMERIC)), 2) AS avg_rating
FROM VolumeQuartiles
WHERE overall_rating != 'Not Available'
GROUP BY readm_volume_quartile
ORDER BY readm_volume_quartile;

/*13. The "Elite" Multi-Metric Performers: Identify hospitals that score above 
the national average in Better Mortality AND Better Safety AND 
Better Readmission measures.*/

WITH NationalAverages AS (
    SELECT 
        AVG(CAST(NULLIF(count_mort_better, 'Not Available') AS NUMERIC)) AS avg_mort,
        AVG(CAST(NULLIF(count_safety_better, 'Not Available') AS NUMERIC)) AS avg_safety,
        AVG(CAST(NULLIF(count_readm_better, 'Not Available') AS NUMERIC)) AS avg_readm
    FROM hospital_info
)

SELECT 
    h.facility_name, 
    h.state
FROM hospital_info h
CROSS JOIN NationalAverages n
WHERE CAST(NULLIF(h.count_mort_better, 'Not Available') AS NUMERIC) > n.avg_mort
  AND CAST(NULLIF(h.count_safety_better, 'Not Available') AS NUMERIC) > n.avg_safety
  AND CAST(NULLIF(h.count_readm_better, 'Not Available') AS NUMERIC) > n.avg_readm;