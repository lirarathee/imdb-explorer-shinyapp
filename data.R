library(shiny)
library(httr)
library(tidyverse)
library(jsonlite)
library(rvest)
library(stringr)
library(shinythemes)

#webscraping data
html <- read_html("https://www.imdb.com/chart/top/")

#extract movie titles
titles <- html %>% 
  html_nodes("td.titleColumn") %>%
  html_nodes("a") %>%
  html_text()
titles <- titles[1:50]

#extract movie ratings(out of 10 stars)
ratings <- html %>%
  html_nodes("td.ratingColumn.imdbRating") %>%
  html_nodes("strong") %>%
  html_text()
ratings <- ratings[1:50]

#extract IMDb ranking (out of 50)
rankings <- html %>%
  html_nodes("td.titleColumn") %>%
  html_text() 
r1 = substr(rankings[1:9], start=8, stop = 8)
r2 = substr(rankings[10:50], start=8, stop = 9)
rankings50 <- c(r1,r2)

#extract movie year
years <- html %>%
  html_nodes("span.secondaryInfo") %>%
  html_text
years <- years[1:50]
years1 <- str_remove(years,"[(]")
years <- str_remove(years1, "[)]")

#extract links to more info for each movie
links <- html %>%
  html_nodes("td.titleColumn") %>%
  html_nodes("a") %>%
  html_attr("href")
full_links <- paste("https://www.imdb.com/", links, sep = "")
full_links <- full_links[1:50] 

#extract directors, synopsis, and posters
directors <- c()
synopsis <- c()
imgs <- c()
for (link in full_links){
  html <- read_html(link)
  director <- html %>%   
    html_nodes("div.credit_summary_item") %>%
    html_nodes("a") %>%
    html_text()
  directors <- rbind(directors, director[1])
  syn1 <- html %>%   
    html_nodes("div.summary_text") %>%
    html_text() 
  synopsis <- rbind(synopsis, syn1[1])
  imgs1 <- html %>%
    html_nodes("div.poster") %>%
    html_nodes("a") %>%
    html_nodes("img") %>%
    html_attr("src")
  imgs <- rbind(imgs, imgs1[1])
}
synopsis1 <- str_remove(synopsis,"\n")
synopsis <- str_remove(synopsis1,"\n")

#all data
df1 = tibble("Title" = titles, "Rating" = ratings, "Ranking" = rankings50, "Year" = years, "Img_Link" = imgs, "Director" = directors, "Synopsis" = synopsis )

#user year choices
year_options <- df1 %>% select(Year)
year_options <- sapply(year_options, as.factor)
year_options <- sapply(year_options, as.numeric)
year_options <- sort(year_options)
