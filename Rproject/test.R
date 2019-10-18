<<<<<<< HEAD

=======
>>>>>>> 014b450471fabfb3e11a12308220fa343c0fd2f7
library(shiny)

data = read.csv("data.csv",sep=';',header = TRUE,na.strings = ".")
data=data[complete.cases(data), ]
data$Condition.d.accès=strtrim(data$Condition.d.accès,7)
data=filter(data,Condition.d.accès=="gratuit" | Condition.d.accès =="payant")

ui <- fluidPage(
  
  titlePanel("Puissance de recharge dans la ville"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)


server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

shinyApp(ui = ui, server = server)
