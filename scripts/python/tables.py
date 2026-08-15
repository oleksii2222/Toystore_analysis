import pandas as pd
import pyodbc
import numpy as np
from sqlalchemy import create_engine
from urllib.parse import quote_plus
pd.set_option('display.max_columns', None)

# Create a connection with SQL database
# ----------------
server = r'GH7YJN\SQLEXPRESS'
database = 'toystore'
connection_string = (
    'DRIVER={ODBC Driver 18 for SQL Server};'
    f'SERVER={server};'
    f'DATABASE={database};'
    'Trusted_connection=yes;'
    'TrustServerCertificate=yes;'
)

connection_url = f"mssql+pyodbc:///?odbc_connect={quote_plus(connection_string)}"
engine = create_engine(connection_url)

order_info = pd.read_sql("SELECT * FROM golden.order_info", engine)
website_visits = pd.read_sql("SELECT * FROM golden.website_visits", engine)

# ==================
#  Create tables for product analysis
# ==================

# ==================
#  1. Refund ratio by products
# ==================

refund_ratio = order_info[['product_name', 'refund_amount_usd']]
refund_ratio = refund_ratio.groupby('product_name', as_index=False).agg(
    refund_quantity_yes=('refund_amount_usd', lambda x: (x > 0).sum()),
    refund_quantity_no=('refund_amount_usd', 'count'))
refund_ratio['refund_ratio'] = refund_ratio['refund_quantity_yes'] / \
    refund_ratio['refund_quantity_no'] * 100

# ==================
# 2. Products by profit
# ==================

profit_table = order_info.copy()
profit_table['profit'] = np.where(
    profit_table['refund_amount_usd'] == 0, profit_table['price_item_usd'] - profit_table['cogs_item_usd'], 0)
profit_table.to_csv('orders_profit_usd.csv')

product_profit = profit_table.groupby(
    'product_name', as_index=False).agg(profit=('profit', 'sum'))
product_info = pd.merge(refund_ratio, product_profit,
                        on='product_name', how='inner')
product_info.to_excel('product_info.xlsx')


# ==================
# 3. Landing and dekstop stat
# ==================

# -*-*-*-*-*-*-*-*-*-
# ----3.1 Landing main table for further analysis
# -*-*-*-*-*-*-*-*-*-

# ----- 3.1.1 - 3.1.2 Create table landing analysis to create a column that will indicate the landing page
# number that the user visited during the session. A column with the time of the landing page visit
# was also added for further filtering, which resulted in removing other actions during the session
# that preceded the landing page visit (this way we will see the conversion from each landing page
# to the next action)

# ---- 3.1.1.1 Create a body of table
landing_analysis = website_visits[['website_session_id', 'created_at', 'device_type', 'pageview_url']].sort_values(
    ['website_session_id', 'created_at'], ascending=[True, True])

# ---- 3.1.1.2 Create a table that will be a filter for body
landing_analysis2 = landing_analysis.copy()
landings = ['/lander-1', '/lander-2', '/lander-3', '/lander-4', '/lander-5']
landing_analysis2['landers'] = np.where(landing_analysis2['pageview_url'].isin(
    landings), landing_analysis2['pageview_url'], 0)

landing_analysis2['lander_time'] = np.where(landing_analysis2['pageview_url'].isin(
    landings), landing_analysis2['created_at'].astype('datetime64[s]'), pd.NaT)

landing_analysis2 = landing_analysis2[[
    'website_session_id', 'landers', 'lander_time']][landing_analysis2['landers'] != 0]


# ---- 3.1.2 Create a Final table for further landing analysis

landing_main_table = pd.merge(
    landing_analysis, landing_analysis2, on='website_session_id', how='inner')
landing_main_table = landing_main_table[landing_main_table['created_at']
                                        >= landing_main_table['lander_time']]

# -*-*-*-*-*-*-*-*-*-
# ---- 3.2 Bulid a tables for conversion funnels of landing
# -*-*-*-*-*-*-*-*-*-

# ---- 3.2.1 Desktop
desktop_landing = landing_main_table[landing_main_table['device_type'] == 'desktop']
desktop_landing = desktop_landing.groupby(['pageview_url', 'landers'], as_index=False).agg(
    pageview_count=('pageview_url', 'count')).sort_values(['landers', 'pageview_count'], ascending=[True, False])

# ---- 3.2.2 Mobile
mobile_landing = landing_main_table[landing_main_table['device_type'] == 'mobile']
mobile_landing = mobile_landing.groupby(['pageview_url', 'landers'], as_index=False).agg(
    pageview_count=('pageview_url', 'count')).sort_values(['landers', 'pageview_count'], ascending=[True, False])

# ---- 3.2.2 Final Table
# ---- 3.2.2.1 Table
landing_final = pd.merge(desktop_landing, mobile_landing, on=[
                         'landers', 'pageview_url'], how='outer', suffixes=['_desktop', '_mobile'])
# ---- 3.2.2.2 Filtering
landing_final = pd.pivot_table(landing_final, columns='pageview_url', values=[
                               'pageview_count_desktop', 'pageview_count_mobile'], index='landers')

landing_final = landing_final.stack(level=0, future_stack=True).reset_index()

landing_final = landing_final.rename(
    columns={'level_1': 'pageview_count'}
).fillna(0)
landing_final['lander'] = landing_final['/lander-1'] + landing_final['/lander-2'] + \
    landing_final['/lander-3'] + \
    landing_final['/lander-4'] + landing_final['/lander-5']
landing_final['billing'] = landing_final['/billing'] + \
    landing_final['/billing-2']
landing_final['purchase'] = landing_final['/thank-you-for-your-order']
landing_final = landing_final[['pageview_count', 'landers', 'lander',
                               '/products', '/cart', '/shipping', 'billing', 'purchase']]
landing_final.to_excel('landing_funnels.xlsx')
print(landing_final)
# print(website_visits.head(5))
