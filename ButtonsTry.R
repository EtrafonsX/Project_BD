library(shiny)
library(shinyjs)

setwd("/Users/lael/Desktop/App-1")

ui <- fluidPage(
  useShinyjs(),  # Initialize shinyjs
  tags$head(
    tags$style(HTML("
      .no-border {
        border: 0 !important;        /* Remove border from actionButton */
        padding: 0 !important;       /* Remove padding */
        background: none !important; /* Remove background */
        box-shadow: none !important; /* Remove box shadow */
        outline: none !important;   /* Remove focus outline */
      }
    "))
  ),
  div(
    id = "HumerusContainer",
    style = "position: absolute; top: 0%; left: 10%; transform: translate(0%, 0%);",
    imageOutput("Humerus", height = 0, width = "100%")  # Adjust width and height as needed
  ),
  div(
    id = "GenContainer",
    style = "position: absolute; top: 0%; left: 10%; transform: translate(0%, 0%);",
    imageOutput("Gen", height = 0, width = "100%")  # Adjust width and height as needed
  ),
  div(
    id = "GenButtonContainer",
    style = "position: absolute; top: 0%; left: 0%; transform: translate(0%, 0%);",
    actionButton("GenButton", imageOutput("GenButtonImg", height = 0, width = "20%"), class = "no-border")  # Adjust width and height as needed
  ),
  div(
    id = "HumerusButtonContainer",
    style = "position: absolute; top: 7%; left: 0%; transform: translate(0%, 0%);",
    actionButton("HumerusButton", imageOutput("HumerusButtonImg", height = -40, width = "20%"), class = "no-border")  # Adjust width and height as needed
  )
)

server <- function(input, output, session) {
  # Set the image paths
  image_path <- "www/Gen.png"
  image_path2 <- "www/Humerus.png"
  image_path3 <- "www/GenButton.png"
  image_path4 <- "www/HumerusButton.png"
  
  # Render the images dynamically
  
  output$Humerus <- renderImage({
    list(src = image_path2, contentType = "image/png", width = "100%")
  }, deleteFile = FALSE)
  
  output$Gen <- renderImage({
    list(src = image_path, contentType = "image/png", width = "100%")
  }, deleteFile = FALSE)
  
  # Render buttons
  output$GenButtonImg <- renderImage({
    list(src = image_path3, contentType = "image/png", width = "100%")
  }, deleteFile = FALSE)
  
  output$HumerusButtonImg <- renderImage({
    list(src = image_path4, contentType = "image/png", width = "100%")
  }, deleteFile = FALSE)
  
  # Use shinyjs to handle click events
  shinyjs::runjs(
    "
    $(document).ready(function(){
      // Initially show Gen image and hide Humerus image
      $('#GenContainer img').show();
      $('#HumerusContainer img').hide();

      $('#HumerusButtonContainer').click(function(){
        $('#HumerusContainer img').show();
        $('#GenContainer img').hide();
      });

      $('#GenButtonContainer').click(function(){
        $('#GenContainer img').show();
        $('#HumerusContainer img').hide();
      });
    });
    "
  )
}

shinyApp(ui = ui, server = server)