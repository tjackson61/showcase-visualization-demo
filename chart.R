make_chart <- function(data, dimension, measure, x_axis_meta, y_axis_meta,
                       type = "bar", sort_data = TRUE, top_n = 10) {
  # Add data
  data <- get_query() |>
    inject_parameters(dimension, measure) |>
    exec_query()

  # Plotly Figure
  fig <- data |>
    dplyr::arrange(desc(.data[[measure]])) |>
    dplyr::slice_head(n = top_n) |>
    plotly::plot_ly() |>
    plotly::add_trace(
      x = ~ .data[[dimension]],
      y = ~ .data[[measure]],
      text = ~ round(.data[[measure]], digits = 2),
      type = type,
      textposition = "inside"
    )

  # Plotly Layout
  fig <- fig |> make_layout(dimension, measure, x_axis_meta, y_axis_meta)
  return(fig)
}


make_layout <- function(
    fig, dimension, measure, x_axis_meta, y_axis_meta) {
  fig |>
    layout(
      xaxis = list(
        title = axis_titles(dimension, x_axis_meta),
        categoryorder = "array",
        categoryarray = ~ reorder(
          .data[[dimension]],
          .data[[measure]]
        )
      ),
      yaxis = list(
        title = axis_titles(measure, y_axis_meta)
      )
    )
}


axis_titles <- function(dimension, meta) {
  names(meta)[meta == dimension]
}
