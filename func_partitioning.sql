CREATE OR REPLACE FUNCTION data.create_partitions(y1 INT, y2 INT) RETURNS VOID AS $$
DECLARE
  partition_name TEXT;
  d0 TIMESTAMP;
  d1 TIMESTAMP;
BEGIN

  CREATE TABLE IF NOT EXISTS data.measurement (
  id SERIAL,
  city INTEGER,
  mark TIMESTAMP WITHOUT TIME ZONE,
  temperature DOUBLE PRECISION,
  CHECK (temperature >= -98)
  ) PARTITION BY RANGE (mark);


  CREATE UNIQUE INDEX idx_measurement_city_mark ON data.measurement (city, mark);   
  

  FOR year IN y1..y2 LOOP
  FOR month IN 1..12 LOOP
    partition_name := format('part_y%sm%s', year, month);
    d0 := DATE_TRUNC('month', MAKE_DATE(year, month, 1));
    d1 := d0 + INTERVAL '1 month';

    EXECUTE format('CREATE TABLE IF NOT EXISTS data.%I PARTITION OF data.measurement FOR VALUES FROM (%L) TO (%L)',
                   partition_name, d0, d1);
  END LOOP;
  END LOOP;
  INSERT INTO data.measurement (city, mark, temperature)
  SELECT city, mark, temperature
  FROM data.measurement_all
  WHERE temperature >= -98
  ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE plpgsql;

