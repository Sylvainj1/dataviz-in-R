ui <- fluidPage(
  
  fluidRow(
    h1("Pourquoi passer à l'electrique ?"),
    p("Aujourd'hui nous entendons beaucoup parler des voitures électriques, notamment face
      à l'urgence écologique. Mais beaucoup de questions se posent lorsque l'on considère acheter un véhicule electrique :
      Y a t-il assez de chargeur ? Quel est le temps de charge ? Quelle autonomie dois-je considerer ?
      Est t'il le temps pour vous de passer au tout électrique et laisser votre von vieux thermique de coté ?")
  ),
  
  titlePanel("Evolution du nombre de borne de recharge en France par trimestre"),
  
  plotlyOutput(outputId = "evolution_plot"),
  
  fluidRow(
    p("Le nombre de bornes de recharges a été multiplié par 5 depuis 2015. Le nomnbre de borne de recharge publique lui
      a triplé sur l'essemble du térritoire francais"),
    p("Sur le graphique suivant vous pouvez selectionner votre Région et voir le nombre de borne disponible
      dans votre département")
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
    h3("Fiche Technique"),
    htmlOutput("carplot")
  ),
  
  titlePanel("Fiche technique"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="car",
                  label="Voiture :",
                  choices = sort(cardata$name),
                  )
      ),
    
    mainPanel(
      plotOutput("timeplot")
    )
    ),
  
  titlePanel("Comparer le temps de charge des voitures"),
  
  sidebarLayout(
    sidebarPanel(
      selectizeInput("voitureid",
                     label="Selectionner les voitures",
                     choices=sort(cardata$name),
                     multiple=T,
                     options = list(maxItems=6,placeholder="Choisir des voitures"),
                     selected=sort(cardata$name)[1:3]
                     ),
      selectInput(inputId = "bornepower",
                  label = "Selectionner la puissance d'une borne de recharge (kW)",
                  choices = sort(data$Puissance.délivrée),
                  selected = unique(data$Puissance.délivrée["3"]),
                  )
    ),
    mainPanel(
      plotOutput("carcomparaison", width=550)
    )
  ),
  
)





