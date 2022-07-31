# Load/install required package(s)
if (!require(ggplot2)==TRUE) {install.packages("ggplot2"); require(ggplot2, quietly = TRUE)} else {require(ggplot2, quietly = TRUE)}
if (!require(tidyr)==TRUE) {install.packages("tidyr"); require(tidyr, quietly = TRUE)} else {require(tidyr, quietly = TRUE)}

plot_deconvoluted <- function(solution_df, x_vals, y_vals, unnest_cols = c("x_vals", "curve"), alpha=0.5, linewidth=0.5, x_lab="x", y_lab="PDF", col_lab="Peak", title=NULL, subtitle=NULL, ...){
  #' Plot Deconvoluted Peaks
  #'
  #' Plots deconvoluted peaks together with original data
  
  sol_df <- solution_df %>% tidyr::unnest(cols = unnest_cols) 
  y_pred <- rep(0, length(solution_df$curve[[1]]))
  
  for (i in 1:nrow(solution_df)){
    y_pred <- solution_df$curve[[i]] + y_pred
  }
  
  df_transp <- data.frame(x_vals, y_vals, y_pred)
  
  g <- ggplot() +
    # geom_vline(data = sol_df, mapping = aes(xintercept = peak, col=factor(ID)), alpha=0.5) +
    geom_line(data = sol_df, mapping = aes(x=x_vals, y=curve, col=factor(ID)), size=linewidth) + # , fill=factor(ID)
    geom_line(data = df_transp, mapping = aes(x=x_vals, y=y_vals), col="black", alpha=alpha, size=linewidth) +
    geom_line(data = df_transp, mapping = aes(x=x_vals, y=y_pred), col="grey50", alpha=alpha, size=linewidth) +
    labs(x=x_lab, y=y_lab, col=col_lab, title=title, subtitle = subtitle) +
    scale_color_brewer(type = "qual", palette = "Set1") + 
    theme_bw() +
    theme(...)
  
  return(g)
}
