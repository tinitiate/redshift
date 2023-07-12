-- Create a temporary table with 10 million rows
CREATE TEMP TABLE temp_data
(
    l_id INT,
    l_data VARCHAR(255),
    l_date DATE,
    l_value1 VARCHAR(255),
    l_value2 VARCHAR(255)
);

-- Generate random data and insert into the temporary table
INSERT INTO temp_data (l_id, l_data, l_date, l_value1, l_value2)
SELECT
    -- Generate random values for each column
    (random()*10000000)::INT AS l_id,
    md5(random()::TEXT) AS l_data,
    CURRENT_DATE - (random()*365)::INT AS l_date,
    md5(random()::TEXT) AS l_value1,
    md5(random()::TEXT) AS l_value2
FROM
    generate_series(1, 10000000); -- Generate 10 million rows

-- Create a permanent table and insert data from the temporary table
CREATE TABLE your_table
AS SELECT * FROM temp_data;

-- Drop the temporary table
DROP TABLE temp_data;
