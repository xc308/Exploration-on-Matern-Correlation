#=======================================
# Investigate the inconsistent inference
#=======================================

source("Investigate_Matern_parameters.R")

#--------
# Test conjecture: 
#     if product of nu and rho remains the same
#       then the probability measure remains the same
#--------

nu1 = 4; rho1 = 50
nu2 = 50; rho2 = 4

z1 <- Fn_Matern(d = d, sigma2 = sigma2, nu = nu1, rho = rho1)
z2 <- Fn_Matern(d = d, sigma2 = sigma2, nu = nu2, rho = rho2)
all(z1 == z2) # [1] FALSE

max(z1 - z2) #  0.05511117
min(z1 - z2) #[1] 5.826817e-06


#------
# Caliberate zhang's idea: rho_1^{2 nu_1} = rho_2^{2 nu_2}
#------

nu1 = 1/2; rho1 = 2
nu2 = 1; rho2 = sqrt(2)

z1 <- Fn_Matern(d = d, sigma2 = sigma2, nu = nu1, rho = rho1)
z2 <- Fn_Matern(d = d, sigma2 = sigma2, nu = nu2, rho = rho2)

all(z1 == z2)



#~~~~~~~~~
# test zhang's idea and my idea
#~~~~~~~~~
png(paste0(img.path, "inconsistent_inf.png"),
    width = 8, height = 7, units = "in", res = 300)

par(mfrow = c(1, 2), mar = c(3, 1, 1, 3.5))
z1_mat <- matrix(z1, nrow = length(x_vals))
z2_mat <- matrix(z2, nrow = length(x_vals))


persp3D(x = x_vals, y = y_vals, z = z1_mat,
        main = paste0("nu = 4, rho = 50"))

persp3D(x = x_vals, y = y_vals, z = z2_mat,
        main = paste0("nu = 50, rho = 4"))

dev.off()

# zhang's 
max(z1_mat - z2_mat) #  0.009682185
min(z1_mat - z2_mat) #  -0.1273608


# mine's
max(z1 - z2) #  0.05511117
min(z1 - z2) #[1] 5.826817e-06


#------------------------
# Try more nu's and rho's
#------------------------

x <- seq(-10, 10, length.out = 100)
y <- seq(-10, 10, length.out = 100)
grids <- expand.grid(x = x, y = y)

d <- sqrt(grids$x^2 + grids$y^2)

png(paste(img.path, "inconsistent_inf_all_pairs.png"),
    width = 8, height = 7, units = "in", res = 300)

par(mfrow = c(4, 4), mar = c(1, 1, 1.5, 3))

NU <- c(0.1, 0.5, 1.5, 2.5)
RHO <- c(1, 5, 20, 75)
Diff <- matrix(NA, ncol = 2)

for (nu in NU) {
  for (rho in RHO) {
    
    z1 <- Fn_Matern(d = d, sigma2 = sigma2, nu = nu, rho = rho)
    z1_mat <- matrix(z1, nrow = length(x))
    
    nu_rev <- rho
    rho_rev <- nu
    z2 <- Fn_Matern(d = d, sigma2, nu = nu_rev, rho = rho_rev)
    z2_mat <- matrix(z2, nrow = length(x))
    
    
    main_title = as.expression(paste("nu = ", nu, ", rho = ", rho))
    persp3D(x, y, z1_mat, main = main_title )
    
    main_title_rev = as.expression(paste("nu = ", nu_rev, ", rho = ", rho_rev))
    persp3D(x, y, z2_mat, main = main_title_rev)
    
    min <- min(z1 - z2)
    max <- max(z1 - z2)
    mm <- t(c(min, max))
    Diff <- rbind(Diff, mm)
  }
}

dev.off()

Diff[-1, ]
colnames(Diff) <- c("Min Diff", "Max Diff")
Diff <- Diff[-1, ]

mean(Diff[, 2])

max(z1) # 1

Diff <- Diff[-1, ]
rownames(Diff) <- c(t(outer(NU, RHO, function(x, y) paste("(", x, ", ", y, ")", sep = ""))))
colnames(Diff) <- c("Min Diff", "Max Diff")

install.packages("xtable")
library(xtable)
xtable(Diff)
