summary_table <- function(df, in_digits=2){
  
  df %>% 
    dplyr::mutate(
      peak = round(peak, in_digits),
      std_dev = round(std_dev, in_digits),
      perc_total_area = round(perc_total_area, in_digits)
    ) %>% 
    dplyr::select(ID, 
                  `Peak` = peak,
                  `Standard Deviation` = std_dev,
                  `% Total Area` = perc_total_area) 
}