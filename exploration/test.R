predict_next_word <- function(input_text){
  
  # process the input text
  input_toks <- tokens(input_text)
  input_toks <- process_tokens(input_toks)
  
  # determine the range of ngrams to search
  num_toks <- length(input_toks[[1]])
  ngram_range <- min(3, num_toks):1
  
  # loop through each range of ngrams to find matches
  potential_matches <- data.frame()
  for (num in ngram_range){
    
    # create the ngrams
    search_ngrams <- tokens_ngrams(input_toks, num)
    # create the search phrase
    search_term <- paste0("^", tail(search_ngrams[[1]], 1), "_")
    # identify the in scope search area
    search.dfm <- train.dfm %>% filter (ngrams >= num + 1)
    # search the dataframe
    temp <- search.dfm[grepl(pattern = search_term, x = search.dfm$feature), ]
    if(nrow(temp) == 0) next
    temp$ngram.size <- num
    # calculate frequncy and score
    total_ngrams <- sum(temp$frequency)
    temp <- temp %>%
      mutate(frequency.percent = frequency / total_ngrams) %>%
      mutate(score = num + frequency.percent)
    # join the results together
    potential_matches <- union_all(temp, potential_matches)
  }
  
  # check to see if there are matches
  if(nrow(potential_matches) == 0) {
    return(list("input_text" = input_text,
                "input_toks" = input_toks,
                "potential_matches" = NULL
    ))
  }
  
  # arrange the potential matches to find the most likely
  potential_matches <- potential_matches %>%
    arrange(desc(score), desc(frequency.percent)) %>% 
    head(1000)
  
  # get the best predicted next word
  potential_matches$split_location <- stringi::stri_locate_last(str = potential_matches$feature, regex = "_")[,2]
  potential_matches <- potential_matches %>%
    mutate(prediction = substr(feature, split_location + 1, nchar(feature))) %>%
    select(feature, prediction, score, frequency.percent, ngram.size, ngrams, frequency)
  
  
  # return results
  return(list("input_text" = input_text,
              "input_toks" = input_toks,
              "potential_matches" = potential_matches
  ))
}

# Only return the top word
get_word <- function(x){
  
  y <- predict_next_word(x)
  y$potential_matches[1,2]
}


# TESTING THE FUNCTIONS

z <- test.text[6]
z
sapply(z, get_word)