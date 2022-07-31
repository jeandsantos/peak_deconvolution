library(shiny)
library(rmarkdown)
library(bookdown)
library(tidyverse)
library(pracma)
library(knitr)
library(DEoptim)
library(pracma)

# Import all functions from utils
source(file = "utils/source_dir.R")
source_dir("utils/", trace = FALSE)


report_path <- tempfile(fileext = ".Rmd")
file.copy("report.Rmd", report_path, overwrite = TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    # import data
    df_wh <- eventReactive(eventExpr = input$run_analysis, {
        
        inFile <- input$file1
        
        if (is.null(inFile)) return(NULL)
        
        data <- readr::read_csv(inFile$datapath, col_names = input$contains_header)
        data
    })
    
    observeEvent(eventExpr = input$run_analysis, { 
        
        x_vals <- as.numeric(colnames(df_wh())[-1])
        y_vals <- df_wh()[1, -1] %>% as.matrix() %>% as.vector()
        print(x_vals)
        print(y_vals)
        
        summary_stats <- percentile_summary(x = x_vals, y = y_vals, q = c(0.1, 0.5, 0.90, 0.95, 0.99), return_df = TRUE)
        print(summary_stats)
        
        output$plot_line <- renderPlot(
            
            plot(x = x_vals,
                 y = y_vals,
                 type="l",
                 xlab = "x",
                 ylab = "y",
                 main = "Distribution of values")
        )
        
        output$quantile_tbl <- DT::renderDataTable(
            DT::datatable(summary_stats,
                          rownames = FALSE,
                          extensions = c("Buttons","FixedColumns", "Scroller", "KeyTable"),
                          options = list(
                              pageLength = 15,
                              deferRender = F,
                              dom = "t",
                              autoWidth = TRUE,
                              keys = TRUE)
            )
        )
    })
        
        observeEvent(eventExpr = input$run_deconvolution, {
        
        message(Sys.time(), ": running deconvolution")
            
        x_vals <- as.numeric(colnames(df_wh())[-1])
        y_vals <- df_wh()[1, -1] %>% as.matrix() %>% as.vector()
            
        optim_out <- run_DE(x_vals = x_vals, target = y_vals, n_peaks = 3, maxit = 250)
        optim_df <- process_solution(sol_vec = optim_out$solution, x_vals = x_vals, names_vec = NULL)
        optim_tbl <- summary_table(df = optim_df)
        
        message(Sys.time(), ": deconvolution completed")
        
        output$optim_sol_table <- DT::renderDataTable(
            DT::datatable(optim_tbl,
                          rownames = FALSE,
                          extensions = c("Buttons","FixedColumns", "Scroller", "KeyTable"),
                          options = list(
                              pageLength = 15,
                              deferRender = F,
                              dom = "t",
                              buttons = c("copy", "csv"),
                              autoWidth = TRUE,
                              keys = TRUE)
            )
        )
        
        message(Sys.time(), ": Plotting components")
        
        output$deconv_plot <- renderPlot({

            if(input$run_deconvolution >= 1) { print( plot_deconvoluted_poly(solution_df=optim_df, x_vals=x_vals, y_vals=y_vals) ) }
        
        })
    })
})

