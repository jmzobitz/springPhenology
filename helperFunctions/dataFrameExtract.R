### Author: JMZ
### Modified: 4/1/15
### Define a quick function that returns the year, day, and temperature from a given list data


dataFrameExtract <- function(x) {
  dataTimes = strptime(row.names(x),format="A%Y%j");
  rownames(x)=NULL
  year = as.numeric(format(dataTimes, "%Y"))
  day = as.numeric(format(dataTimes, "%j"))
  return(data.frame(year,day,data=x))
}