````sql
CREATE VIEW active_order_profits AS
with order_items_not_refunded as (   
        select 
                oi.order_item_id
                ,
                oi.created_at
                ,
                oi.order_id
                ,
                oi.product_id
                ,
                oi.is_primary_item
                ,
                oi.price_usd
                ,
                oi.cogs_usd
        from 
                order_items as oi
        left join 
                order_item_refunds as ref 
                on oi.order_item_id = ref.order_item_id
        where 
                ref.order_item_refund_id is null        
    )
    SELECT 
    	 oi.order_item_id
                ,
                oi.created_at ::date  
                ,
                oi.order_id
                ,
                oi.product_id
                ,
                p.product_name
                ,
                oi.is_primary_item
                ,
                oi.price_usd
                ,
                oi.cogs_usd
                ,
               round(oi.price_usd::numeric -oi.cogs_usd::numeric ,2) AS profit
    FROM order_items_not_refunded  AS oi
    LEFT JOIN products AS p 
    	ON oi.product_id = p.product_id 
                