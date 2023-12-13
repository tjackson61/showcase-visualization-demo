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
        "X Axis Category",
        choices = DIMENSION_CHOICES
      ),
      shiny::selectizeInput(
        "value_filter",
        "Y Values Type",
        choices = ""
        # make different query to call only measures
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
    make_chart(flight_data(), input$xaxis, DIMENSION_CHOICES, sort_data = TRUE, top_n = input$topn)
  })
}

shiny::shinyApp(ui, server)
