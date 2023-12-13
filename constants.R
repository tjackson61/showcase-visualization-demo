SORT_TYPE_CHOICES <- c("None", "Desc", "Asc")

DIMENSION_CHOICES <- list(
  `Aircraft Manufacturer` = "CRAFT_MFR_NAME",
  `Aircraft Model Name` = "CRAFT_MODEL_NAME",
  `Aircraft Engine Type` = "CRAFT_ENGINE_TYPE",
  `Airline Name` = "LINE_FULL_NAME",
  `Airline Size Category` = "LINE_SIZE_CATEGORY"
)

MEASURE_CHOICES <- list(
  `Taxi out time` = "TAXI_OUT_DURATION",
  `Taxi in time` = "TAXI_IN_DURATION",
  `Airtime duration` = "AIR_TIME_DURATION",
  `Total duration` = "TOTAL_DURATION"
)

AGGREGATE_CHOICES <- list(
  `Average` = "AVG",
  `Minimum` = "MIN",
  `Maximum` = "MAX",
  `Sum` = "SUM"
)