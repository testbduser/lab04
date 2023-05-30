-- Создание представления country_cities
CREATE OR REPLACE VIEW data.country_cities AS
SELECT
    c.description AS countries,
    COUNT(ci.identifier) AS cities
FROM
    data.country AS c
LEFT JOIN
    data.city ci ON c.identifier = ci.country
GROUP BY  c.description;