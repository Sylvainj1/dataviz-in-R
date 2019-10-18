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
  
  sidebarLayout(
    sidebarPanel("test"),
    mainPanel(
        plotlyOutput(outputId = "evolution_plot")
      )
  )
  # titlePanel("test"),
  # mainPanel(
  #   plotlyOutput(outputId = "evolution_plot"))
  
)





