library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("NFL version of 6 degrees of separation"
             ),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
        selectInput(inputId='fromPlayer',label = 'FROM:', c(Choose='', '')),
        selectInput(inputId='toPlayer',label = 'TO:', c(Choose='', '')),
        actionButton("goButton", "Submit")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h4("Instructions: Select two players from the history of the NFL in the FROM: and TO: lists to the left and hit submit to see how they are connected (a NFL version of Six Degrees of Separation). "),
      h5("Hint:  The dropdown can only display so many names.  If the player you are interested in isn't showing, simply erase the name in the dropdown and begin typing the name in the dropdown and it should show up."),
      br(),
      plotOutput('myNetwork') 
    )
  )
))
