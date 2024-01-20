library(shiny)
library(shinyjs)

setwd("/Users/lael/Desktop/App-1")

ui <- fluidPage(
  useShinyjs(),  # Initialize shinyjs
  div(
    id = "imageContainer",
    style = "position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);",
    imageOutput("SealPNG", height = 0, width = "50%"),  # Adjust width and height as needed
    imageOutput("SealPNG2", height = 0, width = "50%")  # Adjust width and height as needed
  )
)

server <- function(input, output, session) {
  # Set the image paths
  image_path <- "www/SealPNG.png"
  image_path2 <- "www/SealPNG2.png"
  
  # Render the first image dynamically
  output$SealPNG <- renderImage({
    list(src = image_path, contentType = "image/png", width = "100%")
  }, deleteFile = FALSE)
  
  # Render the second image dynamically, initially hidden
  output$SealPNG2 <- renderImage({
    list(src = image_path2, contentType = "image/png", width = "100%")
  }, deleteFile = FALSE)
  
  # Use shinyjs to handle hover events
  shinyjs::runjs(
    "
    $(document).ready(function(){
      $('#imageContainer').hover(
        function(){
          $('#SealPNG2').show();
        },
        function(){
          $('#SealPNG2').hide();
        }
      );
    });
    "
  )
}

shinyApp(ui = ui, server = server)
