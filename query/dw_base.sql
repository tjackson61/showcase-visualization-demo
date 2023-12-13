WITH
    cte_base
    AS
    (
        SELECT
            [FLIGHT_FACT_PK]    
        -- Dimensions
            ,aircraft.CRAFT_MFR_NAME
            ,aircraft.CRAFT_MODEL_NAME
            ,aircraft.CRAFT_ENGINE_TYPE
            ,airline.LINE_FULL_NAME
            ,airline.LINE_SIZE_CATEGORY
        -- Measures
            ,[EUCLIDEAN_DISTANCE] * 10 AS EUCLIDEAN_DISTANCE
            ,[TAXI_OUT_DURATION]
            ,[TAXI_IN_DURATION]
            ,[AIR_TIME_DURATION] * 10 AS AIR_TIME_DURATION
            ,[TOTAL_DURATION] * 10 AS TOTAL_DURATION

            FROM
                [AVIATION_WAREHOUSE].[dbo].[FLIGHT_FACT] flight
                INNER JOIN CRAFT_DIM aircraft ON aircraft.CRAFT_DIM_PK = flight.CRAFT_DIM_PK
                INNER JOIN DATE_DIM [datedim] ON datedim.DATE_DIM_PK = flight.DATE_DIM_PK
                INNER JOIN LINE_DIM airline ON airline.LINE_DIM_PK  = flight.LINE_DIM_PK
            WHERE 0 = 0
                -- Remove nulls from all measure dimensions of note
                AND TAXI_IN_DURATION IS NOT NULL
                AND EUCLIDEAN_DISTANCE IS NOT NULL
                AND TAXI_IN_DURATION IS NOT NULL
                AND TAXI_OUT_DURATION IS NOT NULL
                AND AIR_TIME_DURATION IS NOT NULL
                AND TOTAL_DURATION IS NOT NULL
    )

SELECT
      ?dimension
    , AVG(TAXI_IN_DURATION) AS AVERAGE_TAXI_IN_DURATION
    , AVG(TAXI_OUT_DURATION) AS AVERAGE_TAXI_OUT_DURATION
    , AVG(AIR_TIME_DURATION) AS AVERAGE_AIR_TIME_DURATION
    , AVG(TOTAL_DURATION) AS AVERAGE_TOTAL_DURATION
--   Parameter for Measure Types
FROM
    cte_base
GROUP BY ?dimension 
-- Parameter for group by variable

--   ,[FILTER_GROUP_DIM_PK]