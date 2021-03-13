#1. This app will also use the COVID data.
#Make sure you load that data and all the libraries you need in the `app.R` file you create. 
#Below, you will post a link to the app that you publish on shinyapps.io. 
#You will create an app to compare states' cumulative number of COVID cases over time. 
#The x-axis will be number of days since 20+ cases and the y-axis will be cumulative cases on the log scale (`scale_y_log10()`). 
#We use number of days since 20+ cases on the x-axis so we can make better comparisons of the curve trajectories. 
#You will have an input box where the user can choose which states to compare (`selectInput()`) 
#and have a submit button to click once the user has chosen all states they're interested in comparing. 
#The graph should display a different line for each state, with labels either on the graph or in a legend. 
#Color can be used if needed. 


library(shiny)
library(tidyverse)




covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

state <- covid19%>%
  distinct(state) %>%
  arrange(state) 



ui <- fluidPage(selectInput("state", "State :", 
                            choices = state, 
                            multiple = TRUE),
                submitButton(text = "View State Case Trends!"),
                plotOutput(outputId = "CovidCases")
                
)
server <- function(input, output) { 
  output$CovidCases <- renderPlot({
    covid19 %>%
      group_by(state, date) %>%
      summarize(cum_cases = cumsum(cases)) %>%
      ungroup() %>%
      filter(cum_cases > 20) %>%
      filter(state %in% input$state) %>%
      ggplot(aes(x = date, y = cum_cases, group = state, color = state)) + 
      geom_line() + 
      scale_y_log10(labels = scales::comma) + 
      labs(title = "Trajectory of COVID Cases in US States", 
           x = "", 
           y = "Cumulative cases on log scale")
  })
  
}
shinyApp(ui = ui, server = server)