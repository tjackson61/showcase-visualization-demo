library(shiny)
library(plotly)
library(readr)
library(pool)
library(forcats)
source("utils/exec_query.R")
source("utils/get_query.R")
source("modules/InputModule.R")
source("constants.R")
source("chart.R")

ui <- function() {
  shiny::fluidPage(
    # Input Panel -------------------------------------------------------------
    inputUI('input_panel'),
    shiny::fluidRow(
      shiny::wellPanel(
        plotly::plotlyOutput("chart")
      )
    )
  )
}

server <- function(input, output, session) {
  
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
