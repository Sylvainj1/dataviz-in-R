# data = read.csv("data.csv",sep=';',header = TRUE,na.strings = ".")
# data=data[complete.cases(data), ]
# data$Condition.d.accès=strtrim(data$Condition.d.accès,7)
# data=filter(data,Condition.d.accès=="gratuit" | Condition.d.accès =="payant")

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
}
