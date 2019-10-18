# data = read.csv("data.csv",sep=';',header = TRUE,na.strings = ".")
# data=data[complete.cases(data), ]
# data$Condition.d.accès=strtrim(data$Condition.d.accès,7)
# data=filter(data,Condition.d.accès=="gratuit" | Condition.d.accès =="payant")

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