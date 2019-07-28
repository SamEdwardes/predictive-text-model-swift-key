# break the data into training, testing, and
set.seed(2019-07-24)
pop_size <- length(all_corp$documents$texts)
index <- c(1: pop_size)
train_index <- sample(index, size = 0.8 * pop_size)
train1_index <- sample(train_index, size = 0.8 * length(train_index))
train2_index <- train_index[!(train_index %in% train1_index)]
test_index <- index[!(index %in% train_index)]

train1_index <- as.data.frame(train1_index) %>%
  select(index = train1_index) %>%
  mutate(data.use = "train1")

train2_index <- as.data.frame(train2_index) %>%
  select(index = train1_index) %>%
  mutate(data.use = "train2")

train1_index <- as.data.frame(train1_index) %>%
  select(index = train1_index) %>%
  mutate(data.use = "train1")

# check we still have all data
pop_size - sum(length(train1_index) + length(train2_index) + length(test_index))
