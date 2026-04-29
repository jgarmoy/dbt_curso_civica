with 

source as (

    select * from {{ source('postgre_db', 'addresses') }}

),

renamed as (

    select
        address_id::varchar(256) as address_id,
        zipcode::int as zipcode,
        country::varchar(256) as country,
        address::varchar(256) as address,
        state::varchar(256) as state,
        _fivetran_deleted::datetime as _fivetran_deleted,
        _fivetran_synced::datetime as _fivetran_synced

    from source

)

select * from renamed