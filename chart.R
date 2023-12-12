make_chart <- function(type = "bar", sort_data = TRUE, top_n = 10) {
  source("utils/get_csv_data.R") # comment out once query functionality working
  source("utils/get_query.R")

    flight_data <- get_csv_data()
  
  # parameter control
  if (sort_data) {
    flight_data <- flight_data |>
      # sort functionality
      dplyr::arrange(desc(AVERAGE_TOTAL_DURATION)) |>
      # top N functionality
      dplyr::slice_head(n = top_n)
  }

  result <- flight_data |>
    plotly::plot_ly() |>
    plotly::add_trace(x = ~CRAFT_MODEL_NAME, y = ~AVERAGE_TOTAL_DURATION, type = type)

  return(result)
}


