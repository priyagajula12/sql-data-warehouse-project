/*
==================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==================================================================================
Sricpt Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  --Truncate the bronze tables before loading data.
  --Uses the 'BULK INSERT' command to load from csv files to bronze tables.

Parameters:
  None
  This stored procedure does not accept any parameters or return any values.

Usage Examples:
  EXEC bronze.load_bronze;
==================================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
  DECLARE @start_time DATETIME , @end_time DATETIME ,@batch_start_time DATETIME ,@batch_end_time DATETIME
  BEGIN TRY
  	  SET @batch_start_time = GETDATE();
  		PRINT'================================';
  		PRINT'LOADING BRONZE LAYER';
  		PRINT'================================';
  
  		PRINT'--------------------------------';
  		PRINT'LOADING CRM TABLES';
  		PRINT'--------------------------------';
  
  		SET @start_time = GETDATE();
  		PRINT'>>Truncating Table: bronze.crm_cust_info';
  		TRUNCATE TABLE bronze.crm_cust_info;
  
  		PRINT'>>Inserting Data into: bronze.crm_cust_info';
  		BULK INSERT bronze.crm_cust_info
  		FROM 'C:\Users\vivek\OneDrive\Documents\SQL Server Management Studio\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
  		WITH(
  			FIRSTROW = 2,
  			FIELDTERMINATOR=',',
  			TABLOCK
  		);
  		SET @end_time=GETDATE();
  		PRINT 'Load Duration:' +CAST( DATEDIFF(second,@start_time,@end_time )AS NVARCHAR) + ' seconds';
  		PRINT'>>-------------------------------------';


  		--===========================================


  		SET @start_time = GETDATE();
  		PRINT'>>Truncating Table: bronze.crm_prd_info';
  		TRUNCATE TABLE bronze.crm_prd_info;
  
  		PRINT'>>Inserting Data into: bronze.crm_prd_info';
  		BULK INSERT bronze.crm_prd_info
  		FROM 'C:\Users\vivek\OneDrive\Documents\SQL Server Management Studio\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
  		WITH(
  			FIRSTROW = 2,
  			FIELDTERMINATOR=',',
  			TABLOCK
  		);
  		SET @end_time=GETDATE();
  		PRINT 'Load Duration:' +CAST( DATEDIFF(second,@start_time,@end_time )AS NVARCHAR) + ' seconds';
  		PRINT'>>-------------------------------------';


  		--===========================================


  		SET @start_time = GETDATE();
  		PRINT'>>Truncating Table: bronze.crm_sales_details';
  		TRUNCATE TABLE bronze.crm_sales_details;
  
  		PRINT'>>Inserting Data into: bronze.crm_sales_details';
  		BULK INSERT bronze.crm_sales_details
  		FROM 'C:\Users\vivek\OneDrive\Documents\SQL Server Management Studio\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
  		WITH(
  			FIRSTROW = 2,
  			FIELDTERMINATOR=',',
  			TABLOCK
  		);
  		SET @end_time=GETDATE();
  		PRINT 'Load Duration:' +CAST( DATEDIFF(second,@start_time,@end_time )AS NVARCHAR) + ' seconds';
  		PRINT'>>-------------------------------------';


  		--===========================================


  		PRINT'--------------------------------';
  		PRINT'LOADING ERP TABLES';
  		PRINT'--------------------------------';


  	    SET @start_time = GETDATE();
  		PRINT'>>Truncating Table: bronze.erp_cust_az12';
  		TRUNCATE TABLE bronze.erp_cust_az12;
  
  		PRINT'>>Inserting Data into: bronze.erp_cust_az12';
  		BULK INSERT bronze.erp_cust_az12
  		FROM 'C:\Users\vivek\OneDrive\Documents\SQL Server Management Studio\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
  		WITH(
  			FIRSTROW = 2,
  			FIELDTERMINATOR=',',
  			TABLOCK
  		);
  		SET @end_time=GETDATE();
  		PRINT 'Load Duration:' +CAST( DATEDIFF(second,@start_time,@end_time )AS NVARCHAR) + ' seconds';
  		PRINT'>>-------------------------------------';


  		--===========================================


  	    SET @start_time = GETDATE();
  		PRINT'>>Truncating Table: bronze.erp_loc_a101';
  		TRUNCATE TABLE bronze.erp_loc_a101;
  
  		PRINT'>>Inserting Data into: bronze.erp_loc_a101';
  		BULK INSERT bronze.erp_loc_a101
  		FROM 'C:\Users\vivek\OneDrive\Documents\SQL Server Management Studio\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
  		WITH(
  			FIRSTROW = 2,
  			FIELDTERMINATOR=',',
  			TABLOCK
  		);
  		SET @end_time=GETDATE();
  		PRINT 'Load Duration:' +CAST( DATEDIFF(second,@start_time,@end_time )AS NVARCHAR) + ' seconds';
  		PRINT'>>-------------------------------------';


  		--===========================================


  	    SET @start_time = GETDATE();
  		PRINT'>>Truncating Table: bronze.erp_px_cat_g1v2 ';
  		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
  
  		PRINT'>>Inserting Data into: bronze.erp_px_cat_g1v2';
  		BULK INSERT bronze.erp_px_cat_g1v2
  		FROM 'C:\Users\vivek\OneDrive\Documents\SQL Server Management Studio\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
  		WITH(
  			FIRSTROW = 2,
  			FIELDTERMINATOR=',',
  			TABLOCK
  		);
  		SET @end_time=GETDATE();
  		PRINT 'Load Duration:' +CAST( DATEDIFF(second,@start_time,@end_time )AS NVARCHAR) + ' seconds';
  		PRINT'>>-------------------------------------';


  	  SET @batch_end_time = GETDATE();
  		PRINT'Loading Bronze Layer is Completed';
  	  PRINT 'Load Duration of whole bronze layer:' +CAST( DATEDIFF(second,@open_time,@close_time )AS NVARCHAR) + ' seconds';
      END TRY
  	
  	BEGIN CATCH
    	PRINT '========================================='
    	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
    	PRINT'Error Message: ' + ERROR_MESSAGE();
    	PRINT'Error Message: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
    	PRINT'Error Message: ' + CAST(ERROR_STATE() AS NVARCHAR);
    	PRINT '========================================='
  	END CATCH
END
