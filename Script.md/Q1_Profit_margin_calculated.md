``````python
#PROFIT MARGIN VS QUANTITY SOLD
profit_margin_pivot_table=order_items_already_sold.pivot_table(
index='product_name',
values=('profit_usd', 'price_usd', 'cogs_usd','order_id','is_primary_item'),
aggfunc=({'profit_usd': 'sum','price_usd': 'sum','cogs_usd': 'sum','order_id':'count','is_primary_item':'count'})
)

profit_margin_pivot_table['profit_margin'] =( profit_margin_pivot_table['profit_usd'] / profit_margin_pivot_table['price_usd'])
profit_margin_pivot_table['profit_margin'] = profit_margin_pivot_table['profit_margin'].round(2)
profit_margin_pivot_table=profit_margin_pivot_table.sort_values(by='profit_margin', ascending=False)

``````