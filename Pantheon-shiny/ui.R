library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("Year",
                   "Number of bins:",
                   min = -3500,
                   max = 2100,
                   step = 100,
                   value = c(0,500), animate = TRUE),
       
       checkboxGroupInput("domain", "Domain",
                          unique(most_popular$domain), 
                          selected = unique(most_popular$domain))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       leafletOutput("distPlot")
    )
  )
))
