ui <- fluidPage(
  
  fluidRow(
    h1("Dois-je acheter une voiture electrique ?"),
    p("Aujourd'hui on etend beaucoup parler des voitures électriques, notamment face
      à l'urgence écologique. Est t'il le temps pour vous de passer au tout électrique
      et laisser votre von vieux thermique de coté ?")
  ),
  
  div(style="display: inline-block;vertical-align:top;",
      img(src="audi_image_top.png",width = 439, height= 289),
  ),
  
  div(style="display: inline-block;vertical-align:top;margin-left:50px",
      h3("Fiche technique"),
      p("Puissance : 402ch - 300kw"),
      p("Accelération 0-100 km/h : 5,7s"),
      p("Autonomie : 417 km"),
      p("Batterie utilisable : 83,6 kWh"),
      p("Trasmission : traction intégrale"),
  ),
  titlePanel("Evolution du nombre de borne de recharge en France par trimestre"),
  
  # fluidRow(
  #   
  #   img(src="audi_image_top.png",width = 439, height= 289),
  #   p("salut",)
  #   ),
  
  
  plotlyOutput(outputId = "evolution_plot"),
  
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
  
  
  titlePanel("Fiche technique"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="car",
                  label="Voiture :",
                  choices = cardata$name,
                  )
      ),
    
    mainPanel(
      tableOutput("carplot"),
      tableOutput("timeplot")
    )
    ),
  # titlePanel("test"),
  # mainPanel(
  #   plotlyOutput(outputId = "evolution_plot"))
  
)





