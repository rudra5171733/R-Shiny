library(shiny)
ui <- fluidPage(
  h1("day 2 - Input Controls"),
  
  p("Welcome!"),
  
  textInput("name","Enter Your name"),
  
  numericInput("age","Enter Your Age",
               value = 25,
               min = 10,
               max = 70),
  
  textOutput("message")
)

server <- function(input,output,session){
  output$message <- renderText({
    paste("Hello!",input$name,
          "you are",input$age," years old")
  })
}

shinyApp(ui = ui,server = server)

#1

library(shiny)
ui <- fluidPage(
  h1("day 2 - Personal Information"),
  
  textInput("name","Enter Your name"),
  
  numericInput("age","Enter Your age",
               value = 25,
               min = 10,
               max = 80),
  
  numericInput("exp","Enter Your Experience",
               value = 1,
               max = 5,
               min = 0),
  selectInput("department","Select your department",
              choices = c("Statistics","Statistics and Computing","Biostatistics","Data Science"),
              selected = "Biostatistics"),
  radioButtons("gender",
               'Select your gender',
               choices = c("Male","female","Prefer Not to say"),
               selected = "Male"),
  checkboxInput("experienced","I have previous work experience"),
  sliderInput("salary",
              "Enter Your salary here",
              min = 10000,
              max = 100000,
              value = 25000),
  dateInput("dob",
            'Enter your date of birth:'),
  textOutput("message")
)

server <- function(input,output,session){
  output$message <- renderText({
    
    experience_status <- if (input$experienced) {
      "Yes"
    } else {
      "No"
    }
    
    paste(
      "Hello!", input$name,
      "Your age is", input$age,
      ", your experience is", input$exp, "years,",
      "your department is", input$department,
      "your gender is", input$gender,
      "Previous work experience:", experience_status,
      "Your Salary is:",input$salary,
      "your birthday is on:",input$dob
    )
    
  })
}

shinyApp(ui = ui,server = server)
