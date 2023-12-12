make_chart <- function(data, type = "bar", sort_data = TRUE, top_n = 10) {
  result <- data |>
    mutate(forcats::fct(CRAFT_MODEL_NAME)) |>
    arrange(desc(AVERAGE_TOTAL_DURATION)) |>
    dplyr::slice_head(n = top_n) |>
    plotly::plot_ly() |>
    plotly::add_trace(
      x = ~CRAFT_MODEL_NAME,
      y = ~AVERAGE_TOTAL_DURATION,
      type = type
    ) |>
    layout(
      xaxis = list(
        categoryorder = "array",
        categoryarray = ~ reorder(CRAFT_MODEL_NAME, AVERAGE_TOTAL_DURATION)
      )
    )

  return(result)
}
