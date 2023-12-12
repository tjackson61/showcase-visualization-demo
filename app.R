library(shiny)
library(plotly)
library(readr)
library(pool)


ui <- function() {
  shiny::fluidPage(
    shiny::inputPanel(
      shiny::numericInput("topn", "Top N", value = 10, min = 5, max = 15, step = 1),
      shiny::selectInput("sort_type", "Sort Type", choices = c("None", "Desc", "Asc")),
    ),
    shiny::inputPanel(
      shiny::actionButton("submit", "Submit")
    ),
    shiny::fluidRow(plotly::plotlyOutput("chart"))
  )
}


server <- function(input, output, session) {
  source("chart.R")


  output$chart <- plotly::renderPlotly({
    make_chart(sort_data = TRUE, top_n = 10)
  })
}

shiny::shinyApp(ui, server)
