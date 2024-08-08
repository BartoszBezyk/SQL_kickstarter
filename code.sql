-- Get the name and data type form every field in the 'ks_projekt' table
PRAGMA table_info(ks_projekt);

-- Select relevant columns for our analysis
SELECT main_category, goal, backers, pledged
    FROM ks_projekt
    LIMIT 10;
    
-- Finding projects that weren't successful
SELECT main_category, goal, backers, pledged
    FROM ks_projekt
    WHERE state IN ('failed', 'canceled', 'suspended')
    LIMIT 10;
    
-- Finding projects that had at least 100 backers and at least $20,000 pledged
SELECT main_category, goal, backers, pledged
    FROM ks_projekt
    WHERE  state IN ('failed', 'canceled', 'suspended') 
    AND backers >= 100 AND usd_pledged_real >= 20000
    LIMIT 10;
    
-- Sorting by main category in ascending order and percentage of the goal that was founded in descending order
SELECT main_category, goal, backers, pledged, ROUND(pledged/goal,3) AS pct_pledged
    FROM ks_projekt
    WHERE  state IN ('failed', 'canceled', 'suspended') 
    AND backers >= 100 AND usd_pledged_real >= 20000
    ORDER BY main_category ASC, pct_pledged DESC
    LIMIT 10;
    
-- Grouping pct_pledged into categories
SELECT main_category, goal, backers, pledged, ROUND(pledged/goal,3) AS pct_pledged,
        CASE
        WHEN ROUND(pledged/goal,3) >= 1 THEN 'Fully funded'
        WHEN ROUND(pledged/goal,3) BETWEEN 0.75 AND 1 THEN 'Nearly funded'
        ELSE 'Not nearly funded'
        END AS funding_status
    FROM ks_projekt
    WHERE  state IN ('failed', 'canceled', 'suspended') 
    AND backers >= 100 AND usd_pledged_real >= 20000
    ORDER BY main_category ASC, pct_pledged DESC
    LIMIT 10;
    
