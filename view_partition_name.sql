CREATE VIEW data.partition_stats AS
SELECT p.relname AS partition, count(*) AS rows
FROM pg_catalog.pg_class p
JOIN pg_catalog.pg_inherits i ON p.oid = i.inhrelid
JOIN pg_catalog.pg_class c ON i.inhparent = c.oid
JOIN data.measurement m ON p.relname = CONCAT('part_y', EXTRACT(YEAR FROM m.mark)::text, 'm', EXTRACT(MONTH FROM m.mark)::text)
WHERE c.relname = 'measurement' AND p.relkind = 'r'
GROUP BY p.relname
HAVING count(*) > 0
ORDER BY p.relname;
