with orders as (

    select * from {{source('jaffle_shop','raw_payments')}}

),

pivoted as

(

select

    order_id,

    {% set payment_methods = ['bank_transfer','credit_card','gift_card','coupon'] %}

    {% for payment_method in payment_methods %}

        sum(case when payment_method = '{{payment_method}}' then amount else 0 end) as {{payment_method}}_amount
        {% if not loop.last %}
            ,
        {% endif %}

    {% endfor %}

from orders
group by order_id

)

select * from pivoted