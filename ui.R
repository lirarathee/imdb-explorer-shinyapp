library(shiny)
library(httr)
library(tidyverse)
library(jsonlite)
library(rvest)
library(stringr)
library(shinythemes)

#shiny app ui
ui <- navbarPage("Silence your phone, enjoy!", theme= shinytheme("cyborg"),
                 tabPanel("Top 50", 
                          h1("IMDb Explorer", align = "center"),
                          h2("--- a new way to explore your favorite films ---", align = "center", style = "font-size:95%"),
                          br(),
                          br(),
                          sidebarLayout(
                            sidebarPanel(
                              tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/IMDB_Logo_2016.svg/375px-IMDB_Logo_2016.svg.png", height = "80%", width = "80%", align = "center"),
                              selectInput("user_year", "Choose a Release Year:", choices = c(year_options)),
                              uiOutput("find_movie")),
                            mainPanel(  
                              uiOutput("poster", align = "center"),
                              br(),
                              br(),
                              textOutput("ranking"),
                              br(),
                              textOutput("rating"),
                              br(),
                              textOutput("director"),
                              br(),
                              textOutput("synopsis"),
                              br(),
                              br()
                            ))
                 ),
                 tabPanel("About",
                          h2("Q&A", align = "center"),
                          h4("Where is the data from?"),
                          br(),
                          p("The data was scraped from the IMDb Top Rated Movies List. IMDb is a platform 
                   for everyday users to learn more about their favorite movies and tv shows. Users
                   are able to write their own reviews and give ratings out of 10 stars."),
                          br(),
                          h4("What is a ranking?"),
                          br(),
                          p("A ranking shows a movie's place on the IMDb Top Rated Movies list. 
          If a movie has a rank of 1 it shows that the movie is at the top of the list, i.e. the best rated."),
                          br(),
                          h4("How are rankings determined?"),
                          br(),
                          p("Rankings are Bayesian estimates and are determined by the following equation:"),
                          p("weighted rating (WR) = (v ÷ (v+m)) × R + (m ÷ (v+m)) × C", align = "center"),
                          p("Where:"),
                          p("R = average for the movie (mean) = (rating)"),
                          p("* A movie's rating is how many stars it gets out of 10."),
                          p("v = number of votes for the movie = (votes)"),
                          p("m = minimum votes required to be listed in the Top Rated list (currently 25,000)"),
                          p("C = the mean vote across the whole report"),
                          br(),
                          p(" Movies are then ranked based on these weighted ratings."),
                          br(),
                          h4("More Information:"),
                          br(),
                          p("All data, as well as the equation to calculate rankings, are the property of IMDb. "),
                          p("App developed by Lira Rathee."),
                          br(),
                          br(),
                          tags$img(src ="https:////upload.wikimedia.org/wikipedia/commons/thumb/9/91/Oxford_-_Ultimate_Palace_Cinema_-_0084.jpg/250px-Oxford_-_Ultimate_Palace_Cinema_-_0084.jpg.png", style="display: block; margin-left: auto; margin-right: auto;"),
                          br()
                 )
)
