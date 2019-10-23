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
  
  output$evolution_plot <- renderPlotly({
      
    data_evolution_station_long %>%
      ggplot(aes(x=Trimestre, y = Nombre , fill= Type)) +
      geom_bar(stat= "identity") + theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = .5))
    
  })
  
  output$carplot <- renderUI({
    car=filter(cardata,name==input$car)
    acc <- paste("Acceleration 0-100 km/h : ", car$acceleration, "s")
    aut <- paste("Autonomie : ", car$range, "km")
    batt <- paste("Batterie utilisable : ", car$battery, "kWh")
    place <- paste("Place : ", car$seats)
    price <- paste("Prix : ", car$price, "K€")
    HTML(paste(acc,aut,batt,place,price,sep = "<br/>"))
  })
  # output$carplot <- renderText({
  #   car=filter(cardata,name==input$car)
  #   
  #   paste("Accelération 0-100 km/h : ",car$acceleration,
  #         "Autonomie : ",car$range,
  #         "Batterie utilisable : ",car$battery,
  #         sep = " ",
  #         )
  # })
  
  output$timeplot <- renderPlot({
    car=filter(cardata,name==input$car)
    data %>% group_by(Puissance.del=Puissance.délivrée) %>%  summarize(Temps.recharge=car$battery/unique(Puissance.délivrée)) %>% 
    ggplot(aes(x= Temps.recharge, y = Puissance.del, color = Temps.recharge)) + geom_line() + scale_color_gradient(low="green", high="red")
  })
}
