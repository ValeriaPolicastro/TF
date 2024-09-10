#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  output$plot1 = renderPlot({
    req(atac_dismatrix)
    plot(hclust(atac_dismatrix,method='complete'))
  })
}
