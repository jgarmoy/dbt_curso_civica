with src_budget as (
    select
        *
    from {{ source('google_sheets', 'budget') }}
),

renamed_casted as (
    select
        _row::int as _row,
        product_id::varchar(256) as product_id,
        quantity::int as quantity,
        month::date as month,
        _fivetran_synced::datetime as date_load
    from src_budget
)

select * from renamed_casted