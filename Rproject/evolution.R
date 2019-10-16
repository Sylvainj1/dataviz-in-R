library(shiny)
library(dplyr)
library(tidyverse)
library(tidyr)
library(gganimate)
library(gifski)


data_evolution_station <- read.csv("nombre-total-de-points-de-charge.csv", sep=";",header = TRUE)
data_evolution_station_long <- data_evolution_station %>% pivot_longer(c(Accessible.au.public,Particulier,Société),names_to = "Type", values_to = "Nombre")



# Define UI for application that draws a histogram
ui <- fluidPage(
  # title
  titlePanel("Evolution du nombre de borne de recharge en France par trimestre"),
  # Main panel
  mainPanel(plotOutput(outputId = "evolution_plot"))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$evolution_plot <- renderPlot({
    
    data_evolution_station_long %>%
      ggplot(aes(x=Trimestre, y = Nombre , fill= Type)) +
      geom_bar(stat= "identity") +
      transition_states(Trimestre, wrap = FALSE) +
      shadow_mark() +
      enter_grow() +
      enter_fade()
    
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
