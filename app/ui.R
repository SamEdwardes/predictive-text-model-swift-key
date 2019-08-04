# libraries
library(quanteda)
library(readtext)
library(tidyverse)
library(shiny)
library(data.table)


# UI
navbarPage("Text Prediction Model",
           tabPanel("Make predictions",
                    fluidPage(
                        sidebarLayout(
                            sidebarPanel(
                                textInput("prediction.text", "Type here:", value = "This prediction tool is..."),
                                p("The text prediction model analyses text to predict what the next word should be. Type your text in the box below, and the algorithm with predict what word in thinks you wish to type next.")
                            ),
                            mainPanel(
                                h3("Prediction Results"),
                                verbatimTextOutput("prediction.top.3"),
                                h3("Summary of prediction"),
                                verbatimTextOutput("prediction.results.summary")
                            )
                        )
                    )
                ),
           tabPanel("Documentation",
                    fluidPage(
                        mainPanel(
                            includeMarkdown("app_documentation_tab.MD")
                        )
                    )
                ),
           tabPanel("Model Accuracy",
                    fluidPage(
                        mainPanel(
                            #includeMarkdown("app_documentation_tab.MD")
                        )
                    )
                )
           )



