# Matern_Tutorial

This is a repository for understanding the effects of changing parameters of Matérn function. 

- The Matérn correlation function is commonly used in spatial statistics and Gaussian process modeling to model the covariance or correlation between pairs of points in space.
  
- The function form is :
  C(d) = sigma2 * (1/constant) * (d / rho)^nu K_v (d / rho), where
  - constant: 2^(nu - 1) * gamma(nu)
  - sigma2: marginal variance
  - d: Euclidean distance between pairs of points, non-negative
  - rho: large-scale range parameter, non-negative
  - nu: small-scale smooth parameter, non-negative
  - K_v: Bessel function of the 2nd kind of order nu

  In spatial statics, it's usually reparametrized as:
  C(d) = sigma2 *  (1 / constant) * (kappa * d)^nu K_v (kappa * d), where
  - constant:  2^(nu - 1) * gamma(nu)
  - sigma2: marginal variance
  - d: Euclidean distance between pairs of points, non-negative
  - kappa: 1/rho, spatial decay parameter
  - nu: small-scale smooth parameter
  - K_v: Bessel function of the 2nd kind of order nu

  
- In this tutorial, we set the marginal variance to unit variance 1, and observe the corresponding effects on the Matérn correlation value when changing small-scale parameter nu and large-scale parameter rho.

- Conclusions:
    - for a given nu, the larger the rho, the larger the Matérn correlation, the slower the correlation decreases with the increase of spatial distance and hence a smoother surface at a small spatial scale; the smaller the rho, the smaller the  Matérn correlation, the speedy the correlation decreases with the increase of spatial distance and hence a spiky surface at a small spatial scale.

    - for a given rho, the larger the nu, the larger the Matérn correlation, and the more accurate the Matérn function value is, notice for a given column of below plots, the key values becomes finer as nu gets larger, e.g.from 0.95 to 0.9999 for the last column.
  
  
 
<img width="1580" alt="Screenshot 2023-06-28 at 23 36 50" src="https://github.com/xc308/Matern_Tutorial/assets/55785985/44529a2f-248d-42b6-8c04-b389d4771ca6">










## Shiny app
- There is also a Shiny app to allow readers to tune the nu and kappa and visualize the corresponding changes.
- Shiny app address: https://xiaoqingchen.shinyapps.io/Matern_Tutorial/
(suggest open in a new tab)




## License

This project is licensed under the [Apache License 2.0](LICENSE). The Apache License 2.0 is a permissive open-source license that allows you to use, modify, and distribute this software, provided you include the original license in any copies or modifications.

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


## Citation:  
Chen, Xiaoqing. “XC308/Matern_tutorial.” GitHub, 28 June 2023, github.com/xc308/Matern_Tutorial. 


