norm_cum_integral <- function(x, y){
  #' Returns the normalized cumulative integral (area under the curve = 1)
  ci_vec <- cum_integral(x, y)
  
  out <- ci_vec/max(ci_vec)
  return(out)
}
