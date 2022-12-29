/*
GOOGLE DATA ANALYTICS COURSE CAPSTONE PROJECT:
CYCLISTIC BIKE-SHARE ANALYSIS
*/

-- PROCESS
	-- Data Cleaning
	-- Combining all tables into a single table
  
	SELECT *
		INTO
			tripdata
		FROM
		(
		SELECT
		*
		FROM
			cyclistic.dbo.Jan$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Feb$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Mar$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Apr$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.May$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Jun$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Jul$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Aug$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Sep$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Oct$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Nov$
		UNION ALL
		SELECT
		*
		FROM
			cyclistic.dbo.Dec$
		) a
		
		
	-- Check for misspellings and irregularities
	-- [column string]: rideable_type, start_station_name, start_station_id, end_station_name, end_station_id, member_casual
  
	SELECT DISTINCT 
		[column string]
	FROM
		tripdata
		
		
	-- Check for duplicates in ride_id column
	
	SELECT 
		ride_id,
	COUNT(ride_id)
	FROM 
		tripdata
	GROUP BY ride_id
	HAVING COUNT(ride_id) > 1


	-- Delete duplicates
	
	WITH cte AS (
    SELECT 
        ride_id, 
        ROW_NUMBER() OVER (
            PARTITION BY 
				ride_id
            ORDER BY 
                ride_id
        ) row_num
     FROM 
        tripdata
		)
	DELETE FROM cte
	WHERE row_num > 1;
	
	
	-- Check for blank entries
	-- [column name]: ALL columns
	
	FROM
		tripdata
	WHERE
		[column name] IS NULL;
	
	
	-- Delete blank entries
	
	DELETE
	FROM
		tripdata
	WHERE
		start_station_name IS NULL;
		
		
	-- Added the quarter_name column temporarily shown as month
	-- Added the month_name column which contains the month the ride trips took place in mmm format
	-- Updated the ride_length column into ride_length_minutes column which contains the length of the ride trips in minutes
	-- Renamed member_casual column as rider_type

	
	SELECT
		ride_id,
		rideable_type,
		started_at,
		ended_at,
		ROUND(DATEDIFF(SECOND,started_at,ended_at)/60.0, 2, 2) AS ride_length_minutes,
		CAST(DATENAME(m, started_at) AS nvarchar(3)) AS quarter_name,
		CAST(DATENAME(m, started_at) AS nvarchar(3)) AS month_name,
		day_of_week,
		DATENAME(WEEKDAY, started_at) AS day_name,
		start_station_name,
		start_station_id,
		end_station_name,
		end_station_id,
		start_lat,
		start_lng,
		end_lat,
		end_lng,
		member_casual AS rider_type
	FROM
		tripdata
	
	-- Proceed to next step: Analyze
