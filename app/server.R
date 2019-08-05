# load the model
load("data/train.dfm.rda")

function(input, output) {
    
  # get functions ----
  source("prediction_functions.R")
  
  # get prediction text
  prediction.text <- reactive({input$prediction.text})
  
  # predict top 3 words
  top3 <- reactive({get_word3(prediction.text(), train.dfm)})
  
  # summary of prediction
  prediction.summary <- reactive({predict_next_word(prediction.text(), train.dfm)})
      
  # render results ----
  output$prediction.top.3 <- renderPrint(top3())
  output$prediction.results.summary <- renderPrint(prediction.summary())
        
  
}

