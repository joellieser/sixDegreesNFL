library(shiny)
library(igraph)
load("www/data/k.RData")
load('www/data/g2.RData')

shinyServer(function(input, output, session) {
    updateSelectInput(session, 'fromPlayer', choices = k[grep("^\\D", k)])
    updateSelectInput(session, 'toPlayer', choices = k[grep("^\\D", k)])
    output$fromPlayer <- reactive({
        if(input$goButton > 0) {
            isolate(input$fromPlayer)
        }
    })
    output$toPlayer <- reactive({
        if(input$goButton > 0) {
            isolate(input$toPlayer)
        }
    })    
    output$myNetwork <- renderPlot({
        if(input$goButton > 0) {
            h <- get.shortest.paths(g,which(k==input$fromPlayer),which(k==input$toPlayer))$vpath
            tempList <- h[[1]]
            toFroms = NA
            for(i in 1:length(tempList)){
                toFroms[length(toFroms)+1] = tempList[i]
                if(i != 1 && i != length(tempList)){
                    toFroms[length(toFroms)+1] = tempList[i]                 
                }
            }    
            toFroms = toFroms[-1]
            toFroms2 <- k[toFroms]
            toFromsMatrix = matrix(toFroms2,ncol=2,byrow=TRUE)
            toFromsDF=graph.data.frame(toFromsMatrix)
            get.adjacency(toFromsDF,sparse=FALSE)
            layout1 <- layout.fruchterman.reingold(toFromsDF)
            plot(toFromsDF, layout=layout1,edge.arrow.size=0)
        }
    })
})
