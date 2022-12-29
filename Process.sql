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
  
