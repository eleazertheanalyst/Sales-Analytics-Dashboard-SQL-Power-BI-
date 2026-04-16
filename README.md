
# Sales Analytics Dashboard (SQL + Power BI)

### Dashboard Link : [https://app.powerbi.com/groups/dc3f4dcf-3a16-4f02-8302-60857ec16756/reports/519551e1-cb34-4746-a517-3d7034419cf2/b970eb87132d6650c0dc?experience=power-bi](https://app.powerbi.com/groups/dc3f4dcf-3a16-4f02-8302-60857ec16756/reports/8e2cf146-590d-4ed5-84eb-12f2c1eaece3/684b2a4e79bbce4c98bf?experience=power-bi)

## Project Overview
This project analyzes sales performance across accounts, products, and sales agents to uncover key drivers of revenue, win rates, and pipeline efficiency.
The dataset contained inconsistencies in date formats, data types, and categorical fields, requiring structured data cleaning and transformation using SQL before visualization.
After preparing the data, Power BI was used to build a multi-dashboard analytical system that enables stakeholders to monitor performance, identify bottlenecks, and make data-driven decisions.

## Business Objective
The primary objectives of this analysis were to:
-	Analyze overall sales performance and revenue distribution 
-	Evaluate win rates across products, regions, and sales agents 
-	Identify top-performing and underperforming segments 
-	Understand pipeline efficiency and conversion trends 
-	Provide actionable insights to improve sales strategy 

## Steps followed 
### Phase 1: Data Cleaning & Preparation (SQL)
- Step 1 : **Data Validation**
     - Loaded raw sales dataset into MySQL database
     - Verified dataset integrity by checking for missing values and duplicates 
     - Ensured consistency before transformation
- Step 2: **Data Transformation**
    -	Standardized date formats and ensured proper data types 
    -	Converted numerical fields for accurate aggregation 
    -	Created a clean analytical layer using a SQL view 
- Step 3: **Feature Engineering** \
Created analytical metrics to support performance analysis: 
    -	Deal duration 
    -	Monthly opportunity trends 
    -	Stage distribution 
- Step 4: **Analytical Queries** \
Performed targeted analysis to evaluate sales performance:
    - **Revenue by sales agent**
      ```
      SELECT 
          sales_agent,
          SUM(close_value) AS total_revenue
      FROM clean_pipeline
      WHERE deal_stage = 'Won'
      GROUP BY sales_agent
      ORDER BY total_revenue DESC;
      ```

    - **Win rate by product**
      ```
      SELECT 
          product,
          AVG(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) * 100 AS win_rate
      FROM clean_pipeline
      GROUP BY product
      ORDER BY win_rate DESC;
      ```

### Phase 2: Data Modeling (Power BI)
-	Imported cleaned dataset into Power BI 
-	Ensured proper data types and structure 
-	Optimized model for efficient querying and visualization 

### Phase 3: DAX Measures 
Developed key performance indicators:
- **Total Opportunities**
    ```
    Total Opportunities = COUNTROWS(clean_pipeline)
    ```
- **Deals won**
    ```
     Won Deals =
    CALCULATE(
        COUNTROWS(clean_pipeline),
        clean_pipeline[deal_stage] = "Won"
    )
    ```
- **Win Rate**
    ```
    Win Rate =
      DIVIDE(
          [Won Deals],
          [Total Opportunities]
      )
    ```
- **Total Revenue**
    ```
    Total Revenue = SUM(clean_pipeline[close_value])
    ```
    
### Phase 4: Dashboard Development
#### Developed a multi-dashboard analytical system consisting of:
-	**Sales Pipeline Overview** – Visualizes deal flow, conversion rates, and stage bottlenecks 
-	**Account Analysis** – Highlights revenue concentration and top-performing clients 
-	**Product Analysis** – Compares product performance based on revenue and win rates 
-	**Sales Agent Performance** – Evaluates individual agent contribution and efficiency 
This structure enables stakeholders to analyze sales performance from multiple perspectives, supporting strategic decision-making.

#### Visualizations Used
-	**Funnel Chart** → Pipeline stages 
-	**Bar Charts** → Revenue & rankings 
-	**Combo Chart** → Win rate vs revenue 
-	**Treemap** → Product distribution 
-	**Slicers** → Manager, Region, Product, Time

#### Design & Layout
-	Clean white background for readability 
-	Structured layout: 
    -	KPIs at the top 
    -	Trends in the middle 
    -	Detailed breakdowns at the bottom 
- Consistent formatting across all dashboards 


## Snapshot of Dashboard (Power BI Service)
<img width="1905" height="919" alt="Image" src="https://github.com/user-attachments/assets/6c5ff9a2-0bce-48c2-8cae-0c5962e137c3" />

 
# Report Snapshot (Power BI DESKTOP)
## Sales Pipeline Overview Dashboard
<img width="1309" height="733" alt="Image" src="https://github.com/user-attachments/assets/0cf30866-f7b3-4d59-b50d-231249244f06" />

## Sales Agent Performance Dashboard
<img width="1311" height="731" alt="Image" src="https://github.com/user-attachments/assets/eafc5732-e60c-4f74-8f7d-c7509d0517ef" />

## Product Analysis Dashboard
<img width="1310" height="732" alt="Image" src="https://github.com/user-attachments/assets/b91190e2-ccee-40a9-9302-c3d2f9aeb7c6" />

## Account Analysis Dashboard
<img width="1311" height="733" alt="Image" src="https://github.com/user-attachments/assets/7fe33427-2b58-4e80-869b-3a6d07e5885d" />

# Dashboard Insights
### **Sales Pipeline Overview**
- **Volume Trends:** Opportunities peaked in July (796 deals) before a year-end taper.
- **Efficiency:** Average deal duration is 48 days, with a healthy 63% conversion rate.

### **Sales Agent Performance**
- **MVP Agent:** Darcel Schlecht leads the team in both Revenue ($1.153M) and total opportunities (553).
- **Conversion Expert:** Hayden Neloms achieves the highest win rate at 70.39%.
- **Optimization Opportunity:** A significant gap exists between top-tier agents and the bottom 5 (e.g., Violet Mclelland), indicating a need for targeted coaching.

### **Product Analysis**
- **Revenue Leader:** GTX Pro accounts for $3.51M in revenue.
- **Volume Leader:** GTX Basic is the most sold product (1,436 units).
- **High Efficiency:** While MG Special has low total revenue, it boasts the highest win rate at 64.84%, suggesting high market fit.

### **Account & Sector Analysis**
- **Top Client:** Acme Corporation is the highest revenue contributor at $519K.
- **Sector Dominance:** The Retail and Technology sectors lead revenue generation, contributing $1.87M and $1.52M respectively.
- **Market Concentration:** The United States remains the primary market ($8.43M), followed distantly by Korea and Jordan.


# Strategic Recommendations
- **Replicate "MG Special" Success:** Analyze why the MG Special has a ~65% win rate and apply those sales tactics to the GTX line.
- **Resource Allocation:** Reassign high-volume leads to top converters like Hayden Neloms to maximize the $10M pipeline.
- **Sector Diversification:** While Retail is strong, the Services and Telecommunications sectors are underrepresented and offer expansion potential.
- **Pipeline Smoothing:** Investigate the dip in opportunities during Q4 (November/December) to ensure a consistent year-round sales cycle.

# Technical Skills Demonstrated
-	**SQL:** Data cleaning, transformation, aggregation, window functions 
-	**Power BI:** Dashboard design, data modeling, interactive visuals 
-	**DAX:** KPI development, CALCULATE, DIVIDE, filter context 
-	**Data Analysis:** Performance analysis, trend identification, insight generation 



