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
                                p("The text prediction model analyses text to predict what the next word should be. Type your text in the box below, and the algorithm will predict what word it thinks you wish to type next.")
                            ),
                            mainPanel(
                                h3("Top 3 predictions"),
                                fluidRow(
                                    column(3,
                                           h4("Word 1"),
                                           textOutput("prediction1")),
                                    column(3,
                                           h4("Word 2"),
                                           textOutput("prediction2")),
                                    column(3,
                                           h4("Word 3"),
                                           textOutput("prediction3"))
                                ),
                                hr(),
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
                            includeHTML("app_accuracy.html")
                        )
                    )
                )
           )



