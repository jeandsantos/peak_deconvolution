fit_peak <- function(x_vals, center, sdt_dev, area){ 
  #' Fit Peak
  #' 
  #' Generates the y values of a peak based on its parameters: center, standard deviation and area
  
  return(area*dnorm(x = x_vals, mean = center, sd = sdt_dev)) 
}
