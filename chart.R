make_chart <- function(data, dimension,
                       type = "bar", sort_data = TRUE, top_n = 10) {
  # Call helper functions
  # get query from ./query path
  # inject ?dimension into cte from get_query()
  data <- inject_parameters(get_query(), dimension) |> 
    exec_query()
  
  # pass data into resulting plotly object
  result <- data |>
    arrange(desc(AVERAGE_TOTAL_DURATION)) |>
    dplyr::slice_head(n = top_n) |>
    plotly::plot_ly() |>
    plotly::add_trace(
      x = ~ .data[[dimension]],
      y = ~AVERAGE_TOTAL_DURATION,
      type = type
    ) |>
    layout(
      xaxis = list(
        categoryorder = "array",
        categoryarray = ~ reorder(
          .data[[dimension]],
          AVERAGE_TOTAL_DURATION
        )
      )
  )

  return(result)
}
