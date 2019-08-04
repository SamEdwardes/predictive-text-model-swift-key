# get functions ----
source("app/prediction_functions.R")

# load model ----
if(!exists("train.dfm")){train.dfm <- fread("app/train.dfm.csv")}
if(exists("test.result.df")){rm(test.result.df)}
if(!exists("test.result.df")){test.result.df <- fread("app/test.result.df.csv")}

# Assess accuracy ----

num_predictions <- 100
test.result.df <- test.result.df[1:num_predictions,]

# run the prediction
prediction.result.3 <- sapply(as.character(test.result.df$test.text), get_word3)

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
test.result.df <- cbind(test.result.df, prediction.result1, prediction.result2, prediction.result3)

# determine if any of the predictions were correct
test.result.df <- test.result.df %>%
    # must convert from factors to characters for comparison operators to work
    mutate(correct1 = as.character(prediction.result1) == as.character(test.correct.prediciton),
           correct2 = as.character(prediction.result2) == as.character(test.correct.prediciton),
           correct3 = as.character(prediction.result3) == as.character(test.correct.prediciton)) %>%
    
    # assess if 1 of 3 predictions was correct
    mutate(correct = replace_na((correct1 + correct2 + correct3) > 0, FALSE))



# summarise the results
num_correct <- sum(test.result.df$correct)
num_obs <- nrow(test.result.df)
num.no.predict <- sum(test.result.df$prediction.result1 == "New word, no prediction", na.rm = TRUE)

print(paste0("Correct predictions: ", num_correct))
print(paste0("Total predictions: ", num_obs))
print(paste0("Accuracy rate: ", num_correct/num_obs))
print(paste0("Number of no predictions: ", num.no.predict))
print(paste0("Number of no predictions %: ", num.no.predict/num_obs))

View(test.result.df)