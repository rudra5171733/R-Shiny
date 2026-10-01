library(shiny)
ui <- fluidPage(
  h1("Lazy reactive!"),
  numericInput("number",
               "Number",
               value = 10),
  numericInput("multiplier",
               "Multiplier",
               value = 6),
  actionButton("calculate",
               "Click Me!"),
  verbatimTextOutput("message")
)

server <- function(input,output,session){
  result <- reactive({
    print("calculating Result...")
    input$number*input$multiplier
  })
  observeEvent(input$calculate,{
    print("Button Clicked!")
    
  })
  output$message <- renderText({
    paste("Result:",result())
  })
}

shinyApp(ui = ui,server = server)

# reactive Caching

library(shiny)
ui <- fluidPage(
  h1("Reactive Caching"),
  numericInput("number",
            "Number",
            value = 10),
  numericInput("multiplier",
            "Multiplier",
            value = 6),
  verbatimTextOutput("result"),
  verbatimTextOutput("squared")
)

server <- function(input,output,session){
  result <- reactive({
    print("calculating result...")
    input$number*input$multiplier
  })
  output$result <- renderText({
    paste("Result:", result())
  })
  
  output$squared <- renderText({
    paste("Squared:", result()^2)
  })
}
shinyApp(ui = ui,server = server)

#

ui <- fluidPage(
  h1("Welcome to HEOR!"),
  numericInput("txt_cost",
               "Treatment Cost",
               value = 1000),
  numericInput("comp_cost",
               "Comparator Cost",
               value = 700),
  numericInput("txt_qaly",
               "treatment QALY",
               value = 5),
  numericInput("comp_qaly",
               "Comparator QALY",
               value = 4),
  numericInput("wtp",
               "WTP",
               value = 35000),
  verbatimTextOutput("inc_cost"),
  verbatimTextOutput("inc_qaly"),
  verbatimTextOutput("icer"),
  verbatimTextOutput("nmb")
)

server <- function(input,output,session){
  model <- reactive({
    inc_cost = input$txt_cost - input$comp_cost
    inc_qaly = input$txt_qaly - input$comp_qaly
    icer = inc_cost/inc_qaly
    nmb = inc_qaly*input$wtp - inc_cost
    
    list(
      inc_cost = inc_cost,
      inc_qaly = inc_qaly,
      icer = icer,
      nmb = nmb
    )
  })
  
  output$inc_cost <- renderText({
    paste("Incremental Cost:",model()$inc_cost)
  })
  output$inc_qaly <- renderText({
    paste("Incremental QALY:",model()$inc_qaly)
  })
  output$icer <- renderText({
    validate(
      need(model()$inc_qaly !=0,"ICER cannot be calculated since incremental QALY is 0")
    )
    paste("ICER:",model()$icer)
  })
  output$nmb <- renderText({
    paste("NMB:",model()$nmb)
  })
}

shinyApp(ui = ui,server=server)
