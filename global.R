# stationnames <- c(
#   'KING GEORGE STATION',
#   'SURREY CENTRAL STATION',
#   'GATEWAY STATION',
#   'SCOTT ROAD STATION',
#   'COLUMBIA STATION',
#   'NEW WESTMINSTER STATION',
#   '22ND STREET STATION',
#   'EDMONDS STATION',
#   'ROYAL OAK STATION',
#   'METROTOWN STATION',
#   'PATTERSON STATION',
#   'JOYCE-COLLINGWOOD STATION',
#   '29TH AVENUE STATION',
#   'NANAIMO STATION',
#   'COMMERCIAL-BROADWAY STATION PLATFORM 4',
#   'MAIN STREET-SCIENCE WORLD STATION',
#   'STADIUM-CHINATOWN STATION',
#   'GRANVILLE STATION',
#   'BURRARD STATION',
#   'WATERFRONT STATION'
# )





library(dplyr)
library(reshape2)
library(readr)
library(RJSONIO)
library(d3heatmap)

LoadTransitData <- function() {
  timemat <-
    read.csv("timematrix.csv", header = TRUE, stringsAsFactors = FALSE)
  stationnames <- timemat$Station
  
  m3 <- data.matrix(timemat[,-1])
  dimnames(m3)[[1]] <- stationnames
  dimnames(m3)[[2]] <- stationnames
  
  timeHeat <-
    d3heatmap(
      m3, symm = TRUE, Rowv = NULL, Colv = NULL, labRow = stationnames, labCol = stationnames
    )
  htmlwidgets::saveWidget(timeHeat, "timeheat.html", selfcontained = FALSE)
  return(list(m3 = m3, timeHeat = timeHeat))
}


LoadZones <- function() {
  mz <-
    read.csv("zone_mat3.csv", header = FALSE, stringsAsFactors = FALSE)
  mz[mz == 0] <- NA
  
  
  mz <- data.matrix(mz)
  dimnames(mz)[[1]] <- stationnames
  dimnames(mz)[[2]] <- stationnames
  
  #timeHeat <- d3heatmap(mz, symm = TRUE, Rowv = NULL, Colv = NULL, labRow = stationnames, labCol = stationnames, na.rm = TRUE)
  #htmlwidgets::saveWidget(timeHeat, "zoneheat.html", selfcontained = FALSE)
  
  ############
  pkm <- 0.1955
  
  mzp <- mz
  mzp[mzp == 1] <- 2.75
  mzp[mzp == 2] <- 4.00
  mzp[mzp == 3] <- 5.50
  
  mdp <- md
  mdp <- round(mdp * pricekm,2)
  
  mw <- mdp - mzp
  
  
  pricediffheat <-
    d3heatmap(
      mw, symm = TRUE, Rowv = NULL, Colv = NULL, labRow = stationnames, labCol = stationnames, na.rm = TRUE
    )
  htmlwidgets::saveWidget(pricediffheat, "pricediffheat.html", selfcontained = FALSE)
  return(mw)
}
