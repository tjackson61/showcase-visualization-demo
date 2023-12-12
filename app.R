library(shiny)
library(plotly)
library(readr)
library(pool)
library(forcats)

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
      shiny::varSelectInput(
        "xaxis",
        "X Axis Category",
        data = exec_query(sql_query)
        # make different query to call only dimensions
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
  source("utils/exec_query.R")
  source("utils/get_query.R")

  flight_data <- reactive(exec_query(sql_query))


  # Event Listeners ---------------------------------------------------------
  observeEvent(input$xaxis,
    {
      shiny::updateVarSelectInput(
        session,
        "xaxis",
        data = flight_data()
      )
    },
    once = TRUE
  )

  observeEvent(input$xaxis, {
    # 
    select_choices <- flight_data() |>
      select(input$xaxis) |>
      unique()
    
    # Update using the reactive unique selected column
    shiny::updateSelectizeInput(
      session,
      "value_filter",
      choices = select_choices
    )
  })



  # Output ------------------------------------------------------------------
  output$chart <- plotly::renderPlotly({
    # data <- flight_data() |>
    #   filter(CRAFT_MODEL_NAME == input$value_filter) |>
    #   select(input$value_filter)
    data <- flight_data()
    make_chart(data, sort_data = TRUE, top_n = input$topn)
  })
}

shiny::shinyApp(ui, server)
