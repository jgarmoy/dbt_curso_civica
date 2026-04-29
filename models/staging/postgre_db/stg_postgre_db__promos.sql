with 

source as (

    select * from {{ source('postgre_db', 'promos') }}

),

renamed as (

    select
        promo_id::varchar(256) as promo_id,
        discount::int as discount,
        status::varchar(256) as status,
        _fivetran_deleted::datetime as _fivetran_deleted,
        _fivetran_synced::datetime as _fivetran_synced

    from source

)

select * from renamed