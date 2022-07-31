# Load/install required package(s)
if (!require(pracma)==TRUE) {install.packages("pracma"); require(pracma, quietly = TRUE)} else {require(pracma, quietly = TRUE)}

plot_dist_cta <- function(x_vals, y_val){
  
  cum_tot_area <- pracma::cumtrapz(x_vals, y_val)
  norm_cum_tot_area <- cum_tot_area/max(cum_tot_area)
  
  plot(x_vals, y_val, col="blue", type="l", ylab="PDF")
  axis(2, ylim=c(0,max(y_val)), col="blue")
  
  par(new=T)
  plot(x_vals, norm_cum_tot_area, type="l", col="red", axes=F, ylab="", lty=2)
  axis(4, ylim=c(0,max(norm_cum_tot_area)), col="red")
  
}
