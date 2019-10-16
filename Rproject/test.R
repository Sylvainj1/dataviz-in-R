data = read.csv("data.csv",sep=';',header = TRUE,na.strings = ".")
data=data[complete.cases(data), ]
data$Condition.d.accès=strtrim(data$Condition.d.accès,7)
data=filter(data,Condition.d.accès=="gratuit" | Condition.d.accès =="payant")

library(shiny)
library(datasets)
library(ggplot2)
library(tidyverse)

ui <- fluidPage(
  
  titlePanel("Borne de recharge selon le département"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "region", 
                  label = "Région:", 
                  unique(data$Nom.de.la.région)),
      
    ),
    mainPanel(
      plotOutput("borneplot")  
    )
)
)

server <- function(input, output) {
  

  graph<-reactive({
    ggplot(data = filter(data,Nom.de.la.région==input$region),
           aes(x=Nom.du.département,
               y = Puissance.délivrée,
               fill=Condition.d.accès)) +
      geom_bar(stat="identity", position=position_dodge() )+
      labs(fill="Conditions d'accès",y="Puissance délivrée",x="Nombre de Points de charge")+
      theme(axis.text.x = element_text(angle = 45,hjust = 1)) 
  })
  
  output$borneplot <- renderPlot({
    graph()
  })
}


shinyApp(ui = ui, server = server)

