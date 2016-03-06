library(shiny)

# Define server logic for slider examples
shinyServer(function(input, output) {
  output$phonePlot <- renderPlot({
    # Render a barplot
    plot(LoadTransitData(input$price_input))
  })
  # Reactive expression to compose a data frame containing all of
  # the values
  sliderValues <- reactive({
    # Compose data frame
    data.frame(
      Name = c("price_input"),
      Value = as.character(c(input$decimal)),
      stringsAsFactors = FALSE
    )
  })
  
  # Show the values using an HTML table
  output$values <- renderTable({
    sliderValues()
  })
})