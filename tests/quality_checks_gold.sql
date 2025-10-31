/*
==============================================================================
Quality Checks
==============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity,consistency,
    and accuracy of the gold layer, These checks ensure:
    -Uniqueness of surrogate keys in dimension tables.
    -Referential integrity between fact and dimension tables.
    -Validation of relationships in the data model for analytical purposes.

Usage Notes:
    -Run these checks after data loading Silver layer.
    -Investigate and resolve any discrepancies found during the checks.
==============================================================================
*/

--=============================================
--Checking: 'gold.dim_customers'
--=============================================
--Check for Uniqueness of Customer Key in gold.dim_customers
--Expectation: No results
SELECT
  
