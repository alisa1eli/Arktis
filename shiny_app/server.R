library(shiny)
library(fmsb)

server <- function(input, output) {
  data <- read.csv(file="data/data.csv", header=TRUE)
  months <- colnames(data)[3:14]
  row1 <- rep (NA, 12)
  row2 <- rep (NA, 12)
#  year <- c(1900, NA, NA, NA)
#  latitude <- c(0, NA, NA, NA)
  
  year <- eventReactive(input$updateButton, {
    c(input$year1, input$year2, input$year3, input$year4)
  })
  latitude <- eventReactive(input$updateButton, {
    c(input$latitude1, input$latitude2, input$latitude3, input$latitude4)
  })
  
  latitudesA <- eventReactive(input$updateButtonA, {
    c(input$latitudeA1, input$latitudeA2, input$latitudeA3, input$latitudeA4)
  })
  
  d <- rbind(row1, row2)
  colnames(d) <- months
  
  
  output$climateDuringTheSpecificYear <- renderPlot({
    for(i in 1:4) {
      if(!is.na(year()[i])) {
        d <- rbind(d, data[data$year == year()[i] & round(data$latitude) == latitude()[i],3:14][1,])
        rownames(d) <- c(rownames(d)[1:(nrow(d)-1)], paste(year()[i],latitude()[i], sep = ', '))
      }
    }
    d <- rbind(d,rep(0, 12)) 
    rownames(d) <- c(rownames(d)[1:(nrow(d)-1)], "Zero Celsius")
    d <- round(d)
    max <- max(d, na.rm = T) + 2
    min <- min(d, na.rm = T) - 2
    d[1, ] <- rep(max, 12)
    d[2, ] <- rep(min, 12)
    
    colors <- c("red", "blue", "orange", "green")
    
    radarchart(d, axistype=1,
               cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(min,max,(max - min)/4), cglwd=0.8,
               vlcex=1, pcol=c(colors[1: (nrow(d)-3)], "grey"),
               plwd=2 , plty=1)
    legend(x=1, y=1.2, legend = rownames(d)[3:nrow(d)], pch=20 , c(colors[1: (nrow(d)-3)], "grey") , cex=1, pt.cex=0)
  }, height = 700, width = 750)
  
  # Climate change on the certain latitudes during last centure.
  output$climateDuringLastCenture <- renderPlot({
    d_A <- rep(NA, 4)
    for(j in 1:3) {
      if(!is.na(latitudesA()[j])) {
        temp <- data[round(data$latitude) == latitudesA()[j],]
        t <- as.double(temp[temp$year == 1900,][1,3:14])
        a <- data.frame(1900, latitudesA()[j], mean(t), var(t))
        colnames(a) <- c("year_A", "latitude_A", "mean_temp_A", "var_temp_A")
        yearsA <- 1900 : 2017
        for (i in 2:length(yearsA)) {
          t <- as.double(temp[temp$year == yearsA[i],][1,3:14])
          mean <- mean(t)
          var <- var(t)
          a <- rbind(a, c(yearsA[i],latitudesA()[j], mean, var) )
        }
        d_A <- rbind(d_A, a)
      }
    }
    d_A <- d_A[2:nrow(d_A),]
    d_A <- data.frame(d_A)
    colnames(d_A) <- c("year_A", "latitude_A", "mean_temp_A", "var_temp_A")
    ggplot(data = d_A, aes(x = year_A, y = mean_temp_A, color = as.factor(latitude_A))) +
      geom_point() +
      geom_smooth(size = 0.5, se = F) +
      xlab("Vuosi") +
      ylab("Keskilämpötila") +
      labs(color = "Leveysaste")
  },height = 700, width = 850)
}
