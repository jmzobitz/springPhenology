yearlyCycle <- function(days,data) { 

  # Define the percentiles (2.5%, 50%, 97.5%)
  quantileValues = c(0.025,0.5,0.975)

  # Return the yearly average of EVI data using quantiles.
  yearlyAverage = aggregate(data ~ days, FUN=quantile,probs=quantileValues)

  # returns the yearly average across the different percentiles
  return(yearlyAverage)

}