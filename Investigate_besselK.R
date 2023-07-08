#====================
# Investigate besselK
#====================
# modified Bessel function of the 3rd kind
# Arg:
    # x: numeric, >= 0 
    # nu: order of the Bessel, >=0 in practice, but can be negative in theory


#----------
# Settings
#----------
rm(list = ls())

image.path <- "./Image/"


#----------------
# Bessel function
#----------------
x <- seq(0.5, 10, length.out = 100)
plt_besselK <- function(x, nu) {

  b <- besselK(x, nu = nu)
  plot(x, b, type = "l", xlab = "distance",
       main = bquote(atop("Modified Bessel K_nu", 
                          atop("nu:"~ .(nu), "rho: "~ 1))))
}


#----
# plot
#----
nu = 1.5
b <- besselK(x, nu = nu)
par(mfrow = c(1, 1), mar = c(5, 3, 4, 1))
plt_besselK(x = x, nu = nu)
abline(h = 0, lty = 2)


#------
# Save
#------

png(paste0(image.path, "Bessel_nu_1.5.png"), width = 8, height = 7, 
    units = "in", res = 300)

nu = 1.5
b <- besselK(x, nu = nu)
par(mfrow = c(1, 1), mar = c(5, 3, 4, 1), cex = 1.2)
plt_besselK(x = x, nu = nu)
abline(h = 0, lty = 2)

dev.off()



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
#N <- seq(0.5, 10, by = 1)
length(N) # [1] 10

par(mfrow = c(3, 3), mar = c(4, 3, 3, 1), mgp = c(1.75, 1, 0),
    cex = 2)

plt_besselK_2 <- function(x, nu) {
  
  b <- besselK(x, nu = nu)
  plot(x, b, type = "l", xlab = "distance",
       ylab = "Bessel K",
       main = bquote(atop("Modified Bessel K_nu", 
                          atop("nu:"~ .(nu)))))
}

for (nu in N) {
  plt_besselK_2(x, nu)
}


# try N with more constrast but less choices

png(paste0(image.path, "Bessel_different_nu.png"), 
    width = 8, height = 7, units = "in", res = 300)

par(mfrow = c(2, 2), mar = c(3, 3, 3.5, 1), mgp = c(1.85, 1, 0),
    cex = 1.1)

N <- c(0.1, 1.5, 15, 50)
for (nu in N) {
  plt_besselK_2(x, nu)
}

dev.off()


#--------------
# Conclusion 2:
#--------------

# The larger the order nu
# the more speedy the BesselK decreases to zero. 








