library(shiny)
library(httr)
library(tidyverse)
library(jsonlite)
library(rvest)
library(stringr)
library(shinythemes)

#shiny app server
server <- function(input, output) {
  output$find_movie <- renderUI({
    new_data <- df1 %>% filter(Year == input$user_year)
    movie_ops <- new_data %>% pull(Title)
    selectInput("user_movie", "Pick a Movie:", choices = c(movie_ops))
  })
  output$poster <- renderUI({
    if ("-" == input$user_year){
      tags$img(src = "https://m.media-amazon.com/images/M/MV5BYjJkZGVjMDMtMzNmZS00NDQ3LWE1YWEtMDlmYjExMTA4MGFkXkEyXkFqcGdeQXVyODY0NzcxNw@@._V1_UX45_CR0,0,45,67_AL_.jpg.png")
    }
    link = df1 %>% filter(Year == input$user_year, Title == input$user_movie) %>% pull(Img_Link)
    link = paste0(link, ".png")
    tags$img(src = link )
  })
  output$ranking <- renderText({
    r1 = df1 %>% 
      filter(Year == input$user_year, Title == input$user_movie) %>% 
      pull("Ranking")
    paste0("Ranking (Out of 50) : ", r1)
  })
  output$rating <- renderText({
    r1 = df1 %>% 
      filter(Year == input$user_year, Title == input$user_movie) %>% 
      pull("Rating")
    paste0("Rating (Out of 10 stars) : ", r1)
  })
  output$director<- renderText({
    r1 = df1 %>% 
      filter(Year == input$user_year, Title == input$user_movie) %>% 
      pull("Director")
    paste0("Director : ", r1)
  })
  output$synopsis<- renderText({
    r1 = df1 %>% 
      filter(Year == input$user_year, Title == input$user_movie) %>% 
      pull("Synopsis")
    paste0("Synopsis : ", r1)
  })
}

shinyApp(ui = ui, server = server)