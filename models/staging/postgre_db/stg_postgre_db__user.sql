with 

source as (

    select * from {{ source('postgre_db', 'user') }}

),

renamed as (

    select
        user_id::varchar(256) as user_id,
        updated_at::datetime as updated_at,
        address_id::varchar(256) as address_id,
        last_name::varchar(256) as last_name,
        created_at::datetime as created_at,
        phone_number::varchar(256) as phone_number,
        total_orders::int as total_orders,
        first_name::varchar(256) as first_name,
        email::varchar(256) as email,
        _fivetran_deleted::datetime as _fivetran_deleted,
        _fivetran_synced::datetime as _fivetran_synced

    from source

)

select * from renamed