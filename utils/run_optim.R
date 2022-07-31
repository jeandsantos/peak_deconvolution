run_optim <- function(x_vals, target, n_peaks = 5, seed=1, loss = loss_n_peak, method = "L-BFGS-B", maxit=5000){
  
  set.seed(seed)
  lower_boundaries <- lower_ranges(x = x_vals, y = target, n_peaks = n_peaks, q_peak = 0.01)
  upper_boundaries <- upper_ranges(x = x_vals, y = target, n_peaks = n_peaks, q_peak = 0.99)
  # init_params <- optim_init_params(x = x_vals, y = target, n_peaks = n_peaks)
  
  initiate_params <- c(runif(n_peaks,0, 1), runif(n_peaks, 5, 100), runif(n_peaks, 5, 1000))
  names(init_params) <- c(paste0(rep("rel_area",n_peaks),1:n_peaks), 
                          paste0(rep("std_dev",n_peaks),1:n_peaks), 
                          paste0(rep("peak",n_peaks),1:n_peaks))
  
  optim_results <- optim(par = init_params,
                         fn = loss_n_peak,
                         target = target,
                         x_vals = x_vals,
                         n_peaks = n_peaks,
                         lower = lower_boundaries,
                         upper = upper_boundaries,
                         method = method,
                         control = list(maxit = maxit)
  )
  
  optim_out <- list(solution = optim_results$par,
                    score = optim_results$value)
  
  return(optim_out)
}
