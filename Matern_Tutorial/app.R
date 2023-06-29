#===============
# Shiny App 
#==============

# Tuning the parameters in Matern function 
  # and visualize the corresponding effects.

library(shiny)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Understanding Parameters Effects in Matérn Function"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(position = "right",
                  sidebarPanel(
                    sliderInput("nu",
                        "Small-scale smoothing parameter nu:",
                        min = 0.1,
                        max = 50, 
                        value = 1.5), 
                    sliderInput(inputId = "rho",
                                label = "Large-scale range parameter rho:",
                                min = 0.1,
                                max = 100, 
                                value = 1)),
                  

        # Show a plot of the generated distribution
                mainPanel(
                  
                  h3("nu: small-scale smoothing parameter", align = "center"),
                  h3("rho: large-scale range parameter", align = "center"),
                  
                  plotOutput("distPlot"),
                  
                  h4("Hint 1: set nu = 0.1, change rho, see what happens?", align = "center"),
                  h4("Hint 2: set rho = 0.1, change nu, see what happens?", align = "center"),
                  h4("Hint 3: set nu = rho = 0.1, see what happens?", align = "center"),
                  h4("Hint 4: set nu = 50, rho = 100, see what happens?", align = "center")
                  
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
      
      # Matern function
      Fn_Matern <- function(d, sigma2, nu, rho) {
        
        #if(any(d) < 0) {stop("distance d must be non-negative!")}
        
        D <- d / rho
        # avoid sending exact zero to BasselK(.)
        D[D == 0] <- 1e-10
        
        con <- 2^(nu - 1) * gamma(nu)
        con <- 1/con
        
        return(sigma2 * con * D^nu * besselK(D, nu))
      }
      
      
      # Create grids   
      x_vals <- seq(-10, 10, length.out = 100)
      y_vals <- seq(-10, 10, length.out = 100)
      grids <- expand.grid(x = x_vals, y = y_vals)
      
      
      # Euclidean distance between pairs of points on the grids
      d <- sqrt(grids$x^2 + grids$y^2)
      
      # Calculate z at each grid
      grids$z <- Fn_Matern(d = d, sigma2 = 1, nu = input$nu, rho = input$rho)
      
      # Create matrix of x, y, z for plot3D
      x_mat <- matrix(grids$x, nrow = length(x_vals), ncol = length(y_vals))
      y_mat <- matrix(grids$y, nrow = length(y_vals), ncol = length(y_vals))
      z_mat <- matrix(grids$z, nrow = length(x_vals), ncol = length(y_vals))
      
      
      # 3D surface plot
      require(plot3D)
      persp3D(x = x_vals, y = y_vals, z = z_mat,
              main = paste0("nu = ", input$nu, ", rho = ", input$rho))
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
