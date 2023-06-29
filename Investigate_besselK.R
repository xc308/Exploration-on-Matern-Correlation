#====================
# Investigate besselK
#====================
# modified Bessel function of the 3rd kind
# Arg:
    # x: numeric, >= 0 
    # nu: order of the Bessel, >=0 in practice, but can be negative in theory

rm(list = ls())

x <- seq(0.5, 10, length.out = 100)
plt_besselK <- function(x, nu) {

  b <- besselK(x, nu = nu)
  plot(x, b, type = "l", main = bquote(atop("Modified Bessel K_nu", 
                                            "nu:"~ .(nu))))
}


#----
# plot
#----
nu = 1.5
b <- besselK(x, nu = nu)
par(mfrow = c(1, 1), mar = c(3, 3, 3, 1))
plt_besselK(x = x, nu = nu)


plot(x, b, type = "l", main = paste0("nu: ", nu))


#--------------
# Conclusion 1:
#--------------

# Modified Bessel function of the 3rd kind is a decreasing function
# In K_v(d / rho), where rho is the large scale range parameter
  # the larger the rho, the larger the K_v, hence the spatial correlation
      # and the slower such correlation decays as spatial distance increases
      # and at small spatial scale, the correlation is less variable, 
        # the surface is smooth

  # the smaller the rho, the smaller the K_v, hence the smaller the spatial correlation
      # the more speedy such correlation decays as distance increases
      # and at small spatial scale, the correlation is very variable
        # the surface is relatively rough


#-------------
# different nu 
#-------------
N <- seq(0.5, 10, by = 0.5)
length(N) # [1] 20

par(mfrow = c(5, 4), mar = c(2, 1, 2.8, 1))

for (nu in N) {
  plt_besselK(x, nu)
}



#--------------
# Conclusion 2:
#--------------

# The larger the order nu
# the more speedy the BesselK decreases to zero. 








