#assign(dados)
shinyServer(function(input, output) {
  
  addClass(selector = "body", class = "sidebar-collapse")
  
  VAsReactive <- eventReactive(input$updateVA, {
    tabSelect(tabela, input$QualTabua, input$Taxa) # input$obs,
  })
  
  output$tableC<-DT::renderDataTable(
    #digits=0,
    datatable(VAsReactive(),
              rownames = FALSE,
              options = list(
      language = list(
        info = "Mostrando de _START_ até _END_ de _TOTAL_ registros",
        paginate = list(previous = 'Anterior', `next` = 'Seguinte'),
        search = "Procurar:",
        lengthMenu = "Mostrar _MENU_ registros",
        infoFiltered = "(filtrado de _MAX_ registros no total)"
      ),
      dom = 'lftpi',
      pageLength = 5,
      lengthMenu = c(5, 10, 15, 20)
    ))
  )
  
  datasetInput <- reactive({
    # Fetch the appropriate data object, depending on the value
    # of input$dataset.
    tabSelect(tabela, input$QualTabua, input$Taxa)
  })
  
  output$table <- renderTable({
    datasetInput()
  })
  
  output$downloadData <- downloadHandler(
    
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      paste("download_comutacao.xlsx", sep = ".")
    },
    
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      sep <- ","
      
      # Write to a file specified by the 'file' argument
      # write.table(datasetInput(), file, sep = sep,
      #             row.names = FALSE)
      write_xlsx(datasetInput(), path = file)
    }
  )
    
})

