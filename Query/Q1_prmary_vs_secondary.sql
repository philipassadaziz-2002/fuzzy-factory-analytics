 WITH primary_vs_secondary AS(
        SELECT
                    order_id
                    ,
                    MIN(created_at) as order_date 
                    ,
                    CASE
                    WHEN count(*)>1 THEN 'Order with secondary item'
                    ELSE 'only primary item' 
                    end AS order_type 
                    ,
                    sum(profit) as profit
        FROM active_order_profits
        GROUP BY
                order_id
    )
    SELECT
            
            order_type
            ,
          Date_trunc('quarter', order_date) as quarter
            ,
            round(avg(profit), 2) as avg_total_profit 
            ,
            count(order_id) as total_orders        
    FROM
            primary_vs_secondary
     group by
            order_type
            ,
            Date_trunc('quarter', order_date)
     ORDER BY
        quarter
            
           

