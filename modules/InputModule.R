inputUI <- function(id) {
  ns <- NS(id)
  shiny::inputPanel(
    shiny::numericInput(
      "topn",
      "Top N",
      value = 10,
      min = 5,
      max = 15,
      step = 1
    ),
    shiny::selectizeInput(
      "xaxis",
      "Category Type",
      choices = DIMENSION_CHOICES
    ),
    shiny::selectizeInput(
      "yaxis",
      "Measure Type",
      choices = MEASURE_CHOICES
    ),
    shiny::selectizeInput(
      "aggregate",
      "Aggregate Type",
      choices = AGGREGATE_CHOICES
    )
  )
}

inputServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
    }
  )
}