-- Создание представления region_countries
CREATE VIEW data.region_countries AS
SELECT
    r.identifier AS identifier,
    r.description AS region,
    COUNT(c.identifier) AS countries
FROM
    data.region r
LEFT JOIN
    data.country c ON r.identifier = c.region
GROUP BY
    r.identifier, r.description;

