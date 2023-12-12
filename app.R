library(shiny)
library(plotly)
library(readr)
library(pool)

SORT_TYPE_CHOICES <- c("None", "Desc", "Asc")

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
      shiny::selectInput(
        "sort_type",
        "Sort Type",
        choices = SORT_TYPE_CHOICES
      ),
      shiny::actionButton("submit", "Submit")
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
  source("utils/exec_query.R")
  source("utils/get_query.R")

  flight_data <- exec_query(sql_query)


  # Event Listeners ---------------------------------------------------------


  # Output ------------------------------------------------------------------
  output$chart <- plotly::renderPlotly({
    make_chart(flight_data, sort_data = TRUE, top_n = input$topn)
  })
}

shiny::shinyApp(ui, server)
