#Reactive

library(shiny)
 ui <- fluidPage(
   h1("Welcome to reactive programming"),
   numericInput("salary",
                "monthly salary",
                value = 5000),
   textOutput("annual")
 )
 
 server <- function(input , output , sesssion){
   annual_salary <- reactive({
     input$salary*12
   })
   
   output$annual<- renderText({
     paste("Annual Salary is:",annual_salary())
   })
 }
 
 shinyApp(ui = ui, server = server)
 
 ui <- fluidPage(
   h1("Reactive programming"),
   numericInput("number",
             "Number",
             value = 10),
   numericInput("multiplier",
             "Multiplier",
             value = 6),
  textOutput("result"),
  textOutput("squared")
 )
 
 server <- function(input,output,session){
   prod <- reactive({
     input$number*input$multiplier
   })
   observe({                     #Used to perform an action, without producing a value for the UI:
     print(input$number)
   })
   output$result <-renderText({
     paste("Result:",prod())
           })
   output$squared <-renderText({
     paste("Squared",prod()^2)
   })
 }
 
 shinyApp(ui = ui,server = server)
 
 #Observe
 
 
 ui <- fluidPage(
   h1("Reactive programming"),
   numericInput("number",
                "Number",
                value = 10),
   numericInput("multiplier",
                "Multiplier",
                value = 6),
   textOutput("result"),
   textOutput("squared")
 )
 
 server <- function(input,output,session){
   prod <- reactive({
     input$number*input$multiplier
   })
   observe({                     #Used to perform an action, without producing a value for the UI:
    showNotification(
      paste("The number is changed to:",input$number)
    )
   })
   output$result <-renderText({
     paste("Result:",prod())
   })
   output$squared <-renderText({
     paste("Squared",prod()^2)
   })
 }
 
 shinyApp(ui = ui,server = server)
 
 
 #ObserveEvent
 
 ui <- fluidPage(
   h1("observeEvent Example"),
   actionButton("button","Click me!")
 )
 
 server <- function(input,output,session){
   observeEvent(input$button,{
     print("The button was clicked")
   })
 }
 
 shinyApp(ui = ui,server = server)
 
 
 ui<- fluidPage(
   h1("observeEvent Example"),
   numericInput("number",
                "Number",
                value = 25),
   numericInput("multiplier","Multiplier",
                value = 6),
   actionButton("calculate",'Calculate')
 )
 
 server <- function(input,output,session){
   observeEvent(input$calculate,{
   result <- input$number*input$multiplier
   print(result)
   })
 }
 
 shinyApp(ui = ui,server = server)

 
 
 
 
 ui<- fluidPage(
   h1("observeEvent Example"),
   numericInput("number",
                "Number",
                value = 10),
   numericInput("multiplier",
                "Multiplier",
                value = 6),
   actionButton("calculate",
                "Calculate"),
   textOutput("message")
 )
 
 server <- function(input, output, session) {
   
   result <- reactiveVal(NULL)
   
   squared <- reactiveVal(NULL)
   
   observeEvent(input$calculate, {
     
     result(input$number * input$multiplier)
     
     squared(result()^2)
     
   })
   
   output$message <- renderText({
     
     req(result())
     
     paste(
       "Result:", result(),
       "Squared:", squared()
     )
     
   })
   
 }
 
 shinyApp(ui = ui, server = server)
 
 #eventReactive()
 
 ui <- fluidPage(
   h1("eventReactive Example"),
   numericInput("number",
                "Number",
                value = 10),
   numericInput("multiplier",
                "Multiplier",
                value = 6),
   actionButton("calculate",
                "Calculate"),
   textOutput("message")
 )
 
 server <- function(input,output,session){
  result <- eventReactive(input$calculate,{
    input$number*input$multiplier
  })
  output$message <- renderText({
    paste("Result:",result(),"Squared:",result()^2)
  })
 }
 
 shinyApp(ui = ui,server = server)
 
 
 #reactiveValues()
 ui <- fluidPage(
   h1("reactiveValues() Examples"),
   numericInput("number",
                "Number",
                value = 10),
   numericInput("multiplier",
                "Multiplier",
                value = 6),
   actionButton("calculate",
                "calculate"),
   textOutput("message")
 )
 
 
 server <- function(input,output,session){
   values <- reactiveValues(
     result = NULL,
     squared = NULL,
     cubed = NULL
   )
   observeEvent(input$calculate,{
     values$result <- input$number*input$multiplier
     values$squared <- values$result^2
     values$cubed <- values$result^3
   })
   
   output$message<- renderText({
     req(values$result)
     paste("Result:",values$result,
           "Squared:",values$squared,
           "Cubed:",values$cubed)
   })
 }
 
 shinyApp(ui = ui,server = server)
 
 #isolate
 
 ui <- fluidPage(
   h1("isolate() Example"),
   numericInput("number",
                "Number",
                value = 10),
   numericInput("multiplier",
                "Multiplier",
                value = 6),
   textOutput("message")
 )
 
 server <- function(input,output,session){
   result <- reactive({
     input$number*isolate(input$multiplier)
   })
   output$message <- renderText({
     paste("Result:",result())
   })
 }
 shinyApp(ui = ui,server = server)
 