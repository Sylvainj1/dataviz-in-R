server <- function(input, output) {
  
  output$evolution_plot <- renderPlotly({
      
    data_evolution_station_long %>%
      ggplot(aes(x=Trimestre, y = Nombre , fill= Type)) +
      geom_bar(stat= "identity") + theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = .5))
    
  })
  
  
  borneDeRecharge<-reactive({
    
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
    borneDeRecharge()
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
  
  
  output$carcomparaison <- renderPlotly({
    dataSubset <- reactive({
      validate(
        need(input$voitureid != "","Selectionnez au moins une voiture")
      )
      filter(cardata, name %in% input$voitureid)
      })
    
    output$carcomparaison <- renderPlot({
      ggplot(dataSubset(),aes(x=name,y=range, color=name, fill= name))+
        geom_bar(stat='identity') + 
        theme(axis.text.x = element_text(angle = 30, hjust = .5, vjust = .5),legend.position = "none")+
        labs(x="",y="Autonomie (km)")+
        geom_text(aes(
          label=format(round(battery/as.double(input$bornepower),2),nsmall=2)
          ),
          color="black",
          position=position_stack(0.5)) +
        geom_text(aes(
          label="Tps charge (H)"
        ),
        color="black",
        position=position_stack(0.6)) 
      
    })
  })
  
  
  
  
  
}
