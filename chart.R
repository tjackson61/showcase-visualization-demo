make_chart <- function(data, dimension, x_axis_meta, 
                       type = "bar", sort_data = TRUE, top_n = 104) {
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
  result <- result |> make_layout(dimension, x_axis_meta)
  return(result)
}


make_layout <- function(result, dimension, meta) {
  
  result |>
    layout(
      xaxis = list(
        title = axis_titles(dimension, meta),
        categoryorder = "array",
        categoryarray = ~ reorder(
          .data[[dimension]],
          AVERAGE_TOTAL_DURATION
        )
      )
    )
}


axis_titles <- function(dimension, meta) {
  names(meta)[meta == dimension]
}