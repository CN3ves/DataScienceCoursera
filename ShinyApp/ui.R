library(shiny) 

shinyUI(pageWithSidebar(
    headerPanel("BMI prediction tool"), 

# Side panel INPUTS    
    sidebarPanel(
        h3("User inputs"),
        h5("Change measure units?"),
        checkboxGroupInput("units","(Default measurements are in inches and pounds)",
                           c("Meters and Kilograms")),
        
        h3("Values"),
        textInput("iheight","Height",65),
        textInput("iweight","Weight",135),
        
        submitButton('Check'),
        
        p("Documentation:",a("HELP",href="README.html"))
    ),

# Main panel OUTPUTS
    mainPanel(
        h3('Height'),
        p("(If input is empty, the value is predicted from weight)"),
        verbatimTextOutput("oheight"),
        p("Height shown in"),
        verbatimTextOutput("oheight2"),
        
        h3('Weight'),
        p("(If input is empty, the value is predicted from height)"),
        verbatimTextOutput("oweight"),
        p("Weight shown in"),
        verbatimTextOutput("oweight2"),
        
        h3('Body mass index'),
        verbatimTextOutput("obmi"),
        p("Your BMI suggests:"),
        verbatimTextOutput("obmi2")
    ) 
))
