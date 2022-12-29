/*
GOOGLE DATA ANALYTICS COURSE CAPSTONE PROJECT:
CYCLISTIC BIKE-SHARE ANALYSIS
*/

-- ANALYZE
	-- Explore the data (average, maximum, minimum)
	-- Check for irregularities and irrelevant values

	SELECT
		AVG(ride_length_minutes) AS avg,
		MIN(ride_length_minutes) AS min,
		MAX(ride_length_minutes) AS max
	FROM
		analyzetripdata
		
		
	-- Check for negative ride lengths
	
	SELECT
		started_at,
		ended_at,
		start_station_name,
		end_station_name,
		ride_length_minutes
	FROM
		analyzetripdata
	WHERE
		ride_length_minutes < 0
		
		
	-- Check for ride lengths that lasted more than 24 hours
	
	SELECT
		started_at,
		ended_at,
		start_station_name,
		end_station_name,
		ride_length_minutes
	WHERE
		ride_length_minutes > 1440
		
		
	-- Delete irrelevant ride lengths
	
	DELETE
	FROM
		analyzetripdata
	WHERE
		ride_length_minutes < 0 OR
		ride_length_minutes > 1440
	
	
	-- Check for ride lengths that lasted less than one minute with the same starting station and ending station
	
	SELECT
		started_at,
		ended_at,
		start_station_name,
		end_station_name,
		ride_length_minutes
	FROM
		analyzetripdata
	WHERE
		ride_length_minutes < 1 AND
		start_station_name = end_station_name
		
		
	-- Delete irrelevant ride lengths
	
	DELETE
	FROM
		analyzetripdata
	WHERE
		ride_length_minutes < 1 AND
		start_station_name = end_station_name
	
	
	-- Explore the data again
	
	SELECT
		CAST(AVG(ride_length_minutes) AS decimal(10,2)) AS average,
		CAST(MIN(ride_length_minutes) AS decimal(10,2)) AS minimum,
		CAST(MAX(ride_length_minutes) AS decimal(10,2)) AS maximum
	FROM
		analyzetripdata
