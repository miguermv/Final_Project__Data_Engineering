{{ config(materialized='view') }}

with 
source as (

    select * from {{ source('hotels_schema', 'rooms') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['room_id']) }} as room_id,
        {{ dbt_utils.generate_surrogate_key(['room_id']) }} as hotel_id,
        room_number::INT                                    as room_number,
        price::DECIMAL(10,2)                                as price_per_night,
        type::VARCHAR(30)                                   as room_type,
        status::VARCHAR(30)                                 as room_status
    from source

)

select * from renamed
