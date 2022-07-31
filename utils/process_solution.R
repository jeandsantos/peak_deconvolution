# Load/install required package(s)
if (!require(dplyr)==TRUE) {install.packages("dplyr"); require(dplyr, quietly = TRUE)} else {require(dplyr, quietly = TRUE)}
if (!require(tibble)==TRUE) {install.packages("tibble"); require(tibble, quietly = TRUE)} else {require(tibble, quietly = TRUE)}

process_solution <- function(sol_vec, x_vals, names_vec=NULL){
  
  if (is.null(names_vec)) {
    sol_names <- names(sol_vec)
  } else {
    sol_names <- names_vec
  } 
  
  rel_area <- sol_vec[grep("^rel_area", x = sol_names)]
  non_zero_peaks <- rel_area != 0
  rel_area <- rel_area[non_zero_peaks]
  
  std_dev <- sol_vec[grep("^std_dev", x = sol_names)][non_zero_peaks]
  peak <- sol_vec[grep("^peak", x = sol_names)][non_zero_peaks]
  
  n_peaks<- length(rel_area)
  
  vec_list <- list()
  x_list <- list()
  elems_matrix <- matrix(rep(NA,n_peaks*length(x_vals)), ncol = n_peaks)
  
  for (i in 1:n_peaks){
    
    vec <- rel_area[i]*dnorm(x_vals, peak[i], std_dev[i])
    vec_list[[i]] <- vec
    x_list[[i]] <- x_vals
    elems_matrix[,i] <- vec
    
  }
  
  solution_df <- tibble::tibble(peak, rel_area, std_dev, curve = vec_list, x_vals = x_list) %>% 
    dplyr::arrange(peak) %>% 
    dplyr::mutate(ID = paste0("Peak ",1:n_peaks), 
                  perc_total_area = (rel_area/sum(rel_area, na.rm = TRUE))*100) %>% 
    dplyr::select(ID, peak, everything())
  
  return(solution_df)
}
