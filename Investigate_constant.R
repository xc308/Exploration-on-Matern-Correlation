#===============================
# Investigate the constant part
#===============================

# The constant part of Matern: 2^(1-nu) / Gamma(nu)
#d <- seq(0, 10, length.out = 100)

plt_Const <- function(nu) {
  
  Const <- 2^{(1 - nu)} / gamma(nu)
  points(nu, Const)
  
}


#---------
# nu = 0.1
#---------
nu = 0.1
par(mfrow = c(1, 1), mar = c(3, 1, 3, 1))
plt_Const(nu = 0.1)


#-----------------
# different nu's
#-----------------

Nu = seq(0.1, 10, by = 0.1)
length(nu) # 100

Const_vec <- 2^{(1 - Nu)} / gamma(Nu)

par(mfrow = c(1, 1), mar = c(5, 5, 3, 1))
plot(Nu, Const_vec, type = "l", 
     xlab = "nu",
     ylab = "Constant values",
     main = "Constant part v.s. nu")

abline(h = 0, lty = 2)



