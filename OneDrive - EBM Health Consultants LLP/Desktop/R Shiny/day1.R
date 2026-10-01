# Basic structure of nay Shiny app
# library(shiny)
# ui <- fluidPage(
#   
# )
# 
# server <- function(input,output,session){
#   
# }
# 
# shinyApp(ui = ui,server = server)

# First Shiny App
library(shiny)

ui <- fluidPage(
  h1("Hi! This is my First Shiny App"),
  h2("Large Hewading"),
  h3("Smaller Heading"),
  h4('Even Smaller Heading'),
  p("I am learning Shiny"),
  actionButton("button","Click Me!")
)

server <- function(input,output,session){
  
}

shinyApp(ui = ui, server = server)

# Practice

ui <- fluidPage(
  h1(" R Shiny Learning Day 1"),
  p("I am learning to build Interactive Applications"),
  p("Click the Button Below"),
  actionButton("button","Click Me!"),
  textOutput("message")
)

server <- function(input,output,session){
  observe({
    print(input$button)
  })
  output$message = renderText({
    "hello!"
  })
}

shinyApp(ui = ui, server = server)


# Practice

ui <- fluidPage(
  h1(" R Shiny Learning Day 1"),
  p("I am learning to build Interactive Applications"),
  p("Click the Button Below"),
  actionButton("button","Click Me!"),
  textOutput("message")
)

server <- function(input,output,session){
  
  output$message = renderText({
    paste("You Clicked the button",input$button,"times!")
  })
}

shinyApp(ui = ui, server = server)

# 1
ui <- fluidPage(
  h1(" R Shiny Learning Day 1"),
  p("I am learning to build Interactive Applications"),
  p("Click the Button Below"),
  actionButton("button","Click Me!"),
  textOutput("message")
)

server <- function(input,output,session){
  
  output$message = renderText({
    paste("The button has been clicked",input$button,"times!")
  })
}

shinyApp(ui = ui, server = server)

# 2
ui <- fluidPage(
  h1(" R Shiny Learning Day 1"),
  p("I am learning to build Interactive Applications"),
  p("Click the Button Below"),
  actionButton("button","Click Me!"),
  textOutput("message")
)

server <- function(input,output,session){
  
  output$message = renderText({
    paste("The button has been clicked",input$button,"times!")
  })
}

shinyApp(ui = ui, server = server)

# 3
library(shiny)

ui <- fluidPage(
  h1("R Shiny Learning Day 1"),
  p("I am learning to build Interactive Applications"),
  p("Click the Button Below"),
  
  actionButton("button", "Click Me!"),
  
  textOutput("message"),
  
  textOutput("name_message"),
  
  textInput("name", "Enter your name")
)

server <- function(input, output, session) {
  
  output$message <- renderText({
    
    if (input$button == 0) {
      "Please click the button!"
    } else {
      paste("The button has been clicked", input$button, "times!")
    }
    
  })
  
  output$name_message <- renderText({
    paste("Candidate name:", input$name)
  })
  
}

shinyApp(ui = ui, server = server)



library(shiny)

ui <- fluidPage(
  h1("R Shiny Learning Day 1"),
  p("I am learning to build Interactive Applications"),
  p("Click the Button Below"),
  
  actionButton("button", "Click Me!"),
  
  textOutput("message"),
  
  textInput("name", "Enter your name"),
  textOutput("name_message"),
)

server <- function(input, output, session) {
  
  output$message <- renderText({
    
    if (input$button == 0) {
      "Please click the button!"
    } else {
      paste("The button has been clicked", input$button, "times!")
    }
    
  })
  
  output$name_message <- renderText({
    if(nchar(input$name) == 0){
      "Write you name here!"
    } else{
      paste("Hello",input$name)
    }
  })
  
}

shinyApp(ui = ui, server = server)
