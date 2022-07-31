loss_n_peak <- function(y_pred_params, x_target, y_target, n_peaks, verbosity=0){
  #' Loss function for n peak optimization
  #'
  #' Returns the sum of squared error between the target curve and sum of the deconvoluted peaks
  
  elems_matrix <- matrix(data = rep(0, n_peaks*length(y_target)), ncol = n_peaks)
  
  for (i in 1:n_peaks){
    elems_matrix[,i] <- fit_peak(x_vals = x_target, center=y_pred_params[(2*n_peaks)+i], sdt_dev=y_pred_params[n_peaks+i], area =y_pred_params[i])
    if (verbosity>=2){
      print(paste0("Peak ",i, " - area: ", round(y_pred_params[i],4)," | ", "std dev: ", round(y_pred_params[n_peaks+i],2)," | ", "center: ", round(y_pred_params[(2*n_peaks)+i],2))) 
    }
  }
  
  elems_total <- apply(elems_matrix, MARGIN = 1, sum, na.rm=FALSE)
  err <- sum((y_target - elems_total)^2)
  if (verbosity>=1){ print(paste("SSE:",round(err, 10))) }
  return( err )
  
}
