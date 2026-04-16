# STEP 1: LOAD DATA INTO SQL
# STEP 2: DATA VALIDATION (VERY IMPORTANT)
-- check nulls
SELECT * FROM sales_pipeline
WHERE engage_date IS NULL OR close_date IS NULL; -- no missing value

-- check duplicates
SELECT opportunity_id, COUNT(*)
FROM sales_pipeline
GROUP BY opportunity_id
HAVING COUNT(*) > 1; -- no duplicates

---------------------------------------
# STEP 3: DATA TRANSFORMATION (SQL CLEAN LAYER)
CREATE VIEW clean_pipeline AS
SELECT 
    opportunity_id,
    sales_agent,
    product,
    account,
    deal_stage,
    CAST(engage_date AS DATE) AS engage_date,
    CAST(close_date AS DATE) AS close_date,
    CAST(close_value AS FLOAT) AS close_value
FROM sales_pipeline;

-----------------------------------------
#  STEP 4: CREATE ANALYTICS QUERIES (OBJECTIVES)
-- OBJECTIVE 1: Pipeline Overview
-- (a) Monthly Opportunities
select year(engage_date), month(engage_date), 
	count(*) as opportunities
from clean_pipeline
Group by year(engage_date), month(engage_date)
order by year(engage_date);

-- (b) Average Deal Duration
select round(avg(datediff(close_date, engage_date)), 0) as avg_days
from clean_pipeline;

select deal_stage, 
	round(avg(datediff(close_date, engage_date)), 0) as avg_days
from clean_pipeline 
group by deal_stage
order by avg_days desc;

-- (c) Stage Distribution
SELECT 
    deal_stage,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()  AS percentage
FROM clean_pipeline
GROUP BY deal_stage;

---------------------------------------------
-- OBJECTIVE 2: Sales Agent Performance
-- (a) Win Rate per Product
select product, 
	avg(case when deal_stage = 'won' then 1 else 0 end) * 100 as win_rate
from clean_pipeline
group by product
order by win_rate desc;

-- (b) Revenue by Agent
select 
	sales_agent, 
    sum(close_value) as total_revenue
from clean_pipeline
where deal_stage = 'Won'
group by sales_agent 
order by total_revenue desc
limit 5;

----------------------------------------------------
# OBJECTIVE 3: Product Analysis
-- (a) Top Product (March)
select product,
		sum(close_value) as revenue 
from clean_pipeline 
where month(close_date) = 3 and deal_stage = "Won"
group by product
order by revenue desc;

-- (b) Price vs Close Value (Data Quality Check)
select p.product, 
		round(avg(p.sales_price - cp.close_value), 2) as avg_diff
from clean_pipeline cp
join products p
on cp.product = p.product
group by p.product
order by avg_diff desc;

-------------------------------------------
# OBJECTIVE 4: Account Analysis
-- (a) Revenue by Location
SELECT 
    a.office_location,
    SUM(c.close_value) AS revenue
FROM clean_pipeline c
JOIN accounts a ON c.account = a.account
WHERE c.deal_stage = 'Won'
GROUP BY a.office_location
ORDER BY revenue desc;