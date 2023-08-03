with customer as(
    select * from {{ ref('stg_tpcds__customer') }}
),

customer_demo as (
    select * from {{ ref('stg_tpcds__customer_demographics') }}
),

income as (
    select * from {{ ref('property_management', 'dim_properties') }}
),

customer_purchase_price as(
    select
        customer.customer_id,
        customer.customer_demo_sk,
        customer_demo.cd_purchase_estimate
    from customer
    left join customer_demo on customer.customer_demo_sk = customer_demo.customer_demo_sk
),


final as(
    select 
        customer_purchase_price.*,
        income.total_property_income
    from income
    left join customer_purchase_price on income.total_property_income = customer_purchase_price.cd_purchase_estimate
)

select * from final
