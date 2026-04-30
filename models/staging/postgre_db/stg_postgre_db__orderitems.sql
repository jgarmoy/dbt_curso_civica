{{ config(
    materialized = 'incremental',
    unique_key = ['order_id', 'product_id'],
    incremental_strategy = 'delete+insert'
) }}

with 

source as (

    select * from {{ source('postgre_db', 'orderitems') }}

),

renamed as (

    select
        -- {{ dbt_utils.generate_surrogate_key(['order_id', 'product_id'])}} as sk, -- Así se puede crear una surrogate key a partir de dos campos
        order_id::varchar(256) as order_id,
        product_id::varchar(256) as product_id,
        quantity::int as quantity,
        _fivetran_deleted::datetime as _fivetran_deleted,
        _fivetran_synced::datetime as _fivetran_synced

    from source
    {% if is_incremental() %}
        where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})
    {% endif %}
)

select * from renamed

