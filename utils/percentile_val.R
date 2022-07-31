percentile_val <- function(x, y, q=0.5){
  #' Returns the value of the vector at a specific percentile (q)
  out <- NA
  idx = percentile_idx(y, q)
  out <- x[idx]
  names(out) <- as.character(q)
  
  return(out)
}
