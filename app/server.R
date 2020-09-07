#assign(dados)
shinyServer(function(input, output) {
  
  VAsReactive <- eventReactive(input$updateVA, {
    tabSelect(tabela, input$QualTabua, input$Taxa) # input$obs,
  })
  
  output$tableC<-DT::renderDataTable(
    #digits=0,
    datatable(VAsReactive(), options = list(
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
    
})
