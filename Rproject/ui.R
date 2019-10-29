ui <- fluidPage(
  
  fluidRow(
    h1("Pourquoi passer à l'électrique ?"),
    p("Aujourd'hui nous entendons beaucoup parler des voitures électriques, notamment face
      à l'urgence écologique. Mais beaucoup de questions se posent lorsque l'on considère acheter un véhicule electrique :
      Y a t-il assez de chargeurs ? Quel est le temps de charge ? Quelle autonomie dois-je considerer ?
      Est t'il le temps pour vous de passer au tout électrique et laisser votre bon vieux thermique de coté ?"),
    
    div(style="display: inline-block;vertical-align:top;margin-left:200px;",
        img(src="audi_image_top.png",width = 439, height= 289),
    ),
  ),
  
  titlePanel("Evolution du nombre de borne de recharge en France par trimestre"),
  
  plotlyOutput(outputId = "evolution_plot"),
  
  fluidRow(
    p(""),
    p("Le nombre de bornes de recharges a été multiplié par 5 depuis 2015. Le nombre de borne de recharge publique
      a triplé sur l'essemble du territoire francais"),
    p("Sur le graphique suivant vous pouvez selectionner votre région et voir le nombre de borne disponible
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
  
  br(),
  
  fluidRow(
    p("Dans la majorité des cas la recharge est payante, néanmoins le coût de recharge d'un véhicule electrique
    est moindre comparé à l'essence d'un thermique."),
    p("
    Contrairement à d’autres pays européens, la France n’autorise pas aux opérateurs une facturation au kWh délivré.
    Le prix est alors souvent fixé en temps et celui ci depend de la puissance de la borne et de l'opérateur mais dépasse
    très rarement 5€/30min pour des bornes de plus de 50 Kw
    "),
    p("
    Il est aussi possible de prendre un forfait mensuel chez un opérateur de borne de recharge, et ainsi bénéficier d'autant
    de recharge voulu pour un certain prix par mois.
    Evidemment cette option limite les bornes utilisables car vous devrez recharger sur les bornes de votre opérateur.
      "),
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
      htmlOutput("carplot")
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
      plotOutput("carcomparaison")
    )
  ),
  
  fluidRow(
    br(),
    p("Le temps de recharge est estimé en fonction de la capacité de la batterie et de la puissance du chargeur.
    Les véhicules assez haut de gamme possèdent l'option 'fastcharge' qui permet de décupler
    la puissance de charge du véhicules entre un certain % de batterie.
      "),
    p("Les superchargeur Tesla et Ionity ne sont pas incluent dans la selection, ces chargeurs possèdent une
      puissance de charge minimum de 150 Kw permettant de charger très rapidement les véhicules, descendant souvent
      en dessous de la barres de 35min pour une charge complète. A titre d'exemple la nouvelle porsche taycan 
      recharge 80% en 15mins sur un chargeur ionity de 230 Kw ")
  ),
  
  fluidRow(
    br(),
    br(),
    p("Lien vers les jeux de données utilisés : "),
    a("Evolution du nombre de points de recharge", href="https://data.enedis.fr/explore/dataset/nombre-total-de-points-de-charge/information/?flg=fr&sort=-trimestre"),
    p(""),
    a("Data des bornes electriques", href="https://public.opendatasoft.com/explore/dataset/fichier-consolide-des-bornes-de-recharge-pour-vehicules-electriques-irve/information/?flg=fr"),
    p(""),
    p("Données des véhicules electriques scrapés depuis ce lien grâce à un script pyhton utilisant beautiful soup (le script est disponible dans le projet python)"),
    a("Données véhicules electriques", href="https://ev-database.org/compare/newest-upcoming-electric-vehicle"),
    p(""),
    p(""),
    p(""),
  ),
  
)





