library(shiny)
library(ggplot2)
# http://www.theguardian.com/news/datablog/2010/may/05/world-cup-historical-statistics
# setwd("C:\\1.Analyses\\Learning - coursera\\7. Data products\\Project_WorldCupShinyApp")
data<-read.csv("world_cup_data.csv")
names(data) <- c("Year","Team", "ISO.code","Goals.for", "Goals.against", "Penalties","Matches", "Shots.on.goal", "Shots.wide", "Free.kicks", "Offside","Corners", "Won", "Drawn", "Lost")
Year <- unique(sort(data$Year))
Country <- unique(sort(data$Team))

shinyServer(function(input, output){
        output$columns <- renderUI({
                mydata <- get(input$dataset)
                selectInput('columns2', paste('By ', input$dataset), mydata)
        })
        output$myHist<- renderPlot({
                factors <- input$columns2
                
                if(input$dataset == 'Country'){
                        data_sub<-subset(data, Team == input$columns2)                                
                        p <- ggplot(data_sub, aes(x = Year, y = (Won/(Won+Drawn+Lost)*100))) + geom_bar(stat = "identity")+
                                scale_fill_manual("", values=c("target"="darkgrey","try"="blue"))+
                                scale_y_continuous(breaks=seq(0,100,10),limits=c(0,100),"% Matches won")+
                                scale_x_continuous(breaks=seq(1930,2010,4), limits=c(1930,2010),"Year")+
                                labs(title="Percentage of matches won",plot.title=element_text(colour = 'black', angle = 0, size = 16,hjust = 0.5, vjust = 1,face = 'bold'))+
                                theme(axis.title.x = element_text(size = 14, vjust = -1))+
                                theme(axis.title.y = element_text(size = 14, angle=90, vjust=0))+
                                theme(axis.text.x = element_text(size = 10,colour="black",vjust = 0, angle = 90))+
                                theme(axis.text.y = element_text(size = 12,colour="black"))
                        print(p)
                }else{
                        data_sub<-subset(data, Year == input$columns2)
                        p <- ggplot(data_sub, aes(x = Team, y = (Won/(Won+Drawn+Lost)*100))) + geom_bar(stat = "identity")+
                                scale_fill_manual("", values=c("target"="darkgrey","try"="blue"))+
                                scale_y_continuous(breaks=seq(0,100,10),limits=c(0,100),"% Matches won")+
                                labs(title="Percentage of matches won",plot.title=element_text(colour = 'black', angle = 0, size = 16,hjust = 0.5, vjust = 1,face = 'bold'))+
                                theme(axis.title.x = element_text(size = 14, vjust = -1))+
                                theme(axis.title.y = element_text(size = 14, angle=90, vjust=0))+
                                theme(axis.text.x = element_text(size = 10,colour="black",vjust = 0, angle = 90))+
                                theme(axis.text.y = element_text(size = 12,colour="black"))
                        print(p)
                }
        })  
}
)