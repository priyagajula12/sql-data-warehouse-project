/*
=============================================================================
DDL SCRIPT:Create Gold Views
=============================================================================
Script Purpose:
   This script creates views for the gold layer in the data warehouse.
   The gold layer represents the final dimension and fact tables(Star Schema)

   Each view performs transformations and combines data from the silver layer 
   to produce a clean,enriched,and business-ready dataset.

Usage:
   -These views can be queried directly for analytics and reporting.
=============================================================================
*/


 --=======================================
 --Create Dimension: gold.dim_customers
 --=======================================
IF OBJECT_ID('gold.dim_costomers','V') IS NOT NULL
  DROP VIEW gold.dim_costomers;
GO
  
CREATE VIEW gold.dim_customers AS
SELECT 
  ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	la.cntry AS country,
	ci.cst_marital_status AS marital_status,
	CASE WHEN  ci.cst_gndr != 'n/a' THEN ci.cst_gndr--CRM is master for gender table
	     ELSE COALESCE(ca.gen,'n/a')
    END AS gender,
	ca.bdate AS birthdate,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
GO

--=======================================
--Create Dimension: gold.dim_products
--=======================================
IF OBJECT_ID('gold.dim_products','V') IS NOT NULL
  DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS 
SELECT
  ROW_NUMBER() OVER(ORDER BY prd_start_dt ) AS product_key,
  pr.prd_id AS product_id,
  pr.prd_key AS product_number,
  pr.prd_nm AS product_name,
  pr.cat_id AS catgory_id,
  pc.cat AS category,
  pc.subcat AS subcategory,
  pc.maintenance ,
  pr.prd_cost AS cost,
  pr.prd_line AS product_line,
  pr.prd_start_dt AS start_date
FROM silver.crm_prd_info pr
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pr.cat_id=pc.id
WHERE pr.prd_end_dt IS NULL--filters out all historical data
GO


--=======================================
--Create Fac Table:gold.fact_sales
--=======================================
IF OBJECT_ID('gold.fact_sales','V') IS NOT NULL
  DROP VIEW gold.fact_sales;
GO
  
CREATE VIEW gold.fact_sales AS 
SELECT 
  sd.sls_ord_num AS order_number,
  pn.product_key,
  cn.customer_key,
  sd.sls_order_dt AS order_date,
  sd.sls_ship_dt AS shipping_date,
  sd.sls_due_dt AS due_date,
  sd.sls_sales AS sales_amount,
  sd.sls_quantity AS quantity,
  sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_customers cn
     ON sd.sls_cust_id = cn.customer_id
LEFT JOIN gold.dim_products pn
     ON sls_prd_key = pn.product_number
GO
