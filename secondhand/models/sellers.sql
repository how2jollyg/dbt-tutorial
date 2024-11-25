with dim_seller as (
    select
        seller_id,
        seller_username,
        seller_country,
        seller_price,
        seller_products_sold,
        seller_community_rank,
        seller_num_followers,
        seller_pass_rate,
        seller_badge,
        usually_ships_within
    from `secondhand-luxury.raw.raw`
),

dim_brand as (
    select
        brand_id,
        brand_name,
        brand_url
    from `secondhand-luxury.raw.raw`
),

exploratory_product as (
    select
        seller_id,
        product_id,
        min(price_usd) as min_price,
        max(price_usd) as max_price,
        count(product_id) as number_of_products
    from `secondhand-luxury.raw.raw`
    group by 1,2
)

select * 
from exploratory_product