### Return most frequent string for each group

# Install packages

library(tidyverse)
# Create sample data
# @Rscotty provided dataset
sample <- tibble::tribble(
  ~Patient_ID, ~Status,
  1L,                  "G",
  1L,                  "G",
  1L,                  "B",
  2L,                  "G",
  2L,                  "B",
  3L,                  "O",
  3L,                  "B",
  3L,                  "G",
  4L,                  "X",
  4L,                  "B"
)

# Workflow to return most frequent string

sample %>%
  # add a column n with count by categories
  add_count(Patient_ID, Status) %>%
  # select max or first occurrence by patient
  group_by(Patient_ID) %>%
  # keep only first TRUE
  mutate(Majority = Status[n == max(n)][1]) %>%
  # do not keep temp var
  select(-n)

### Sort within each group

# 1. Create a sorted column
# 2. Use case_when to selectively use the sorted or the original values.

# Create sample data
library(dplyr)

my.df <- data.frame(aa=factor(c(1:24)), 
                    bb=factor(rep(c(1:6), each=4)),
                    cc=factor(rep(c(1,2), each=4, times=3)),
                    dd=c(11:14, 21:24, 31:34, 41:44, 51:54, 61:64),
                    desired=c(11:14, 24:21, 31:34, 44:41, 51:54, 64:61))
my.df %>%
  group_by(bb) %>%
  mutate(dd_sorted = sort(dd, decreasing = TRUE)) %>%
  mutate(dd_new = case_when(cc == 2 ~ dd_sorted,
                            TRUE ~ dd))
