with orderID_unique AS (        
        SELECT
            order_id
            ,
            sum(profit) AS total_profit
        FROM
                    active_order_profits
        group BY
                    order_id
),
sessionID_orderID AS (
        SELECT
            o.order_id
            ,
            o.total_profit
            ,
            orders.website_session_id
        FROM
            orderID_unique AS o        
        left JOIN
            orders AS orders
            ON  o.order_id=orders.order_id
        
)
select
        s.order_id AS OrderID
        ,
        s.total_profit AS Profit
        ,
        s.website_session_id as Website_session_ID
        ,
        w.utm_source AS  Source
        ,
        w.utm_campaign AS marketing_campaign 
        ,
        w.utm_content AS Content
        ,
        w.device_type AS device
from
        sessionID_orderID as s
left join website_sessions as w 
        on w.website_session_id=s.website_session_id
        


