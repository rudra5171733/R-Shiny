library(shiny)

ui <- fluidPage(
  h1("Validate and need Example"),
  textInput("name",
            "Name"),
  numericInput("age",
               "Enter Your age",
               value = 25),
  textOutput("message")
)

server <- function(input,output,session){
  output$message <- renderText({
    validate(
      need(input$age >= 18,"Age must be atleast 18"),
      need(input$age <= 100 , "Age must be atmost 100"),
      need(nchar(trimws(input$name)) > 0 , "Name cannot be empty")
    )
    paste("Hello!:",input$name,"Your age is:",input$age)
  })
}

shinyApp(ui = ui,server = server)

ui <- fluidPage(
  h1("Hello User!"),
  textInput("name",
            "Enter your name"),
  numericInput("age",
               "Enter your age",
               value = 24),
  numericInput("salary",
               "Enter your Salary",
               value = 28734),
  verbatimTextOutput("message")
)

server <- function(input,output,session){
  output$message <- renderText({
    validate(
      need(input$age >= 18 & input$age <= 100 , "Age must be between 18 and 100"),
      need(nchar(trimws(input$name)) > 0 , "Name cannot be blank"),
      need(input$salary > 0 , "Salary cannot be less than 0")
    )
    paste("Hello!",input$name,"\n",
          "your age is:",input$age,"\n",
          "your Salary is:",input$salary)
  })
}

shinyApp(ui = ui,server = server)




#
library(shiny)

ui <- fluidPage(
  h1("Hello Dear Candidate!"),
  
  textInput(
    "name",
    "Enter your Name"
  ),
   selectInput(
    "department",
    "Select your Department",
    choices = c(
      "Please select..." = "",
      "Statistics",
      "Statistics and Computing",
      "Biostatistics"
    ),selected = ""
  ),
  numericInput(
    "age",
    "Enter your Age",
    value = 24
  ),
  actionButton(
    "click",
    "Click Me!"
  ),
  verbatimTextOutput("message")
)

server <- function(input, output, session) {
  emp_info <- eventReactive(input$click, {
    validate(
      need(nchar(trimws(input$name)) > 0,
           "Name cannot be empty"),
      need(input$age >= 18 && input$age <= 60,
           "Age must be between 18 and 60"),
      need(isTruthy(input$department),"Please select a department")
    )
    paste(
      "Employee:", input$name, "\n",
      "Department:", input$department, "\n",
      "Age:", input$age
    )
  })
  output$message <- renderText({
    emp_info()
  })
}

shinyApp(ui = ui, server = server)



# reactive dependency

ui <- fluidPage(
  h1("Reactive Dependency Example"),
  numericInput("number",
               "Number",
               value = 10),
  numericInput("multiplier",
               "Multiplier",
               value = 6),
  verbatimTextOutput("message")
  
)

server <- function(input,output,session){
  prod <- reactive({
    input$number*input$multiplier
  })
  squared <- reactive({
    prod()^2
  })
  cubed <- reactive({
    prod()^3
  })
  
  output$message <- renderText({
    paste("Product:",prod(),"\n",
          "Squared",squared(),"\n",
          "cubed",cubed())
  })
}

shinyApp(ui,server)

library(shiny)

ui <- fluidPage(
  h1("Welcome to HEOR"),
  numericInput("txt_cost",
               "Treatment Cost",
               value = 1000),
  numericInput("comp_cost",
               "Comparator Cost",
               value = 700),
  numericInput("txt_qaly",
               "Treatment QALY",
               value = 5),
  numericInput("comp_qaly",
               "Comparator QALY",
               value = 4),
  numericInput("wtp",
               "WTP",
               value = 50000),
  verbatimTextOutput("inc_cost"),
  verbatimTextOutput("inc_qaly"),
  verbatimTextOutput("icer"),
  verbatimTextOutput("nmb")
  
)

server <- function(input,output,session){
  inc_cost <- reactive({
    input$txt_cost - input$comp_cost
  })
  inc_qaly <- reactive({
    input$txt_qaly - input$comp_qaly
  })
  icer <- reactive({
    validate(
      need(inc_qaly() != 0,"ICER cannot be calculated as incremental QALY is 0")
    )
    inc_cost()/inc_qaly()
  })
  nmb <- reactive({
    inc_qaly()*input$wtp - inc_cost()
  })
  
  output$inc_cost <- renderText({
    paste("Incremental Cost:", inc_cost())
  })
  
  output$inc_qaly <- renderText({
    paste("Incremental QALY:", inc_qaly())
  })
  
  output$icer <- renderText({
    paste("ICER:", icer())
  })
  
  output$nmb <- renderText({
    paste("NMB:", nmb())
  })
}

shinyApp(ui = ui,server = server)
