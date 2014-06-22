
library(shiny)
library(ggplot2)
shinyUI(pageWithSidebar(
        headerPanel("Football World Cup: percentage of matches won to 2006"),
        sidebarPanel(
                selectInput('dataset', 'Choose to present summaries by Year or by Country', c('Country', 'Year')),
                uiOutput('columns')
        ),
        mainPanel(
                h5('This app allows you to view the percentage of matches won by each country within a World Cup (by year option) or the percentage of mayches won by a country over all World Cups to 2006 (by Country option)'),
                h5('Simply choose By Country and then a Country of interest. Otherwise choose By Year and choose Year of interest.'),
                h5('Data from: http://www.theguardian.com/news/datablog/2010/may/05/world-cup-historical-statistics'),
                plotOutput('myHist')
        )
)
)