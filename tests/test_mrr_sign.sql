-- Tests that the sign of the MRR change is correctly positive or negative
{{
    config(
        enabled=true,
        severity='error'
    )
}}

with mrr as (

    select * from {{ ref('mrr') }}

)

select 
    id,
    change_category,
    mrr_change
from mrr
where (change_category in ('new','reactivation','upgrade') and mrr_change < 0)
    or (change_category in ('churn','downgrade') and mrr_change > 0)
