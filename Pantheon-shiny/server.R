library(shiny)
library(leaflet)





shinyServer(function(input, output) {
  
  movies <- reactive({
    pantheon <- read.csv("database.csv")
    most_popular <- pantheon %>% filter(page_views > 10000000) %>% filter(!is.na(latitude))
    min_year <- input$Year[1]
    max_year <- input$Year[2]
    domain1 <- input$domain
    
    new_data <- most_popular %>% 
      filter(
        birth_year > min_year,
        birth_year < max_year,
        domain %in% domain1)
    
    new_data <- as.data.frame(new_data)
  }) 
  
  
  output$distPlot <- renderLeaflet({
    
    leaflet(data = new_data) %>% addTiles() %>% addMarkers(~longitude,
                                                               ~latitude, 
                                                               label= ~full_name, 
                                                               popup= paste(most_popular$full_name,"<br>",
                                                                            most_popular$birth_year)) %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap)
   
    
  })
  
})
