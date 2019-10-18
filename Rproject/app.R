library(shiny)
library(datasets)
library(ggplot2)
library(tidyverse)

source('global.R')
source('ui.R')
source("server.R")

shinyApp(ui = ui,server = server)