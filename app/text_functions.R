# get functions ----
source("app/prediction_functions.R")

# Test the functions ----
test_text <- "I want to go"
z <- predict_next_word(test_text); z
get_word(test_text)
get_word3(test_text)

# Assess accuracy ----

# ** Create the test data ----
# tokenize test data
test.tokens <- tokens(test_corp)

# create the test data
test.text <- c()
test.correct.prediction <- c()
for (test_id in 1:length(test.tokens)){
    
    # figure out how many words in text
    num_words <- length(test.tokens[[test_id]]) - 1 # minus 1 so that there is always at least one word to predict
    if(num_words <= 1) next
    cutoff <- as.integer(runif(1, 1, num_words))
    
    temp.search <- paste(test.tokens[[test_id]][1:cutoff], collapse = " ")
    temp.prediction <- test.tokens[[test_id]][cutoff+1]
    
    # print(temp.search); print(temp.prediction)
    
    test.text <- append(test.text, temp.search)
    test.correct.prediction <- append(test.correct.prediction, temp.prediction)
}

# ** predict on test data ----
# Select how many tests you want to run
num_tests <- 1000

# create a dataframe to hold the results
test_result_df <- data.frame(test.text[1:num_tests], test.correct.prediction[1:num_tests]);
names(test_result_df) <- c("test.text", "test.correct.prediciton")
rownames(test_result_df) <- 1:num_tests

# run the predction
# prediction.result <- sapply(test.text[1:num_tests], get_word)
# test_result_df <- cbind(test_result_df, prediction.result)

prediction.result.3 <- sapply(test.text[1:num_tests], get_word3)

# get_predictions
# return: a character vecotr conainting prediction(n) for each string
#   x: prediction results, which is a list containing the input string, and the top 3 predictions
#   num: the prediction number you want to return, must be 1:3
get_predictions <- function(x, num){
    iteratations <- length(x)
    predictions <- c()
    for(i in 1:iteratations){
        predictions <- append(predictions, x[[i]][num])
        x[[i]][1]
    }
    return(predictions)
}

xx <- get_predictions(x = prediction.result.3, 1)

prediction.result1 <- get_predictions(x = prediction.result.3, 1)
prediction.result2 <- get_predictions(x = prediction.result.3, 2)
prediction.result3 <- get_predictions(x = prediction.result.3, 3)
test_result_df <- cbind(test_result_df, prediction.result1, prediction.result2, prediction.result3)

# determine if any of the predictions were correct
test_result_df <- test_result_df %>%
    # must convert from factors to characters for comparison operators to work
    mutate(correct1 = as.character(prediction.result1) == as.character(test.correct.prediciton),
           correct2 = as.character(prediction.result2) == as.character(test.correct.prediciton),
           correct3 = as.character(prediction.result3) == as.character(test.correct.prediciton)) %>%
    
    # assess if 1 of 3 predictions was correct
    mutate(correct = replace_na((correct1 + correct2 + correct3) > 0, FALSE))



# summarise the results
num_correct <- sum(test_result_df$correct)
num_obs <- nrow(test_result_df)
num.no.predict <- sum(test_result_df$prediction.result1 == "New word, no prediction", na.rm = TRUE)

print(paste0("Correct predictions: ", num_correct))
print(paste0("Total predictions: ", num_obs))
print(paste0("Accuracy rate: ", num_correct/num_obs))
print(paste0("Number of no predictions: ", num.no.predict))
print(paste0("Number of no predictions %: ", num.no.predict/num_obs))

test_result_df