library(tidyverse)
library(tidyr)
library(shiny)
library(datasets)
library(ggplot2)
library(dplyr)
library(plotly)

server <- function(input, output) {
  
  
  graph<-reactive({
    
    filter(data,Nom.de.la.région==input$region) %>% 
      group_by(Nom.de.la.région=input$region,Nom.du.département,Condition.d.accès) %>% 
      summarize(Number=length(Nom.du.département)) %>% 
      ggplot(aes(x=Nom.du.département,y=Number, fill = Condition.d.accès)) + 
      geom_bar(stat = "identity")+
      geom_text(aes(label=Number),color="black",position=position_stack(0.5))+
      labs(fill="Conditions d'accès",y="Nombre de borne",x="Nom du département")+
      theme(axis.text.x = element_text(angle = 45,hjust = 1))
  })
  
  output$borneplot <- renderPlot({
    graph()
  })
  
  # output$evolution_plot <- renderPlotly({
  #   
  #   data_evolution_station_long %>%
  #     ggplot(aes(x=Trimestre, y = Nombre , fill= Type)) +
  #     geom_bar(stat= "identity") + theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = .5))
  #   
  # })
}
