# Load/install required package(s)
if (!require(pracma)==TRUE) {install.packages("pracma"); require(pracma, quietly = TRUE)} else {require(pracma, quietly = TRUE)}

optim_init_params <- function(x, y, n_peaks, rel_area="auto", std_dev="auto", peak="auto", vec_names=param_names, q_min=0.01, q_max=0.99, verbose=FALSE){
  #' Initial Parameters
  #' 
  #' Defines the initial parameters for the optimization algorithm for values of peak relative area, peak standard deviation and peak center
  
  vec_norm_cum_int <- norm_cum_integral(x, y)
  x_quantiles <- percentile_summary(x, vec_norm_cum_int)
  
  # Define values for peak centers
  if (peak=="auto"){
    
    x_min <- x_quantiles[as.character(q_min)]
    x_max <- x_quantiles[as.character(q_max)]
    
    if (any(is.na(c(x_min, x_max)))){
      x_min <- min(x, na.rm = TRUE)
      x_max <- max(x, na.rm = TRUE)
    }
    
    dist <- (x_max - x_min)/n_peaks
    vec_peak <- seq(x_min, x_max, length.out = n_peaks)
    
  } else {
    vec_peak <- peaks
  }
  
  # Define values for relative area
  if (rel_area=="auto"){
    tot_area <- pracma::trapz(x, y)
    vec_rel_area <- rep(tot_area/n_peaks, n_peaks)
  } else {
    vec_rel_area <- rep(as.numeric(rel_area), n_peaks)
  }
  
  # Define values for standard deviation    
  if (std_dev=="auto"){
    vec_std_dev <- rep(dist, n_peaks)  
  } else {
    vec_std_dev <- rep(as.numeric(std_dev), n_peaks)
  }
  
  out <- c(vec_rel_area, vec_std_dev, vec_peak)
  names(out) <- vec_names(n_peaks)
  
  return(out)
  if (verbose){ print(out) }
  
}
