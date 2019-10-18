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
  ),
  # titlePanel("test"),
  # mainPanel(
  #   plotlyOutput(outputId = "evolution_plot"))
  
)





