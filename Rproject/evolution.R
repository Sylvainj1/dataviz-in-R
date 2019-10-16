library(shiny)
library(dplyr)
library(tidyverse)
library(tidyr)
library(plotly)


data_evolution_station <- read.csv("nombre-total-de-points-de-charge.csv", sep=";",header = TRUE) %>% rename(Public = Accessible.au.public)
data_evolution_station_long <- data_evolution_station %>% pivot_longer(c(Public,Particulier,Société),names_to = "Type", values_to = "Nombre")



# Define UI for application that draws a histogram
ui <- fluidPage(
  # title
  titlePanel("Evolution du nombre de borne de recharge en France par trimestre"),
  # Main panel
  mainPanel(plotlyOutput(outputId = "evolution_plot"))
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$evolution_plot <- renderPlotly({

    data_evolution_station_long %>%
      ggplot(aes(x=Trimestre, y = Nombre , fill= Type)) +
      geom_bar(stat= "identity") + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5))

  })

}

# Run the application 
shinyApp(ui = ui, server = server)
