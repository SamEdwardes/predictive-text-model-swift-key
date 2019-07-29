# libraries
library(quanteda)
library(readtext)
library(tidyverse)
library(shiny)

# UI

navbarPage("Text Prediction Model",
           tabPanel("Make predictions",
                    fluidPage(
                        sidebarLayout(
                            sidebarPanel(
                                h3("Enter your text"),
                                textInput("prediction.text", "enter your text here")
                            ),
                            mainPanel(
                                h3("Prediction Results"),
                                p("The results will go here")
                            )
                        )
                    )
                ),
           tabPanel("Documentation",
                    fluidPage(
                        mainPanel(
                            includeMarkdown("documentation/app_documentation_tab.MD")
                        )
                        
                    )
                    
                ),
           tabPanel("GitHub README",
                    fluidPage(
                        mainPanel(
                            includeMarkdown("README.MD")
                        )
                        
                    )
                )
           )



