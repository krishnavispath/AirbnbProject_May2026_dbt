{{
    config(
        materialized='table'
    )
}}
with fct_reviews as(
    select * from {{ ref('fct_reviews') }}
),
full_moon_dates as(
    select * from {{ ref('seed_full_moon_dates') }}
)
select
    r.*,
    case
        when f.full_moon_date is NULL then 'not full moon'
        else 'full moon'
    end as is_full_moon
from fct_reviews r
left join full_moon_dates f
    on to_date(r.review_date) = dateadd(day, 1, f.full_moon_date)