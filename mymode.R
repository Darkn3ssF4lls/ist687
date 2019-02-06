mode <- function(input1){
  uniqueValues <- unique(input1)
  uniqueCounts <- tabulate(match(input1,uniqueValues))
  output <- uniqueValues[which.max(uniqueCounts)]
  return (output)
}
tinyData <- c(1,2,1,2,3,3,3,4,5,4,5)
