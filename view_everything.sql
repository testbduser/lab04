-- Создание представления everything
CREATE VIEW data.everything AS
SELECT
    r.description AS region,
    c.description AS country,
    ci.description AS city,
    ci.latitude,
    ci.longitude,
    ci.dataset
FROM
    data.region r
JOIN
    data.country c ON r.identifier = c.region
JOIN
    data.city ci ON c.identifier = ci.country;
