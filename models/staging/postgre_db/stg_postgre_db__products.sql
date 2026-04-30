{{ config(
    materialized = 'incremental',
    incremental_strategy = 'append'
) }}

with 

source as (

    select * from {{ source('postgre_db', 'products') }}
    {% if is_incremental() %}
        where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})
    {% endif %}

),

renamed as (

    select
        product_id::varchar(256) as product_id,
        price::float as price,
        name::varchar(256) as name,
        inventory::int as inventory,
        _fivetran_deleted::datetime as _fivetran_deleted,
        _fivetran_synced::datetime as _fivetran_synced

    from source

)

select * from renamed