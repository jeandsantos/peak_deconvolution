percentile_idx <- function(x, q=0.5) {
  #' Returns the index of the value below or equal to a percentile (q)
  out <- max(which(x <=q))
  names(out) <- as.character(q)
  return(out)
}