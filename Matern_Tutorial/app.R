#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


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
                        min = 0,
                        max = 10, 
                        value = 1.5), 
                    sliderInput(inputId = "kappa",
                                label = "Large-scale range parameter kappa:",
                                min = 0,
                                max = 50, 
                                value = 1)),
                  

        # Show a plot of the generated distribution
                mainPanel(
                  
                  h3("nu: small-scale smoothing parameter", align = "center"),
                  h3("kappa: large-scale range parameter", align = "center"),
                  
                  plotOutput("distPlot"),
                  
                  h4("Hint1: set nu = 1, change kappa, see what happens?", align = "center"),
                  h4("Hint2: set kappa = 1, change nu, see what happens?", align = "center")
                  
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
      
      # Matern function
      Fn_Matern <- function(d, sigma2, nu, Kappa) {
        
        #if(any(d) < 0) {stop("distance d must be non-negative!")}
        
        D <- d / Kappa
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
      grids$z <- Fn_Matern(d = d, sigma2 = 1, nu = input$nu, Kappa = input$kappa)
      
      # Create matrix of x, y, z for plot3D
      x_mat <- matrix(grids$x, nrow = length(x_vals), ncol = length(y_vals))
      y_mat <- matrix(grids$y, nrow = length(y_vals), ncol = length(y_vals))
      z_mat <- matrix(grids$z, nrow = length(x_vals), ncol = length(y_vals))
      
      
      # 3D surface plot
      require(plot3D)
      persp3D(x = x_vals, y = y_vals, z = z_mat,
              main = paste0("nu = ", input$nu, ", kappa = ", input$kappa))
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
