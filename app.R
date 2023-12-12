library(shiny)
library(plotly)
library(readr)
library(pool)


ui <- function() {
  shiny::basicPage(
    plotly::plotlyOutput('chart'),
    shiny::actionButton("submit", "Submit")
  )
}


server <- function(input, output, session) {
  source("chart.R")
  output$chart <- plotly::renderPlotly({
    make_chart(sort_data = TRUE, top_n = 10)
  })
}

shiny::shinyApp(ui, server)
