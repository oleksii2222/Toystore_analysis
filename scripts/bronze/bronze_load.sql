-- ============================
-- Stored procedure: loading the data to bronze.layer
-- SCRIPT loading the data from source to bronze layer from external csv files
-- Script create stored procedure that can be use by command: EXEC bronze.load_bronze
-- Method of loading: We truncating the existing information from tables and after that load new information by 'BULK INSERT'
-- ============================
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	SET @batch_start_time = GETDATE();
	SET @start_time = GETDATE();
	PRINT '========================='
	PRINT 'LOADING ORDER AND PRODUCTS TABLES'
	PRINT '========================='

	PRINT '-TRUNCATING BRONZE.ORDERS-'
	TRUNCATE TABLE bronze.orders
	PRINT '-Inserting data to bronze.orders-'
	BULK INSERT bronze.orders
	FROM 'C:\Users\ACER\Desktop\toystore_project\toystore\orders.csv'
	WITH (firstrow = 2, fieldterminator = ',', tablock);
	SET @end_time = GETDATE();
	PRINT '-Loading duration bronze.orders ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds-'
	PRINT '=========================='
	PRINT ' '

	SET @start_time = GETDATE();
	PRINT '==TRUNCATING BRONZE.ORDER_ITEMS=='
	TRUNCATE TABLE bronze.order_items;
	PRINT '==Insert Data to bronze.order_items=='
	BULK INSERT bronze.order_items
	FROM 'C:\Users\ACER\Desktop\toystore_project\toystore\order_items.csv'
	WITH (FIRSTROW = 2, fieldterminator = ',', tablock);
	SET @end_time = GETDATE();
	PRINT '--Loading duration bronze.order_items ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds--'
	PRINT '============================'
	PRINT ' '

	SET @start_time = GETDATE();
	PRINT '-TRUNCATING BRONZE.ORDER_ITEM_REFUNDS-'
	TRUNCATE TABLE bronze.order_item_refunds
	PRINT '-Insert data to bronze.order_item_refunds-'
	BULK INSERT bronze.order_item_refunds
	FROM 'C:\Users\ACER\Desktop\toystore_project\toystore\order_item_refunds.csv'
	WITH (firstrow = 2, fieldterminator = ',', tablock);
	SET @end_time = GETDATE();
	PRINT '-Loading duration bronze.order_item_refunds ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds-'
	PRINT '==========================='
	PRINT ' '

	SET @start_time = GETDATE();
	PRINT '==TRUNCATING BRONZE.PRODUCTS=='
	TRUNCATE TABLE bronze.products
	PRINT '==Insert data to bronze.products=='
	BULK INSERT bronze.products
	FROM 'C:\Users\ACER\Desktop\toystore_project\toystore\products.csv'
	WITH (firstrow = 2, fieldterminator = ',', tablock);
	SET @end_time = GETDATE();
	PRINT '--Loading duration bronze.products ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds--'
	PRINT '=========================='
	PRINT ' '


	SET @start_time = GETDATE();
	PRINT '==TRUNCATING BRONZE.WEBSITE_SESSIONS=='
	TRUNCATE TABLE bronze.website_sessions
	PRINT '==Insert data to bronze.website_sessions=='
	BULK INSERT bronze.website_sessions
	FROM 'C:\Users\ACER\Desktop\toystore_project\toystore\website_sessions.csv'
	WITH (firstrow = 2, fieldterminator = ',', tablock);
	SET @end_time = GETDATE();
	PRINT '--Loading duration bronze.website_sessions ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds--'
	PRINT '=========================='
	PRINT ' '

	SET @start_time = GETDATE();
	PRINT '==TRUNCATING BRONZE.WEBSITE_PAGEVIEWS=='
	TRUNCATE TABLE bronze.website_pageviews
	PRINT '==Insert data to bronze.website_pageviews=='
	BULK INSERT bronze.website_pageviews
	FROM 'C:\Users\ACER\Desktop\toystore_project\toystore\website_pageviews.csv'
	WITH (FORMAT = 'CSV', FIELDQUOTE = '"', ROWTERMINATOR = '0x0a', firstrow = 2, fieldterminator = ',', tablock);
	SET @end_time = GETDATE();
	PRINT '--Loading duration bronze.orders ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds--'
	PRINT '=========================='
	PRINT ' '

	SET @batch_end_time = GETDATE()
	PRINT '========================='
	PRINT 'LOADING DURATION FULL BRONZE SCIPT ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR(50)) + ' seconds'
	PRINT '========================='
	END TRY
	BEGIN CATCH
	PRINT '========================='
	PRINT '!!!ERROR OCCURED DURING LOADING BRONZE LAYER!!!'
	PRINT 'ERROR MESSAGE ' + CAST(ERROR_MESSAGE() AS NVARCHAR);
	PRINT 'ERROR MESSAGE ' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'ERROR MESSAGE ' + CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '========================='
	END CATCH
END
