
TRUNCATE TABLE golden.order_info;

INSERT INTO golden.order_info
	(
	order_id
	, created_at_order
	, website_session_id
	, user_id
	, items_purchased
	, price_usd
	, cogs_usd
	, refund_amount_usd

	, order_item_id
	, price_item_usd
	, cogs_item_usd
	, order_item_revenue

	, product_id
	, product_name
	, product_created_at
	, is_primary_item
	

	, order_item_refund_id
	, refund_item
	)

	SELECT 
		o.order_id AS order_id
		, o.created_at AS created_at_order
		, website_session_id
		, user_id
		, items_purchased
		, o.price_usd AS price_usd
		, o.cogs_usd AS cogs_usd
		, ISNULL(refund_amount_usd, 0) AS refund_amount_usd


		, oi.order_item_id AS order_item_id
		, oi.price_usd AS price_item_usd
		, oi.cogs_usd AS cogs_item_usd
		, oi.price_usd - oi.cogs_usd AS order_item_revenue

		, pr.product_id AS product_id
		, product_name 
		, pr.created_at AS product_created_at
		, is_primary_item
	

		, order_item_refund_id
		, oir.order_item_id AS refund_item
 

	FROM bronze.orders o
	LEFT JOIN bronze.order_items oi ON o.order_id = oi.order_id
	LEFT JOIN bronze.order_item_refunds oir ON oi.order_item_id = oir.order_item_id
	LEFT JOIN bronze.products pr ON oi.product_id = pr.product_id
	--WHERE refund_amount_usd != oi.price_usd

TRUNCATE TABLE golden.website_visits;

INSERT INTO golden.website_visits
	(
	website_session_id
	, created_at
	, user_id
	, is_repeat_session
	, utm_source
	, utm_campaign
	, utm_content
	, device_type
	, http_referer
	, website_pageview_id
	, pageview_url
	)
SELECT
	ws.website_session_id
	, ws.created_at
	, user_id
	, is_repeat_session
	, utm_source
	, utm_campaign
	, utm_content
	, device_type
	, http_referer
	, website_pageview_id
	, pageview_url
FROM bronze.website_sessions ws
JOIN bronze.website_pageviews wp ON ws.website_session_id = wp.website_session_id

