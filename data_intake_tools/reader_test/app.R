#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(readxl)

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel("Read A File"),
    sidebarLayout(
        sidebarPanel(
            actionButton("select_file", "Select File"), #first field is button id, second is text display
            selectInput("select",
                        "Choose Input Type",
                        c('csv' = 'csv', 'xlsx' = 'xlsx')),
            actionButton('disp_file', 'Display File')
        ),
        # Show a plot of the generated distribution
        mainPanel(
            textOutput('text1')
            #tableOutput('t1')
        )
    )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    output$text1 <- renderText({
        d <- file.choose()
        d
    })
    
    # output$t1 <- renderTable({
    #     input$disp_file
    #     if(input$select == 'csv'){
    #         df <- read.csv('text1')
    #     }
    #     if(input$select == 'xlsx'){
    #         df <- read_xlsx('text1')
    #     }
    #     df
    # })
    
    #     output$distPlot <- renderPlot({
    #         # generate bins based on input$bins from ui.R
    #         x    <- faithful[, 2]
    #         bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    #         # draw the histogram with the specified number of bins
    #         hist(x, breaks = bins, col = 'darkgray', border = 'white')
    #     })
}

# Run the application 
shinyApp(ui = ui, server = server)
