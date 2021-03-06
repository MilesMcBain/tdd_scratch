
# Install packages

# library(tidyverse)
# install.packages("datapasta")
# library(datapasta)

# Create a sample data for different patient groups
my_df <- data.frame(patient_grp = factor(rep(LETTERS[1:6], each=3)),
                    a = rep(1:2),
                    b = c(11:13, 21:23, 31:33, 41:43, 51:53, 61:63))

# Create a tibble
my_tibb <- my_df %>% 
  as_tibble()

### Return majority for each group

my_tibb %>%
  # add a column n with count by categories
  add_count(patient_grp, a) %>%
  # select max or first occurrence by patient
  group_by(patient_grp) %>%
  # keep only first TRUE
  mutate(majority = a[n == max(n)][1]) %>%
  # do not keep temp var
  select(-n)


### Sort differently based on group membership

## Overall workflow

# 1. Create a sorted column
# 2. Use case_when to selectively use the sorted or the original values.

# The desired vector looks like this
b = c(11:13, 21:23, 33:31, 41:43, 51:53, 61:63)

# i.e. when the patient group is C, the order of column b is reversed
my_tibb

my_tibb %>%
  group_by(patient_grp) %>%
  mutate(b_sorted = sort(b, decreasing = TRUE)) %>%
  mutate(b_desired = case_when(patient_grp == "C" ~ b_sorted,
                              TRUE ~ b))

# You can then remove any columns you don't want to keep
  


