#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @import shinyWidgets
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    dashboardPage(
      dashboardHeader(title = span(
        tagList(tags$img(src = "www/logo_array.png", width = "32px",style="margin-right: 4px;"), "TF300")),
        tags$li(class = "dropdown", actionBttn("jumptohome", icon = icon("house"), style = "stretch", size = "lg"))),

      dashboardSidebar(
        # sidebarUserPanel(name = textOutput("nome"),
        #                  subtitle = actionButton('change','Change', style='padding:0px; height:18px; font-size:90%'),
        #                  image = "www/userimage.png"
        # ),

        sidebarMenu(id = "sidebarmenu",
                    menuItem("Home", tabName = "home", icon = icon("house")),
                    # menuItem("Data Import & Preprocessing", tabName = "rawsub",icon = icon("file-import")),
                    # menuItem("SumExp Visualization", tabName = "seedatatab", icon = icon("table")),
                    menuItem("ATAC", tabName = "atacmenu", icon = icon("chart-bar"),
                             menuSubItem("Plots", tabName = "plotatactab",icon = icon("angle-right")),
                             menuSubItem("Clustering", tabName = "clustatactab",icon = icon("angle-right"))
                    ),
                    menuItem("RNA", tabName = "rnamenu", icon = icon("scale-unbalanced-flip"),
                             menuSubItem("Plots", tabName = "plotrnatab",icon = icon("angle-right")),
                             menuSubItem("Clustering", tabName = "clustrnatab",icon = icon("angle-right"))
                             # menuSubItem("Differential Expression", tabName = "diffexptab",icon = icon("angle-right")),
                             # menuSubItem("Pathway Analysis", tabName = "pathtab",icon = icon("angle-right")),
                             # menuSubItem("Heatmap", tabName = "heattab", icon = icon("angle-right"))
                    )
        )
      ),

      dashboardBody(

        #### Home ####
        tabItems(
          tabItem(
            tabName = "home",
            fluidRow(
              shinydashboard::box(width = 12, status = "primary",
                                  column(3, br(), tags$img(src = "www/advise_logo.png", width = "400px")),
                                  column(7,br(), br(), br(),
                                         HTML("<h1 style = 'text-align: center;font-size: 53px;color: #0e3d51;'>
                     <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Welcome to TF300!</strong>
                     </h1>")),
                     column(2, tags$img(src = "www/logo_array.png", width = "140px"), style = "text-align: right"))
            ),
            br(),
            fluidRow(column(10, offset = 1, wellPanel(
              h3(strong("TF300")," is a novel Shiny app for blablablablabla.",
                 style = "color: #0e3d51;")
            ))),
            br(),
            fluidRow(

            ),
          ),


          tabItem(
            tabName = "plotatactab",
            fluidRow(h4("plot atac")),
            plotOutput('plot1')
            ),

          tabItem(
            tabName = "clustatactab",
            fluidRow(h4("clustering atac"))
            ),

          tabItem(
            tabName = "plotrnatab",
            fluidRow(h4("plot rna"))
            ),

          tabItem(
            tabName = "clustrnatab",
            fluidRow(h4("clust rna"))
            )


        )#end of tabItems



      )#end of dashboardbody
    )
    )

}


#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "TF"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
