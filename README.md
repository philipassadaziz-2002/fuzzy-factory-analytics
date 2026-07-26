# **Maven Fuzzy Factory**

## Overview
This project analyzes transactional and marketing data from Maven Fuzzy Factory, an e-commerce toy retailer, to uncover profitability drivers, revenue risk, and marketing efficiency across the business. Data extraction and transformation were performed in SQL (PostgreSQL), with Python used for statistical validation and Power BI for interactive visualization. Each section below addresses a specific business question — from product-level profitability to order composition and marketing channel dependency — documenting the query logic, findings, and their implications for the business.

## Business Questions
1. **Does the presence of a secondary item in an order have a measurable impact on this company's profitability?**
2. **Is the company overly dependent on a single product for its revenue, and what risk does that concentration create?**
3. **How dependent is the company's profit on a single marketing channel, and how healthy is its channel diversification?**

---

## 1. Does the presence of a secondary item in an order have a measurable impact on this company's profitability?

### 📝 Data Preparation
Order-level transaction data was extracted from PostgreSQL using SQL, joining order items against a refunds table to exclude any refunded items. Because a single order could contain multiple items, order items were aggregated to the order level and classified as "primary-only" or "with secondary item" before profitability calculations. The cleaned dataset was then validated in Python and visualized in Power BI.

### 🧭 Analysis Approach
Orders were aggregated to the order level and classified as "primary-only" or "with secondary item" based on item count per order, then compared on average profit over time. Results were validated across quarterly and yearly time windows — including a check against product launch dates — to confirm the profit difference reflects a genuine, time-consistent pattern rather than a timing artifact or small-sample noise.

### 🖥️ Query
- [View: active_order_profits](/Query/create_view_active_orders.sql) 
- [Primary vs Secondary](/Query/Q1_prmary_vs_secondary.sql)

### 📊 Visualization
- Line chart tracking average profit per order over time for primary-only vs. secondary-item orders, with launch dates of each new product marked.
![AVG_profit_per_order](/images/Q1/AVG_profit.png)
- Clustered bar chart showing total order volume by quarter, split by order type, from 2012 through Q1 2015.
![Total_orders](/images/Q1/total_orders.png)

### 📈 Key Findings
- Orders with a secondary item stabilize at an average profit of $57, roughly 80% higher than the $32 average for primary-only orders.
- The metric first appeared in Q3 2013 at $68, but on a sample of just 6 orders — the early spike reflects small-sample variance rather than a true trend, and the value converges to $57 as order volume grows into the thousands by 2014.
- Secondary-item orders remain structurally underrepresented, accounting for roughly one-third of total order volume by 2015 despite their higher profitability.

### 💡 Business Insights
- Secondary-item attachment is a proven profit lever, not a cosmetic upsell — orders with a secondary item consistently deliver ~80% higher average profit once volume stabilizes (2014 onward).
- The current mix under-leverages this lever: primary-only orders still outnumber secondary-attached orders roughly 2:1 by 2015, leaving a significant share of potential profit uplift uncaptured.
- The pattern's reliability improves with scale — early quarters (Q3–Q4 2013) showed volatile results due to low order counts, meaning the $57 benchmark should be treated as the trustworthy baseline, not the early $68 spike.

---

## 2. Is the company overly dependent on a single product for its revenue, and what risk does that concentration create?

### 🧭 Analysis Approach
Profit and margin were calculated for each product individually by comparing revenue against cost of goods sold, then ranked to identify which products drive the most volume versus the most profitability per unit. Sales share and primary-vs-add-on purchase behavior were analyzed alongside margin to distinguish revenue concentration from margin concentration — since a product can dominate sales volume without being the most profitable one.


### 🐍 Script
[Profit margin calculated](/Script.md/Q1_Profit_margin_calculated.md)

### 📊 Visualization
- Chart 1 — Profit Margin by Product: A bar chart ranking each product by profitability percentage.
![Chart1](/images/Q2/total_sales_and_profit_margin.png)
- Chart 2 — Sales Share by Product: A donut chart showing each product's contribution to total units sold.
![Chart2](/images/Q2/Sales_Share_by_Product.png)


### 📈 Key Findings
- The Original Mr. Fuzzy accounts for 60% of total sales volume, while carrying the lowest profit margin (61%) of the four products.
- The Forever Love Bear, The Hudson River Mini Bear, and The Birthday Sugar Panda together represent only ~40% of total volume, despite two of them (Hudson River and Birthday Sugar Panda) holding the highest profit margins (68%) in the portfolio.
- Profit margins across the product line range narrowly between 61% and 68%, indicating a generally healthy cost structure, but with meaningful variation in how that margin translates to overall profit contribution once sales volume is factored in.

### 💡 Business Insights
- **Revenue Concentration Risk:** With 60% of sales tied to a single product that also has the thinnest margin, the business carries a structural risk — any disruption to that product (cost increase, competitor pressure, supply issue) would have an outsized impact on overall revenue and profit.
- **Underleveraged Margin Opportunity:** The Birthday Sugar Panda and Hudson River Mini Bear combine the highest profit margins in the catalog with the lowest sales volumes. This points to a potential marketing or pricing gap rather than a demand problem, and warrants further investigation before allocating additional promotional spend elsewhere.
- **Recommendation:** Diversify revenue reliance away from the top-selling product over time, while testing targeted marketing investment in the two high-margin, low-volume products to validate whether volume can be grown without eroding their profitability.

---

## 3. How dependent is the company's profit on a single marketing channel, and how healthy is its channel diversification?

### 🧭 Analysis Approach
Orders were joined to their originating marketing session data and grouped by campaign source to calculate each channel's share of total profit. Sessions with no campaign attribution were classified separately as direct traffic rather than excluded, to distinguish paid-channel dependency from organic demand.

### 🖥️ Query
[marketing_campaign_dataset](/Query/Q3_best_campaign.sql)

### 🐍 Script
[Marketing campaign pivot table](/Script.md/Q3_marketing_campaign_pivot_table.md)

### 📊 Visualization
Donut chart showing profit share by marketing campaign type across the full order history.
![Donut_chart_for_marketing_campaign_type](/images/Q3/Donut_chart_marketing_campaign.png)

### 📈 Key Findings
- A single paid channel, nonbrand, accounts for 69.53% of total campaign-attributed profit — a strong concentration in one acquisition source.
- Direct traffic (no campaign attribution) contributes 19.23% of profit, indicating a meaningful base of returning or brand-aware customers acquired at no direct marketing cost.
- The remaining paid channels — brand (10.08%), desktop_targeted, and pilot — together account for less than 11% of profit, showing minimal diversification beyond the single dominant channel.

### 💡 Business Insights
- The near-total reliance on one paid channel (nonbrand) represents a concentration risk: any disruption or cost increase in that channel would directly threaten the majority of attributed profit.
- Direct traffic's meaningful share suggests real organic brand equity — an asset worth protecting and measuring separately from paid acquisition performance.
- Recommend testing and scaling secondary paid channels (brand, desktop_targeted) to build acquisition redundancy, rather than treating direct traffic as a gap to be filled.

---

## Strategic Recommendations
1. **Reduce revenue concentration on a single product and channel.** 60% of sales volume rests on one product (lowest margin in the catalog), and 69.53% of campaign-attributed profit rests on one paid channel (nonbrand) — both represent structural risk that a single disruption (cost, competition, or channel cost changes) could materially impact.
2. **Direct incremental investment toward high-margin, underleveraged products via secondary-channel testing.** The Birthday Sugar Panda and Hudson River Mini Bear combine the best margins with the lowest volumes, and secondary-item attachment already delivers ~80% higher average profit per order — testing these products through a secondary paid channel addresses the margin gap, order composition, and channel diversification with one initiative.
3. **Track organic brand equity as a distinct asset.** Direct traffic drives 19.23% of profit at no acquisition cost — this base should be measured and protected separately from paid performance, not treated as a gap to fill with more campaigns.

## Technical Details
- **Database:** PostgreSQL
- **Querying:** SQL
- **Data validation & analysis:** Python
- **Visualization:** Power BI
