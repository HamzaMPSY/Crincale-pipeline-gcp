WITH company AS (
    SELECT
        *
    FROM
        {{ ref("stg_companynames") }}
),
final AS (
    SELECT
        company.company_name,
        MAX(iems.value_rating) AS highest_value
    FROM
        company inner join `crincale-pipeline-gcp.crincale.crincale-iems` iems on company.company_name = {{ dbt.split_part(
            string_text = 'iems.model',
            delimiter_text = "' '",
            part_number = 1
        ) }}
    where iems.value_rating is not null
    GROUP BY
        company.company_name
)
SELECT
    *
FROM
    final