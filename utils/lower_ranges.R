lower_ranges <- function(x, y, n_peaks, rel_area=0, std_dev=10, peak="auto", q_peak=0.01, vec_names=param_names){
  #' Lower Ranges
  #' 
  #' Defines the lower boundaries of the optimization algorithm for values of peak relative area, peak standard deviation and peak center (mean)
  
  vec_rel_area <- rep(rel_area, n_peaks)
  vec_std_dev <- rep(std_dev, n_peaks)  
  
  if (peak=="auto"){
    vec_norm_cum_int <- norm_cum_integral(x, y)
    x_quantiles <- percentile_summary(x, vec_norm_cum_int)
    vec_peak <- rep(x_quantiles[as.character(q_peak)], n_peaks)
    if (any(is.na(vec_peak))) { vec_peak <- rep(min(x_quantiles), n_peaks) }
  } else {
    vec_peak <- rep(as.numeric(peak), n_peaks)
  }
  
  out <- c(vec_rel_area, vec_std_dev, vec_peak)
  names(out) <- vec_names(n_peaks)
  
  return(out)
}
