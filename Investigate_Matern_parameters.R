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
# M(s, u) = sigma2 * (1/con) * (kappa * abs(u - s))^nu * besselK_nu(kappa * abs(u-s)) 

# Args:
    # d: distance between pair of points, must be non-neg
    # sigma2: univariate (marginal) variance
    # nu: smooth parameter, small scale
    # Kappa: range parameter, large scale


Fn_Matern <- function(d, sigma2, nu, Kappa) {
  
  #if(any(d) < 0) {stop("distance d must be non-negative!")}
  
  D <- d / Kappa
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
Kappa <- 2


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

grids$z_vals <- Fn_Matern(d = d, sigma2 = sigma2, nu = nu, Kappa = Kappa)


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

par(mar = c(3, 1, 1, 2))
persp3D(x = x_vals, y = y_vals, z = z_mat)


#-----------------
# parameter tuning
#-----------------

x_vals <- seq(-10, 10, length.out = 100)
y_vals <- seq(-10, 10, length.out = 100)
grids <- expand.grid(x = x_vals, y = y_vals)
d <- sqrt(grids$x^2 + grids$y^2)


plt_3D_Matern <- function(nu, Kappa) {
  
  grids$z <- Fn_Matern(d = d, sigma2 = sigma2, nu = nu, Kappa = Kappa)
  
  # Create matrix of x, y, z for surface3D
  x_mat <- matrix(grids$x, nrow = length(x_vals), ncol = length(y_vals))
  y_mat <- matrix(grids$y, nrow = length(y_vals), ncol = length(y_vals))
  z_mat <- matrix(grids$z, nrow = length(x_vals), ncol = length(y_vals))
  
  
  # 3D surface plot
  persp3D(x = x_vals, y = y_vals, z = z_mat,
          main = paste0("nu = ", nu, ", Kappa = ", Kappa), 
          cex = 0.3)
  
  
}

par(mar = c(2, 1, 2, 2), mfrow = c(3, 4))

for (nu in c(0.5, 1.5, 2.5)) {
  for (Kappa in c(0.5, 5, 20, 75)) {
    plt_3D_Matern(nu = nu, Kappa = Kappa)
  }
}


#------------
# conclusions
#------------

# for a given Kappa, the larger the nu, 
  # the more accurate the z values
  # from 0.9 to 0.9998

# for a given nu, the larger the Kappa
  # the slower the correlation between points decays
  # when kappa = 0.5, the correlation drops to 0 instantly
      # as the increase of distance between two points

  # when Kappa = 75, the correlation decreases very slowely
      # as the increase of distance btw pairs of points












