library(shiny)
library(tidyverse)

covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")


ui <- fluidPage("make a small change")
server <- function(input, output) {}
shinyApp(ui = ui, server = server)