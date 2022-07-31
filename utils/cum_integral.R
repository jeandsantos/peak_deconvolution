# Load/install required package(s)
if (!require(pracma)==TRUE) {install.packages("pracma"); require(pracma, quietly = TRUE)} else {require(pracma, quietly = TRUE)}

cum_integral <- function(x, y){
  #' Returns the cumulative integral
  #' Requires the pracma package
  
  out <- pracma::cumtrapz(x, y)
  row.names(out) <- as.character(x)
  return(out)
  
}
