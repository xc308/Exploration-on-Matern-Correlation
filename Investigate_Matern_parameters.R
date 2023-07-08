#=============================================
# Investigate the parameter effects of Matern
#=============================================

# 3D visualize effects of changing parameters of Matern function

install.packages("ggplot2")
library(ggplot2)

install.packages("patchwork")
library(patchwork) # for side by side plots

install.packages("plot3D")
library(plot3D)


#-----------------
# Function formula
#-----------------

# con = 2^(nu - 1) * gamma(nu)
# M(s, u) = sigma2 * (1/con) * (abs(u - s) / rho)^nu * besselK_nu(abs(u-s) / rho) 

# Args:
    # d: distance between pair of points, must be non-neg
    # sigma2: univariate (marginal) variance
    # nu: smooth parameter, small scale
    # rho: range parameter, larger scale
    # Kappa: spatial decay parameter, 1/range parameter


Fn_Matern <- function(d, sigma2, nu, rho) {
  
  #if(any(d) < 0) {stop("distance d must be non-negative!")}
  
  # D <- d / Kappa
  
  # kappa = 1/range
  D <- d /rho
  # avoid sending exact zero to BasselK(.)
  D[D == 0] <- 1e-10
  
  con <- 2^(nu - 1) * gamma(nu)
  con <- 1/con
  
  return(sigma2 * con * D^nu * besselK(D, nu))
}


#------------------------
# set parameters in Mater
#------------------------
sigma2 <- 1
nu <- 1.5
rho <- 2


#---------------------------
# Construct grids of points 
#---------------------------
# Reason: for calculating Matern values
x <- seq(-10, 10, length.out = 100)
y <- seq(-10, 10, length.out = 100)
grids <- expand.grid(x = x, y = y)


#----------------------------------------
# Calculate Matern function values at grids
#----------------------------------------

d <- sqrt(grids$x^2 + grids$y^2)

grids$z_vals <- Fn_Matern(d = d, sigma2 = sigma2, nu = nu, rho = rho)


#--------------------
# Create surface plot
#--------------------

surf_plot <- ggplot(grids, aes(x = x, y = y, z = z_vals)) +
  geom_tile(aes(fill = z_vals, height = 0.5, width = 0.5)) +
  scale_fill_gradient(low = "blue", high = "red") + 
  theme_minimal() +
  labs(title = "Matern Function Surface Plot")
  

contour_plot <- ggplot(grids, aes(x = x, y = y, z = z_vals)) + 
  geom_contour(aes(color = z_vals)) + 
  scale_color_gradient(low = "blue", high = 'red') + 
  theme_minimal() + 
  labs(title = "Matern Function Contour Plot")


surf_plot + contour_plot + plot_layout(ncol = 2)


#---------
# 3D plot
#---------

str(grids$z_vals) # num [1:10000] 
str(x) # num [1:100]

# Create matrices for coordinates and z values 
  # (surf3D require matrix input)
x_mat <- matrix(grids$x, nrow = length(x), ncol = length(y))
y_mat <- matrix(grids$y, nrow = length(x), ncol = length(y))
z_mat <- matrix(grids$z_vals, nrow = length(x), ncol = length(y))


surf3D(x = x_mat, y = y_mat, z = z_mat, 
       alpha = 0.8, specular = "white",
       front = "lines", back = "lines", main = "Matérn Function 3D Plot",
       xlab = "X", ylab = "Y", zlab = "Z",
       theta = 60)


#--------------
# perspective 3D
#--------------
x_vals <- seq(-10, 10, length.out = 100)
y_vals <- seq(-10, 10, length.out = 100)

par(mfrow = c(1, 1), mar = c(3, 1, 1, 2))
persp3D(x = x_vals, y = y_vals, z = z_mat)


#-----------------
# parameter tuning
#-----------------

x_vals <- seq(-10, 10, length.out = 100)
y_vals <- seq(-10, 10, length.out = 100)
grids <- expand.grid(x = x_vals, y = y_vals)
d <- sqrt(grids$x^2 + grids$y^2)


plt_3D_Matern <- function(nu, rho) {
  
  grids$z <- Fn_Matern(d = d, sigma2 = sigma2, nu = nu, rho = rho)
  
  # Create matrix of x, y, z for surface3D
  x_mat <- matrix(grids$x, nrow = length(x_vals), ncol = length(y_vals))
  y_mat <- matrix(grids$y, nrow = length(y_vals), ncol = length(y_vals))
  z_mat <- matrix(grids$z, nrow = length(x_vals), ncol = length(y_vals))
  
  
  # 3D surface plot
  persp3D(x = x_vals, y = y_vals, z = z_mat,
          main = paste0("nu = ", nu, ", rho = ", rho), 
          cex = 0.3)
}


png(paste0(image.path, "Matern_nu_rho_2.png"), 
    width = 12, height = 7, units = "in", res = 300)

par(mar = c(1, 1, 1, 3), mfrow = c(4, 5))

for (nu in c(0.1, 0.5, 1.5, 2.5)) {
  for (rho in c(0.1, 0.5, 5, 20, 75)) {
    plt_3D_Matern(nu = nu, rho = rho)
  }
}

dev.off()

#------------
# conclusions
#------------

# for a given rho, the larger the nu, 
  # the more accurate the z values
  # from 0.9 to 0.9998

# for a given nu, the larger the rho
  # the slower the correlation between points decays
  # when rho = 0.5, the correlation drops to 0 instantly
      # as the increase of distance between two points

  # when rho = 75, the correlation decreases very slowely
      # as the increase of distance btw pairs of points












