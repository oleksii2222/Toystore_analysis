-- GOLDEN DDL

-- ORDERS AND PRODUCTS TABLE
IF OBJECT_ID('golden.order_info', 'U') IS NOT NULL
	DROP TABLE golden.order_info
GO
	CREATE TABLE golden.order_info
	(
	order_id INT
	, created_at_order DATETIME
	, website_session_id INT
	, user_id INT
	, items_purchased INT
	, price_usd FLOAT
	, cogs_usd FLOAT
	, refund_amount_usd FLOAT

	, order_item_id INT
	, price_item_usd FLOAT
	, cogs_item_usd FLOAT
	, order_item_revenue FLOAT

	, product_id INT
	, product_name NVARCHAR(50)
	, product_created_at DATETIME
	, is_primary_item INT
	

	, order_item_refund_id INT
	, refund_item INT
	);
GO

-- Create website_visit table
IF OBJECT_ID('golden.website_visits', 'U') IS NOT NULL
	DROP TABLE golden.website_visits
GO
	CREATE TABLE golden.website_visits
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
	, website_pageview_id INT
	, pageview_url NVARCHAR(50)
	)
GO
