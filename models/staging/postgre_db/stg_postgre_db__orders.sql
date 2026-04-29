with 

source as (

    select * from {{ source('postgre_db', 'orders') }}

),

renamed as (

    select
        order_id::varchar(256) as order_id,
        shipping_service::varchar(256) as shipping_service,
        shipping_cost::float as shipping_cost,
        address_id::varchar(256) as address_id,
        created_at::datetime as created_at,
        promo_id::varchar(256) as promo_id,
        estimated_delivery_at::datetime as estimated_delivery_at,
        order_cost::float as order_cost,
        user_id::varchar(256) as user_id,
        order_total::float as order_total,
        delivered_at::datetime as delivered_at,
        tracking_id::varchar(256) as tracking_id,
        status::varchar(256) as status,
        _fivetran_deleted::datetime as _fivetran_deleted,
        _fivetran_synced::datetime as _fivetran_synced

    from source

)

select * from renamed