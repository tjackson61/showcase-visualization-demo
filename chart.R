make_chart <- function(data, dimension,
                       type = "bar", sort_data = TRUE, top_n = 10) {
  # Add data
  data <- get_query() |>
    inject_parameters(dimension) |>
    exec_query()

  # Plotly Figure
  result <- data |>
    arrange(desc(AVERAGE_TOTAL_DURATION)) |>
    dplyr::slice_head(n = top_n) |>
    plotly::plot_ly() |>
    plotly::add_trace(
      x = ~ .data[[dimension]],
      y = ~AVERAGE_TOTAL_DURATION,
      type = type
    )

  # Plotly Layout
  result <- result |> make_layout(dimension)
  print(dimension)
  return(result)
}


make_layout <- function(result, dimension) {
  result |>
    layout(
      xaxis = list(
        title = dimension,
        categoryorder = "array",
        categoryarray = ~ reorder(
          .data[[dimension]],
          AVERAGE_TOTAL_DURATION
        )
      )
    )
}
