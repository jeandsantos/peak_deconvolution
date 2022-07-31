percentile_summary <- function(x, y, q=c(0.001,0.01,0.025,0.05,0.10,0.25,0.50,0.75,0.90,0.95,0.975,0.99,0.999), return_df=FALSE){
  #' Returns the values of at specific percentiles
  y_cum <- norm_cum_integral(x = x, y = y)
  
  out <- rep(NA, length(q))
  
  for (i in 1:length(q)){
    
    out[i] <- percentile_val(x, y_cum, q[i])
    
  }
  
  if (return_df) {
    df <- data.frame(Percentile=100*q, Value=out)
    return(df)
  } else {
    names(out) <- as.character(q)
    return(out)  
  }
  
}
