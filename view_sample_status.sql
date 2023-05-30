-- Создание представления sample_stats
CREATE VIEW data.sample_stats AS
SELECT
    c.identifier,
    c.description,
    COUNT(m.city) AS samples,
    MAX(m.mark) AS start,
    MIN(m.mark) AS end,
    MIN((m.temperature - 32) * 5/9) AS min,
    AVG((m.temperature - 32) * 5/9) AS avg,
    MAX((m.temperature - 32) * 5/9) AS max
FROM
    data.city c
LEFT JOIN
    data.measurement m ON c.identifier = m.city
WHERE
    m.temperature > -99
GROUP BY
    c.identifier, c.description;

