 library(shiny)
 library(ggplot2)
# 
# ui <- fluidPage(
#     headerPanel("Example eventReactive"),
#     
#     mainPanel(
#         
#         # input field
#         textInput("user_text", label = "Enter some text:", placeholder = "Please enter some text."),
#         
#         # submit button
#         actionButton("submit", label = "Submit"),
#         
#         # display text output
#         textOutput("text"))
# )
# 
# server <- function(input, output) {
#     
#     # reactive expression
#     text_reactive <- eventReactive( input$submit, {
#         input$user_text
#     })
#     
#     # text output
#     output$text <- renderText({
#         text_reactive()
#     })
# }
# 
# shinyApp(ui = ui, server = server)

ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            fileInput("file1", "Choose CSV File", accept = ".csv"),
            checkboxInput("header", "Header", TRUE)
        ),
        mainPanel(
            tableOutput("contents"), 
            plotOutput('p1')
        )
    )
)
#save csv as df
#edit df
#output df as csv
server <- function(input, output) {
    options(shiny.maxRequestSize=30*1024^2) #30mb limit
    output$contents <- renderTable({
        file <- input$file1
        ext <- tools::file_ext(file$datapath)
        req(file)
        validate(need(ext == "csv", "Please upload a csv file"))
        df <- read.csv(file$datapath, header = input$header)
        head(df)
    })
    
    output$p1 <- renderPlot({
        file <- input$file1
        ext <- tools::file_ext(file$datapath)
        req(file)
        validate(need(ext == "csv", "Please upload a csv file"))
        df <- read.csv(file$datapath, header = input$header)
        ggplot(df) + 
            geom_line(aes(x = df[,1], y = df[,2])) +
            xlab(names(df)[1]) + ylab(names(df)[2])
    })
}

shinyApp(ui, server)

#hmm need a lot more ui interface to get something like the ggplot gui working, reactive/observer
#objects are probably necessary to modify and display a table/dataframe output in real time
