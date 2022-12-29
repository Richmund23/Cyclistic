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


	-- Ride Length
	-- Explore Ride Length by rider type
	
	SELECT
		rider_type,
		CAST(AVG(ride_length_minutes) AS decimal(10,2)) AS average,
		CAST(MIN(ride_length_minutes) AS decimal(10,2)) AS minimum,
		CAST(MAX(ride_length_minutes) AS decimal(10,2)) AS maximum
	INTO
		ridelength_by_ridertype
	FROM
		analyzetripdata
	GROUP BY
		rider_type
		
		
	-- Ride Length
	-- Explore Ride Length by bike type
	
	SELECT
		bike_type,
		CAST(AVG(ride_length_minutes) AS decimal(10,2)) AS average,
		CAST(MIN(ride_length_minutes) AS decimal(10,2)) AS minimum,
		CAST(MAX(ride_length_minutes) AS decimal(10,2)) AS maximum
	INTO
		ridelength_by_biketype
	FROM
		analyzetripdata
	GROUP BY
		bike_type
		
		
	-- Explore Ride Length by quarter
	-- [rider type] : 'member' or 'casual'
	
	SELECT 
		rider_type,
		quarter_name,
		AVG(ride_length_minutes) AS avg_ride_length
	INTO
		ridelength_by_quarter_[rider type]
	FROM
		analyzetripdata
	WHERE
		rider_type = '[rider type]'
	GROUP BY
		rider_type,
		quarter_name
	ORDER BY
		quarter_name
		
	
	-- Explore Ride Length by month
	-- '[rider type]' : 'member' or 'casual'
	SELECT 
		month_name,
		AVG(ride_length_minutes) AS avg_ride_length_[rider type]
	INTO
		ridelength_by_month_[rider type]
	FROM
		analyzetripdata
	WHERE
		rider_type = '[rider type]'
	GROUP BY
		rider_type,
		month_name
	ORDER BY
		month_name
	
		
	-- Explore Ride Length by day
	-- '[rider type]' : 'member' or 'casual'
	
	SELECT 
		day_of_week,
		day_name,
		AVG(ride_length_minutes) AS avg_ride_length_[rider type]
	INTO
		ridelength_by_day_[rider type]
	FROM
		analyzetripdata
	WHERE
		rider_type = '[rider type]'
	GROUP BY
		rider_type,
		day_of_week,
		day_name
	ORDER BY
		day_of_week
		
	
	-- Explore Number of Rides
	-- '[rider type]' : 'member' or 'casual'
		
	
	SELECT
		rider_type,
	COUNT(*) AS ride_trips
	INTO
		ridetrips_by_ridertype
	FROM
		analyzetripdata
	GROUP BY
		rider_type
		
		
	-- Explore Number of Rides by quarter
	-- '[rider type]' : 'member' or 'casual'

	SELECT
		rider_type,
		quarter_name,		
		COUNT(*) AS ride_trips
	INTO
		ridetrips_by_quarter_[rider type]
	FROM
		analyzetripdata
	WHERE
		rider_type = '[rider type]'
	GROUP BY
		rider_type,
		quarter_name
	ORDER BY
		quarter_name
		
	-- Explore Number of Rides by month
	-- '[rider type]' : 'member' or 'casual'

	SELECT
		rider_type,
		month_name,		
		COUNT(*) AS ride_trips
	INTO
		ridetrips_by_month_[rider type]
	FROM
		analyzetripdata
	WHERE
		rider_type = '[rider type]'
	GROUP BY
		rider_type,
		month_name
	ORDER BY
		month_name
		

	-- Explore Number of Rides by day
	-- '[rider type]' : 'member' or 'casual'
	
	SELECT
		rider_type,
		month_name,		
		COUNT(*) AS ride_trips
	INTO
		ridetrips_by_month_[rider type]
	FROM
		analyzetripdata
	WHERE
		rider_type = '[rider type]'
	GROUP BY
		rider_type,
		month_name
	ORDER BY
		month_name
	
	
