#=========================
# Investigate (d/rho)^nu
#=========================

# Reason: 
  # Matern function is a product of 3 parts:
    # sigma2 * constant
    # (d / rho)^nu
    # K_v(d / rho) : done.

d <- seq(0, 10, length.out = 100)

plot_Middle <- function(rho, nu) {
  m <- (d / rho)^nu
  plot(d, m, type = "l", main = paste0("rho: ", rho, "; nu:", nu),
       cex = 0.5)
}


#----------------------------
# Plot for fixed rho and nu
#----------------------------
rho = 2
nu = 3/2

par(mfrow = c(1, 1), mar = c(3, 3, 3, 1))
plot_Middle(rho = rho, nu = nu)


#----------------------
# different rho and nu
#----------------------
Rho <- seq(0.5, 50, by = 10) # 0.5 10.5 20.5 30.5 40.5
Nu <- c(0.5, 1.5, 10, 50) 
length(Rho) # [1] 5
length(Nu) # [1] 4

par(mfrow = c(5, 4), mar = c(2.5, 1, 2, 1))

for (rho in Rho) {
  for (nu in Nu) {
    
    plot_Middle(rho = rho, nu = nu)
  }
}

#-----------
# Conclusions
#-----------

# large scale range parameter rho does not have significant effect
  # on the values of the middel part

# when nu is small, the middel part is approximately linear
# when nu is large, the middel part becomes exponentially increase



# Q: when is the nu value that will drive a 
  # significant change to the shape of the middel part
  # from approximate linear to exponentially increase?



#----------------------
# what nu value will change the middle part value from linear to expoential?
#----------------------
Rho <- seq(0.5, 50, by = 10) # 0.5 10.5 20.5 30.5 40.5
Nu <- seq(0.5, 10, by = 0.5) 
length(Rho) # [1] 5
length(Nu) # [1] 19

par(mfrow = c(5, 4), mar = c(2, 1, 2, 1))

rho = 10
for (nu in Nu) {
  plot_Middle(rho = rho, nu = nu)
  abline(a = 0, b = 0.1, lty = 2, lwd = 0.5)
  
  }


#----------
# Conclusion
#----------

# when nu in c(0.5, 1.5), the middle part curve
  # approximates a linear line y = 0.1x


#-----------------------------------------
# Q: is c(0.5, 1.5) the ideal range for nu?
#-----------------------------------------

Nu <- seq(0.1, 2, by = 0.1) 
length(Nu) # [1] 20

par(mfrow = c(5, 4), mar = c(2, 1, 2, 1))

plot_Middle_mse <- function(rho, nu) {
  d <- seq(0, 10, length.out = 100)
  
  M_vals <- (d / rho)^nu
  L_vals <- 0.1 * d
  MSE <- sum((M_vals - L_vals)^2) / length(d)
  
  plot(d, M_vals, type = "l", 
       main = bquote(atop("nu:"~ .(nu),
                          atop("MSE:" ~ .(round(MSE, 2))))),
       cex = 0.5)
  abline(a = 0, b = 0.1, lty = 2, lwd = 0.5)
}


par(mfrow = c(4, 5), mar = c(2.3, 1, 3.5, 1))
for (nu in Nu) {
  plot_Middle_mse(rho = 10, nu = nu)
}


#-----------
# Conclusion
#-----------

# When nu is with (0.7, 1.5), MSE is <= 0.1
# the middle part is approximately to a linear line
  # of y = 0.1 x













rho = 10
nu = 0.1
d <- seq(0, 10, length.out = 100)
0.1 * d

M_vals <- (d / rho)^nu
L_vals <- 0.1 * d
sum((M_vals - L_vals)^2) / length(d)

par(mfrow = c(1, 1), mar = c(3, 3, 5, 1))
plot_Middle_mse(rho = 10, nu = 0.2)
