run_DE <- function(x_vals, target, n_peaks = 3, loss = loss_n_peak_exp, qmin = 0.025, qmax = 0.975, maxit="auto", pop_size=100, p_crossover=0.5, strategy=3, verbosity=0, seed=1){
  
  if (maxit=="auto"){
    maxit <- n_peaks*250
  } else {
    maxit <- as.numeric(maxit)
  }
  
  set.seed(seed)
  lower_boundaries <- lower_ranges(x = x_vals, y = target, n_peaks = n_peaks, q_peak = qmin)
  upper_boundaries <- upper_ranges(x = x_vals, y = target, n_peaks = n_peaks, q_peak = qmax)
  
  optim_results <- DEoptim::DEoptim(fn = loss,
                                    y_target = target, 
                                    x_target = x_vals,
                                    n_peaks = n_peaks,
                                    lower = lower_boundaries,
                                    upper = upper_boundaries,
                                    control = DEoptim.control(NP = pop_size, 
                                                              itermax = maxit, 
                                                              CR = p_crossover, 
                                                              strategy=as.integer(strategy),
                                                              trace = verbosity*100
                                                              )
                                    )
  
  optim_out <- list(solution = optim_results$optim$bestmem,
                    score = optim_results$optim$bestval)
  
  return(optim_out)
}
