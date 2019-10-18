ui <- fluidPage(
  
  fluidRow(
    h1("Dois-je acheter une voiture electrique ?"),
    p("Aujourd'hui on etend beaucoup parler des voitures électriques, notamment face
      à l'urgence écologique. Est t'il le temps pour vous de passer au tout électrique
      et laisser votre von vieux thermique de coté ?")
  ),
  
  fluidRow(
    img(src="audi_image_top.png",width = 439, height= 289),
    ),
  
  
  sidebarLayout(
    sidebarPanel("test"),
    mainPanel(
      plotlyOutput(outputId = "evolution_plot")
    )
  ),
  
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
  
  titlePanel("Temps de recharge selon la puissance de la borne"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="car",
                  label="Voiture :",
                  choices = "Audi e-tron",
                  )
      ),
    mainPanel(
      tableOutput("carplot")
    )
    ),
  # titlePanel("test"),
  # mainPanel(
  #   plotlyOutput(outputId = "evolution_plot"))
  
)





