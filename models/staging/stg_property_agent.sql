with source as (
    select * from {{ source('agents', 'property_agent') }}
),

renamed as (
    select
        property_type,
        real_estate_agent
    from source
)

select * from renamed