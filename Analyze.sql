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
		
	
	-- Explore Ride Length by quarter
	
	SELECT
		rider_type,
		quarter_name,
		CAST(AVG(ride_length_minutes) AS decimal(10 , 2)) AS avg_ride_length
	INTO
		ridelength_by_quarter
	FROM
		analyzetripdata
	WHERE
		rider_type = 'casual' OR
		rider_type = 'member'
	GROUP BY
		rider_type,
		quarter_name
	ORDER BY
		rider_type,
		quarter_name
		
	
	-- Explore Ride Length by month
	
	SELECT
		rider_type,
		month_name,
		CAST(AVG(ride_length_minutes) AS decimal(10 , 2)) AS avg_ride_length
	INTO
		ridelength_by_month
	FROM
		analyzetripdata
	WHERE
		rider_type = 'casual' OR
		rider_type = 'member'
	GROUP BY
		rider_type,
		month_name
	ORDER BY
		rider_type,
		month_name
	
		
	-- Explore Ride Length by day
	
	SELECT
		rider_type,
		day_of_week,
		day_name,
		CAST(AVG(ride_length_minutes) AS decimal(10 , 2)) AS avg_ride_length
	INTO
		ridelength_by_day
	FROM
		analyzetripdata
	WHERE
		rider_type = 'casual' OR
		rider_type = 'member'
	GROUP BY
		rider_type,
		day_of_week,
		day_name
	ORDER BY
		rider_type,
		day_of_week
		
	
	-- Explore Number of Rides by rider_type
		
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
	
	SELECT
		rider_type,
		quarter_name,		
		COUNT(*) AS ride_trips
	INTO
		ridetrips_by_quarter
	FROM
		analyzetripdata
	WHERE
		rider_type = 'casual' OR
		rider_type = 'member'
	GROUP BY
		rider_type,
		quarter_name
	ORDER BY
		rider_type,
		quarter_name
		
		
	-- Explore Number of Rides by month

	SELECT
		rider_type,
		month_name,		
		COUNT(*) AS ride_trips
	INTO
		ridetrips_by_month
	FROM
		analyzetripdata
	WHERE
		rider_type = 'casual' OR
		rider_type = 'member'
	GROUP BY
		rider_type,
		month_name
	ORDER BY
		rider_type,
		month_name
		

	-- Explore Number of Rides by day
	
	SELECT
		rider_type,
		day_of_week,
		day_name,		
		COUNT(*) AS ride_trips
	INTO
		ridetrips_by_day
	FROM
		analyzetripdata
	WHERE
		rider_type = 'casual' OR
		rider_type = 'member'
	GROUP BY
		rider_type,
		day_of_week,
		day_name
	ORDER BY
		rider_type,
		day_of_week,
		day_name
	
	
	-- Explore Day of Week
	
	SELECT  
    	rider_type,
		day_of_week,
		day_name,
    	COUNT(DISTINCT ride_id) AS FullYear,
		SUM(CASE WHEN quarter_name = 'Q1' THEN 1 ELSE 0 END) AS Q1,
		SUM(CASE WHEN quarter_name = 'Q2' THEN 1 ELSE 0 END) AS Q2,
		SUM(CASE WHEN quarter_name = 'Q3' THEN 1 ELSE 0 END) AS Q3,
		SUM(CASE WHEN quarter_name = 'Q4' THEN 1 ELSE 0 END) AS Q4
	INTO
		dayofweek_full_quarter	
	FROM 
    	analyzetripdata
	GROUP BY 
    	rider_type,
		day_of_week,
		day_name
	ORDER BY
		rider_type,
    	day_of_week
	
	
	-- Explore Peak Hours
	
	SELECT
		rider_type,
		day_of_week,
		day_name,
		DATEPART(hh, started_at) AS hour_name,
		COUNT(*) AS ride_trips
	INTO
		peakhours
	FROM
		analyzetripdata
	WHERE
		rider_type = 'casual' OR
		rider_type = 'member'
	GROUP BY
		rider_type,
		day_of_week,
		day_name,
		started_at
	ORDER BY
		rider_type,
		day_of_week,
		ride_trips DESC
		
		
	-- Explore Total Ride Trips per Hour
	
	SELECT
		rider_type,
		day_name,
		hour_name,
		SUM(ride_trips) AS total_ride_trips
	FROM
		cyclistic.dbo.peakhours
	GROUP BY
		rider_type,
		day_of_week,
		day_name,
		hour_name
	ORDER BY
		rider_type,
		day_of_week,
		hour_name
	
	
	-- Explore Bike Type
	-- Ride Length by Bike Type
	
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
		
		
	-- Bike Type by Rider Type
	
	SELECT
		rider_type,
		bike_type,
		COUNT(*) AS riders
	INTO
		biketype_by_ridertype
	FROM
		analyzetripdata
	GROUP BY
		rider_type,
		bike_type
	ORDER BY
		rider_type,
		bike_type
		
	
	-- Location
	-- Top Starting Stations for Casual Riders
	
	SELECT
		start_station_name,
		COUNT(*) AS casual_rides
	INTO
		startstations_casual
	FROM
		analyzetripdata
	WHERE
		rider_type = 'casual'
	GROUP BY
		start_station_name
	ORDER BY
		COUNT(*) DESC
		
		
	-- Location
	-- Top Ending Stations for Casual Riders
	
	SELECT
		end_station_name,
		COUNT(*) AS casual_rides
	INTO
		endstations_casual
	FROM
		analyzetripdata
	WHERE
		rider_type = 'casual'
	GROUP BY
		end_station_name
	ORDER BY
		COUNT(*) DESC
		
	-- Location
	-- Top Starting Stations for Members
	
	SELECT
		start_station_name,
		COUNT(*) AS member_rides
	INTO
		startstations_member
	FROM
		analyzetripdata
	WHERE
		rider_type = 'member'
	GROUP BY
		start_station_name
	ORDER BY
		COUNT(*) DESC
		
	-- Location
	-- Top Ending Stations for Members
	
	SELECT
		end_station_name,
		COUNT(*) AS member_rides
	INTO
		endstations_member
	FROM
		analyzetripdata
	WHERE
		rider_type = 'member'
	GROUP BY
		end_station_name
	ORDER BY
		COUNT(*) DESC


	-- Location
	-- Top Stations for Casual Riders
	
	SELECT
		start_station_name AS station_name,
		startstations_casual.casual_rides +
		endstations_casual.casual_rides AS total_casual_visits
	INTO
		topstations_casual
	FROM
		startstations_casual
		JOIN endstations_casual
		ON start_station_name = end_station_name
	ORDER BY
		total_casual_visits DESC
		
		
	-- Location
	-- Top Stations for Members
	
	SELECT
		start_station_name AS station_name,
		startstations_member.member_rides +
		endstations_member.member_rides AS total_member_visits
	INTO
		topstations_member
	FROM
		startstations_member
		JOIN endstations_member
		ON start_station_name = end_station_name
	ORDER BY
		total_member_visits DESC
