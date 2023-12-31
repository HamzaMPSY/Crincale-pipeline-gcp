WITH iem AS (
    SELECT
        DISTINCT {{ dbt.split_part(
            string_text = 'model',
            delimiter_text = "' '",
            part_number = 1
        )}} AS company_name
    FROM
        `crincale-pipeline-gcp`.`crincale`.`crincale-iems`
),
headphone AS (
    SELECT
        DISTINCT {{ dbt.split_part(
            string_text = 'model',
            delimiter_text = "' '",
            part_number = 1
        )}} AS company_name
    FROM
        `crincale-pipeline-gcp`.`crincale`.`crincale-headphones`
),
final AS (
    SELECT
        iem.company_name
    FROM
        iem
        LEFT JOIN headphone ON iem.company_name = headphone.company_name
)
SELECT
    *
FROM
    final