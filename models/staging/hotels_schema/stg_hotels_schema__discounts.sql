--Configuro este staging como table porque le añado un nuevo registro que no existe en el source
{{ config(
    materialized='table' 
    )
}}

with 

source as (

    select * from {{source('hotels_schema', 'discounts') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['discount_name']) }}   as discount_id,
	    discount_name::VARCHAR(256)                                 as discount_name,
	    discount_rate::DECIMAL(10,2)                                as discount_percentage,
	    discount_desc::VARCHAR(256)                                 as discount_desc,
	    discount_status::VARCHAR(256)                               as discount_status,
        {{ ifvalue_to_bool('discount_status', "'Active'") }}        as discount_active_flag,
        _fivetran_synced::TIMESTAMP_TZ                              as datetimeload_utc
    from source
    
)

select * 
from renamed

UNION ALL --Union de un nuevo registro para poder enlazar los registros vacios en bookings/payments

select
    {{ dbt_utils.generate_surrogate_key(["'NODISCOUNT'"]) }}  as discount_id,
    'NODISCOUNT'                                              as discount_name,
    0                                                          as discount_percentage,
    'No discount'                                              as discount_desc,
    'Active'                                                   as discount_status,
    FALSE                                                      as DISCOUNT_STATUS_FLAG,
    '2024-11-28T08:58:17.303Z'                                 as datetimeload_utc