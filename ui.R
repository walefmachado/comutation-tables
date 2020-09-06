library(shiny)
library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "Comutação"), #Cabeçalho
    dashboardSidebar( #Menu Lateral
      sidebarMenu(
        menuItem("Início", tabName = "inicio", icon=icon("chalkboard"))
      )
    ),

    dashboardBody( #Corpo da página
        #Abas usadas para organizar a página por produtos e chamar a saída respectiva para o mesmo

        tags$head(tags$link(rel = "stylesheet",
                       type = "text/css",
                       href = "styles.css")),

# tab inicio --------------------------------------------------------------

        tabItems(
          tabItem(tabName = "inicio",
                  fluidRow(
                    box(
                      selectizeInput('QualTabua', 'Tábua:', 
                                     choices = list(`AT 2000 F`= 'at_2000_F', 
                                                    `AT 2000 M` = 'at_2000_M', 
                                                    `AT 49 F` = 'AT_49_F',
                                                    `AT 49 M` = 'AT_49_M', 
                                                    `AT 83 F` = 'AT_83_F',
                                                    `AT 83 M` = 'AT_83_M'), 
                                     multiple = FALSE)  
                    ),
                    box(
                      numericInput("Taxa", "Taxa de juros", min = 0, max = 1, value = 0.06, step = 0.001)
                    )
                  ),
                  fluidRow(
                    box(
                      actionButton("updateVA", "Gerar tabela"),
                      actionButton("reset", "Reset")
                    )
                  ),
                  fluidRow(
                    DT::dataTableOutput('tableC')
                  )
                  
                  
          )
        )
    )
)
