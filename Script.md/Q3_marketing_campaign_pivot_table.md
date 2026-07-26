```python
# Check duplicate order IDs after joining session-level data
marketing_campaigns['orderid'].duplicated().sum()

# Fill missing campaign attribution with 'Direct' (organic/no-campaign traffic)
marketing_campaigns['marketing_campaign'] = marketing_campaigns['marketing_campaign'].fillna('Direct')

# Aggregate profit and order count by campaign type
pivot_marketing_campaign = marketing_campaigns.pivot_table(
    index='marketing_campaign',
    values=('profit', 'orderid'),
    aggfunc={'profit': 'sum', 'orderid': 'count'}
).reset_index()
```