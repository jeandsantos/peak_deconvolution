param_names <- function(n_peaks){
  #' Returns vector for names based on the number of peaks
  n_peaks <- as.integer(n_peaks)
  
  params_names <- c(paste0(rep("rel_area",n_peaks),1:n_peaks), paste0(rep("std_dev",n_peaks),1:n_peaks), paste0(rep("peak",n_peaks),1:n_peaks))
  return(params_names)
}
