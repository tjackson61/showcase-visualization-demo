library(shiny)
library(plotly)
library(readr)
library(pool)
library(forcats)
source("utils/exec_query.R")
source("utils/get_query.R")
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



ui <- function() {
  shiny::fluidPage(
    # Input Panel -------------------------------------------------------------
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
    ),
    shiny::fluidRow(
      shiny::wellPanel(
        plotly::plotlyOutput("chart")
      )
    )
  )
}

server <- function(input, output, session) {
  source("chart.R")
  # Event Listeners ---------------------------------------------------------



  # Output ------------------------------------------------------------------
  output$chart <- plotly::renderPlotly({
    make_chart(
      flight_data(),
      input$xaxis,
      input$yaxis,
      DIMENSION_CHOICES,
      MEASURE_CHOICES,
      top_n = input$topn
    )
  })
}

shiny::shinyApp(ui, server)
