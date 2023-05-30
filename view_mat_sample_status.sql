CREATE MATERIALIZED VIEW data.mat_sample_stats AS
SELECT
  c.identifier,
  c.description,
  COUNT(*) AS sample,
  MIN(m.mark) AS start,
  MAX(m.mark) AS end,
  MIN((m.temperature - 32) * 5/9) AS min,
  MAX((m.temperature - 32) * 5/9) AS max,
  AVG((m.temperature - 32) * 5/9) AS avg
FROM
  data.city c
JOIN
  data.measurement m ON c.identifier = m.city
WHERE
  m.temperature > -99 * 5/9
GROUP BY
  c.identifier, c.description;
