{{
  config(
    materialized = "table",
    prehook = "ALTER SESSION SET WEEK_START = 1 "
  )
}}

WITH 

dates_table AS (

    {{ dbt_date.get_date_dimension(
        start_date = "2019-01-01", 
        end_date = "2050-12-31") }}

),

stg_utilities__dates AS (

    select 
        
        date_day as date_id,
        --prior_date_day,
        --next_date_day,
        --prior_year_date_day,
        --prior_year_over_year_date_day,
        --day_of_week_iso,
        day_of_week_name,
        day_of_week_name_short,
        day_of_week,
        day_of_month,
        day_of_year,
        week_start_date,
        week_end_date,
        --prior_year_week_start_date,
        --prior_year_week_end_date,
        --week_of_year,
        --iso_week_start_date,
        --iso_week_end_date,
        --prior_year_iso_week_start_date,
        --prior_year_iso_week_end_date,
        --iso_week_of_year,
        --prior_year_week_of_year,
        --prior_year_iso_week_of_year,
        month_of_year,
        month_name,
        month_name_short,
        month_start_date,
        month_end_date,
        --prior_year_month_start_date,
        --prior_year_month_end_date,
        quarter_of_year,
        quarter_start_date,
        quarter_end_date,
        year_number
        --year_start_date,
        --year_end_date
    FROM dates_table
)

SELECT * FROM stg_utilities__dates