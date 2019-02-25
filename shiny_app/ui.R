library(shiny)
library(rsconnect)
library(ggplot2)


library(markdown)


navbarPage("Arktis!",
           tabPanel("Lämpötila eri vuosina ja leveysasteilla",
                   
                    sidebarPanel(
                      p("Nähdäkseesi lämpötilan vaihtelua tietyn vuoden aikana ja tietyllä leveysasteella, valitse vuosi [1900, 2017] ja leveysaste [-90, 90]"),
                      numericInput( inputId = "year1", label = "Vuosi 1900-2017", value = 1900, min = 1900, max = 2017, step = 1),
                      numericInput( inputId = "latitude1", label = "Leveysaste", value = 0, min = -90, max = 90, step = 1),
                      numericInput( inputId = "year2", label = "Vuosi 1900-2017", value = "", min = 1900, max = 2017, step = 1),
                      numericInput( inputId = "latitude2", label = "Leveysaste", value = "", min = -90, max = 90, step = 1),
                      numericInput( inputId = "year3", label = "Vuosi 1900-2017", value = "", min = 1900, max = 2017, step = 1),
                      numericInput( inputId = "latitude3", label = "Leveysaste", value = "", min = -90, max = 90, step = 1),
                      numericInput( inputId = "year4", label = "Vuosi 1900-2017", value = "", min = 1900, max = 2017, step = 1),
                      numericInput( inputId = "latitude4", label = "Leveysaste", value = "", min = -90, max = 90, step = 1),
                      actionButton("updateButton", label = "Päivitä")),
                    mainPanel(
                      plotOutput("climateDuringTheSpecificYear"), width = "100%" )
                    ),
           tabPanel("Lämpötilan muutos eri leveysasteilla",
                    sidebarPanel( 
                      p("Nähdäksesi miten tietyn leveysasteen keskilämpötila muuttui vuodesta 1900 vuoteen 2017, valitse leveysaste [-90, 90]"),
                      numericInput( inputId = "latitudeA1", label = "Leveysaste", value = 0, min = -90, max = 90, step = 1),
                      numericInput( inputId = "latitudeA2", label = "Leveysaste", value = "", min = -90, max = 90, step = 1),
                      numericInput( inputId = "latitudeA3", label = "Leveysaste", value = "", min = -90, max = 90, step = 1),
                      actionButton("updateButtonA", label = "Päivitä")),
                    mainPanel(
                      plotOutput("climateDuringLastCenture"), width = "100%")
                    ),
           tabPanel("Tehtävä 4",
                    mainPanel(
                      includeHTML("tehtava4.html") ) ),
           tabPanel("Tehtävä 5",
                    mainPanel(
                      includeHTML("tehtava5.html") ) ),
           tabPanel("Muuta",
                    mainPanel(
                      includeHTML("muuta.html") 
                      )
           )
)



