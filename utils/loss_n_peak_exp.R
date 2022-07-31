loss_n_peak_exp <- function(y_pred_params, x_target, y_target, n_peaks, verbosity=0){
  #' Loss function for n peak optimization
  #'
  #' Returns the sum of squared error between the target curve and sum of the deconvoluted peaks
  #' Adds a penalty to solutions whose total area is higher than the target total area
  
  tot_area_y_target <- pracma::trapz(x_target, y_target)
  elems_matrix <- matrix(data = rep(NA, n_peaks*length(y_target)), ncol = n_peaks)
  
  for (i in 1:n_peaks){
    elems_matrix[,i] <- fit_peak(x_vals = x_target, center=y_pred_params[(2*n_peaks)+i], sdt_dev=y_pred_params[n_peaks+i], area =y_pred_params[i])
    if (verbosity){
      print(paste0("Peak ",i, " - area: ", round(y_pred_params[i],4)," | ", "std dev: ", round(y_pred_params[n_peaks+i],2)," | ", "center: ", round(y_pred_params[(2*n_peaks)+i],2))) 
    }
  }  
  
  elems_total <- apply(elems_matrix, MARGIN = 1, sum, na.rm=FALSE)
  tot_area_vec <- pracma::trapz(x_target, elems_total)
  
  err <- sum((y_target - elems_total)^2)
  
  if (tot_area_vec > tot_area_y_target){ 
    return( err + 10^(tot_area_vec/tot_area_y_target) ) 
  } else { return(err) }
}
