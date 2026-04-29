with 

source as (

    select * from {{ source('postgre_db', 'orderitems') }}

),

renamed as (

    select
        order_id::varchar(256) as order_id,
        product_id::varchar(256) as product_id,
        quantity::int as quantity,
        _fivetran_deleted::datetime as _fivetran_deleted,
        _fivetran_synced::datetime as _fivetran_synced

    from source

)

select * from renamed