with dim_properties as (
select *
from {{ ref('property_management', 'dim_properties') }}

)

, property_agent as (
    select * from {{ ref('stg_property_agent') }}
)

, final as (
    select 
        real_estate_agent,
        sum(total_property_income)
    from dim_properties
        inner join property_agent
            on dim_properties.property_type = property_agent.property_type
    group by 1
)

select * from final
order by 2 desc