/*
================================================================================
Quality Checks
================================================================================
Script Purose:
     This script performs various quality checks for data consistency,accuracy,
     and standardization across the 'silver' schemas.It includes checks for:
     -Null or Duplicate primary keys.
     -Unwanted spaces in string fields.
     -Data Standardization and consistency.
     -Invalid date ranges and orders.
     -Data consistency between related fields.
Usage Notes:
     -Run these checks after data loading Silver Layer.
     -Investigate and resolve any discrepancies found during the checks 
================================================================================

*/

--=====================================
--1.Checking:silver.crm_cust_info
--=====================================
--Check for nulls/duplicates in primary key
--Expectation: No Result
SELECT
cst_id,
COUNT(*) AS count_id
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) >1 OR cst_id IS NULL;

--Check for unwanted spaces
--Expectation: No Result
SELECT cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

--Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;

SELECT DISTINCT 
  cst_marital_status
FROM silver.crm_cust_info;

--=====================================
--2.Checking:silver.crm_prd_info
--=====================================
--Check for nulls/duplicates in primary key
--Expectation: No Result
SELECT
prd_id,
COUNT(*) AS count_id
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)>1 OR prd_id IS NULL;

--Check for unwanted spaces
--Expectation: No Result
SELECT 
  prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

--Check for nulls or negative numbers
--Expectation: No Result
SELECT 
  prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 
  OR prd_cost IS NULL;

--Data Standardization & Consistency
SELECT DISTINCT 
  prd_line
FROM silver.crm_prd_info;

--Check for invalid Date orders(Start Date > End Date) 
--Expectation: No Result  
SELECT
  *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;



--=====================================
--3.Checking:silver.crm_sales_details
--=====================================
--check for invalid dates
--Expectation: No Invalid dates
SELECT
NULLIF(sls_due_dt,0) AS sls_due_dt
FROM silver.crm_sales_details
WHERE sls_due_dt<=0
OR LEN(sls_due_dt)!=8
OR sls_due_dt>20500101 
OR sls_due_dt<19000101;

--Check for invalid dates Orders (Order Date > Shipping/Due Dates)
--Expectation: No Reults
SELECT*
FROM silver.crm_sales_details
WHERE sls_order_dt>sls_ship_dt OR sls_order_dt>sls_due_dt

--Check Data Consistency: Sales = Quantity*Price
--Expectation: No Results  
SELECT
sls_sales ,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
  OR sls_sales IS NULL 
  OR sls_quantity IS NULL 
  OR sls_price IS NULL
  OR sls_sales <= 0 
  OR sls_quantity <= 0 
  OR  sls_price <= 0
ORDER BY sls_sales,sls_quantity,sls_price

--=====================================
--4.Checking:silver.erp_cust_az12
--=====================================
--Identify out-of-range dates
--Expectation: Birthdate between 1924-01-01 and Today  
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate<'1924-01-01' 
  OR bdate>GETDATE()

--Data Standardization & Consistency  
SELECT DISTINCT
gen
FROM silver.erp_cust_az12

--=====================================
--5.Checking:silver.erp_loc_a101
--=====================================
--Data Standardization & Consistency  
SELECT DISTINCT
cntry
FROM silver.erp_loc_a101
ORDER BY cntry;  

--=====================================
--6.Checking:silver.erp_px_cat_g1v2
--=====================================
--check for unwanted spaces,expectation:No reults
SELECT 
  * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
  OR subcat != TRIM(subcat) 
  OR maintenance!= TRIM(maintenance);

--data standardization and consistency
SELECT DISTINCT
cat
,subcat
FROM silver.erp_px_cat_g1v2

SELECT DISTINCT
maintenance
FROM silver.erp_px_cat_g1v2
