/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('bronze.orders', 'U') IS NOT NULL 
	DROP TABLE bronze.orders;
GO
	CREATE TABLE bronze.orders
	(
	order_id INT
	, created_at DATETIME
	, website_session_id INT
	, user_id INT
	, primary_product_id INT
	, items_purchased INT
	, price_usd FLOAT
	, cogs_usd FLOAT
	);
GO

IF OBJECT_ID('bronze.order_items', 'U') IS NOT NULL
	DROP TABLE bronze.order_items;
GO
	CREATE TABLE bronze.order_items
	(
	order_item_id INT
	, created_at DATETIME
	, order_id INT
	, product_id INT
	, is_primary_item INT
	, price_usd FLOAT
	, cogs_usd FLOAT
	);
GO

IF OBJECT_ID('bronze.order_item_refunds', 'U') IS NOT NULL
	DROP TABLE bronze.order_item_refunds;
GO
	CREATE TABLE bronze.order_item_refunds
	(
	order_item_refund_id INT
	, created_at DATETIME
	, order_item_id INT
	, order_id INT
	, refund_amount_usd FLOAT
	);
GO

IF OBJECT_ID('bronze.products', 'U') IS NOT NULL
	DROP TABLE bronze.products;
GO
	CREATE TABLE bronze.products
	(
	product_id INT
	, created_at DATETIME
	, product_name NVARCHAR(50)
	);
GO

IF OBJECT_ID('bronze.website_sessions', 'U') IS NOT NULL
	DROP TABLE bronze.website_sessions;
GO
	CREATE TABLE bronze.website_sessions
	(
	website_session_id INT
	, created_at DATETIME
	, user_id INT
	, is_repeat_session INT
	, utm_source NVARCHAR(50)
	, utm_campaign NVARCHAR(50)
	, utm_content NVARCHAR(50)
	, device_type NVARCHAR(50)
	, http_referer NVARCHAR(50)
	);
GO

IF OBJECT_ID('bronze.website_pageviews', 'U') IS NOT NULL
	DROP TABLE bronze.website_pageviews;
GO
	CREATE TABLE bronze.website_pageviews
	(
	website_pageview_id INT
	, created_at DATETIME
	, website_session_id INT
	, pageview_url NVARCHAR(50)
	);
GO
