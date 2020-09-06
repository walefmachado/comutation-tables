# Verifica Bibliotecas
if (!(is.element("pacman", installed.packages()[,1]))) {
    install.packages("pacman")
}

pacman::p_load(plotly, tidyverse, reshape2, shiny, shinydashboard, DT)
#packrat::.snapshotImpl(".", snapshot.sources = FALSE) # cria arquivo packrat com todas dependências 

# Bibliotecas
library(plotly)
library(reshape2)


# Dados para aplicação
tabuas = read.csv('https://raw.githubusercontent.com/walefmachado/comutation_tables/master/data/TABUAS.csv',sep = ';', dec = ',')
# attach(dados)


tabela = function(nome, juros){
  x = 0:(length(tabuas[, nome])-1)
  v = (1/(1+juros))**x; v = append(v, 0)
  qx = tabuas[, nome]
  px = 1-qx
  lx = 10000
  for (i in 2:length(px)) {
    lx = append(lx, lx[i-1]*px[i-1] )    
  }
  dx = qx*lx
  Cx = dx * v[2:length(v)]
  Dx = lx * v[-length(v)]
  Mx = rev(cumsum(rev(Cx)))
  Nx = rev(cumsum(rev(Dx)))
  Ax = Mx/Dx
  
  data.frame(x, qx, px, lx, dx, Cx, Dx, Mx, Nx)
}

tabSelect = function(tabuas, QualTabua, Taxa){
  MinhaTabua = as_tibble(tabela(as.character(QualTabua[1]), Taxa))
  return(MinhaTabua)
}

