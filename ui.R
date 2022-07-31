# Load Packages
library(shiny)
library(shinythemes)
library(plotly)
library(ggthemes)
library(shinycssloaders)

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(title = "Peak Deconvolution",
             theme = shinythemes::shinytheme("flatly"),
             windowTitle = "Deconvoluter: Peak Deconvolution",
             tabPanel(title = "Analysis",
                      icon = icon("bullseye"),
                      sidebarLayout(
                        sidebarPanel(
                          
                          # Input: Select a file ----
                          fileInput("file1", "Choose CSV File",
                                    multiple = TRUE,
                                    accept = c("text/csv",
                                               "text/comma-separated-values,text/plain",
                                               ".csv")),
                          
                          # Input: Checkbox if file has header ----
                          checkboxInput(inputId = "contains_header",
                                        label = "Files container header",
                                        value = TRUE),
                          
                          # Input: Select separator ----
                          radioButtons(inputId = "sep", 
                                       label = "Separator",
                                       choices = c(Comma = ",",
                                                   Semicolon = ";",
                                                   Tab = "\t"),
                                       selected = ","),
                          
                          # Input: Select quotes ----
                          radioButtons(inputId = "quote", 
                                       label = "Quote",
                                       choices = c(None = "",
                                                   "Double Quote" = '"',
                                                   "Single Quote" = "'"),
                                       selected = '"'),
                          
                          actionButton(
                            inputId = "run_analysis",
                            label = "Run Analysis",
                            width = "250px",
                            icon = icon("bullseye")
                          ), br(), br(),
                          actionButton(
                            inputId = "run_deconvolution",
                            label = "Perform Deconvolution",
                            width = "250px",
                            icon = icon("bullseye")
                          ), br(), br(),
                          
                          br(),
                          
                          width = 3),
                        
                        # Main panel for displaying outputs ----
                        mainPanel(
                          
                          # Output: Data file ----
                          DT::dataTableOutput(outputId = "quantile_tbl", width = "75%"),
                          br(),
                          shiny::plotOutput(outputId = "plot_line", width = "75%"),
                          br(), hr(),
                          DT::dataTableOutput(outputId = "optim_sol_table", width = "75%"),
                          br(),
                          shiny::plotOutput(outputId = "deconv_plot", width = "75%"),
                          br(),
                          width = 9)
                      )
             ),
             tabPanel(
               title = "Instructions",
               icon = icon("align-left"),
               br(),
               ("This application performs peak deconvolution of spectral data"),br(),br(),
               ("You can run an analysis by:  "),br(),
               ("1. Upload a CSV file with the spectral data"),br(),
               ("2. Select whether the uploaded file has header and the type of separator and quotes used"),br(),
               ("3. Click on 'Run Analysis' for a preview of the spectre"),br(),
               ("4. Click on 'Perform Deconvolution' for running the deconvolution."),br(),br(),
               ("The analysis may take a few moments based on the length of the spectre and the potential number of compoenents."),br()
             ),
             tabPanel(
               title = "About",
               icon = icon("info-circle"),
               br(),
               ("For app documentation and code visit the "), 
               a(href = "https://github.com/jeandsantos/peak_deconvolution", "GitHub repository."),
               br(),br(),
               ("For questions or feedback please contact via "), a(href = "https://www.linkedin.com/in/jeandsantos/", "LinkedIn"), 
               (", "), a(href = "https://github.com/jeandsantos/", "GitHub"),
               (" or "), a(href = "mailto:jeandsantos88@gmail.com", "email.")
             ),
             tags$hr(),
             tags$span(style="color:grey", tags$footer(h4(("Made by "),strong(tags$a(href = "https://www.linkedin.com/in/jeandsantos/", target = "_blank", "Jean Dos Santos"))),
                                                       align = "center"))
  )
)

