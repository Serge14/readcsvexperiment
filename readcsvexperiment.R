# Read csv experiment

# one column

library(data.table)
library(tidyverse)
library(readr)
library(microbenchmark)

size = c(10, 50, 100, 500, 1000, 5000, 10000, 50000, 100000, 500000, 1000000)

for (i in size) {
  a = runif(i)
  a = data.frame(a)
  write.csv(a, paste0("data", i, ".csv"), row.names = FALSE)
}

filename = "data1e+06.csv"

benchmark = microbenchmark(
  basicReadCsv = read.csv(filename),
  basicReadTable = read.table(filename, 
                              header = TRUE, sep = ",", quote = "\"", dec = "."),
  readrReadCsv = read_csv(filename, progress = FALSE),
  dtRead = fread(filename),
  times = 50
)

benchmark
boxplot(benchmark)
