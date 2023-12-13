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
            ,?measure

            FROM
                [AVIATION_WAREHOUSE].[dbo].[FLIGHT_FACT] flight
                INNER JOIN CRAFT_DIM aircraft ON aircraft.CRAFT_DIM_PK = flight.CRAFT_DIM_PK
                INNER JOIN DATE_DIM [datedim] ON datedim.DATE_DIM_PK = flight.DATE_DIM_PK
                INNER JOIN LINE_DIM airline ON airline.LINE_DIM_PK  = flight.LINE_DIM_PK
            WHERE 0 = 0
                -- Remove nulls from all measure dimensions of note
                AND ?measure  IS NOT NULL
               
    )

SELECT
      ?dimension
      ,AVG(?measure) AS ?measure
FROM
    cte_base
GROUP BY ?dimension 
-- Parameter for group by variable

--   ,[FILTER_GROUP_DIM_PK]