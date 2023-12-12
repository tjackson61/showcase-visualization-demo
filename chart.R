make_chart <- function(data , type = "bar", sort_data = TRUE, top_n = 10) {
  
  # parameter control
  if (sort_data) {
    flight_data <- data |>
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
