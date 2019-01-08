
# Funções para auxiliar a análise

removeAcentos = function(vetor){
  
  #===================================================================================
  # Remove acentos de um vetor, considerando se o Encoding deste é UTF-8 ou unknown.
  # Outros tipos de enconding não foram considerados
  #===================================================================================
  
  removeAcentoEncoding = function(texto, encoding){
    encoding = ifelse(encoding=="UTF-8", "TRUE", "FALSE")
    switch(encoding, "TRUE" = tolower(iconv(texto, from="UTF-8", to="ASCII//TRANSLIT")),
           "FALSE" = tolower(iconv(texto, to="ASCII//TRANSLIT")))
  }
  
  return(unlist(lapply(vetor, function(x) removeAcentoEncoding(x, Encoding(x)))))
  
}


corrige_nome_mun = function(var){
  
  #===================================================================================
  # Identifica o nome do município para casos especiais do banco de buscas
  #===================================================================================
  
  var[var == "lencois chapada diamantina"] = "lencois"
  var[var == "sao joao del-rei"] = "sao joao del rei"
  var[var == "aeroporto de teixeira de freitas"] = "teixeira de freitas"
  var[var == "campinas viracopos"] = "campinas"
  
  return(var)
  
}


gera_percurso = function(x){
  
  #===================================================================================
  # Gera o mesmo resultado para A indo pra B e B indo pra A.
  # Ex.: Belo Horizonte - Navegantes, ou Navegantes - Belo Horizonte
  # será considerado unicamente como Belo Horizonte - Navegantes
  #===================================================================================
  
  return(paste(sort(x), collapse = " - "))
}


gera_moda <- function(x) {
  #===================================================================================
  # Gera a Moda de um vetor x
  #===================================================================================
  
  vl_uniq <- unique(x)
  vl_uniq[which.max(tabulate(match(x, vl_uniq)))]
}



gera_grafico1 = function(){
  
  #===================================================================================
  # Gera o gráfico de barras empilhadas da porcentagem das buscas para cada nivel, 
  # por mes de busca
  #===================================================================================
  
  graph_mes_ida = ggplot() + theme_bw()
  
  graph_mes_ida = graph_mes_ida + geom_bar(aes(y = porcentagem, x = mes_ida, fill = nivel), 
                                           data = nivel_mes, stat="identity")
  
  graph_mes_ida = graph_mes_ida + geom_text(data=nivel_mes,
                                            aes(x = mes_ida, y = posicao,
                                          label = paste0(round(porcentagem, 0), "%")), size=3, col = "white")
  
  graph_mes_ida = graph_mes_ida + scale_fill_manual(values=c("#0e0872", "#660000"))
                                          
  graph_mes_ida = graph_mes_ida + scale_y_continuous(labels = function(x) paste0(x, "%"))
  graph_mes_ida = graph_mes_ida + ggtitle("Percentual de Buscas por Nível e por Mês da Data de Ida")
  
  graph_mes_ida = graph_mes_ida + theme(legend.position="bottom", legend.direction="horizontal",
                                        legend.title = element_blank(), 
                                        legend.spacing.x = unit(1.0, 'cm'),
                                        axis.line = element_line(colour = "black"),
                                        panel.grid.major = element_blank(),
                                        panel.grid.minor = element_blank(),
                                        panel.border = element_blank(),
                                        panel.background = element_blank(),
                                        axis.text.x=element_text(angle = 90, hjust = 1, colour="black", 
                                                                 size = 8, face = "bold"),
                                        axis.text.y=element_text(colour="black", size = 8, face = "bold"),
                                        plot.title = element_text(hjust = 0.5))
  
  graph_mes_ida = graph_mes_ida + labs(x="Mês da data de ida", y="Porcentagem") 
  
  return(graph_mes_ida)
}


gera_lista_ca_faltantes = function(analise_2018_03){
  
  #===================================================================================
  # Gera a variável lst_ca_faltantes que é a diferença entre a lista de companhias
  # esperadas e a lista de companhias apresentadas na busca
  #===================================================================================
  
  
  analise_2018_03[, lst_ca_faltantes := ""]
  
  for(i in 1:nrow(analise_2018_03)){
    
    valor = paste(setdiff(strsplit(analise_2018_03$cia_esperadas[i], " ")[[1]], 
                          strsplit(analise_2018_03$lst_companhias[i], " ")[[1]]), collapse = " ")
    
    analise_2018_03$lst_ca_faltantes[i] = valor
    
  }
  
  return(analise_2018_03)

}

gen_freq_cia = function(recorte, nome_cia){
  
  #===================================================================================
  # Gera uma variável com o nome da companhia. Essa variável assumirá o valor 1
  # quando nome_cia aparecer em lst_ca_faltantes
  #===================================================================================
    
  recorte[, V1 := 0]
  recorte[grepl(nome_cia, lst_ca_faltantes), V1 := 1]
  setnames(recorte, "V1", nome_cia)
  return(recorte)
}


gera_grafico2 = function(){
  
  #===================================================================================
  # Gera o gráfico de linhas mostrando a frequência que as companhias estão faltando 
  # nas buscas 
  #===================================================================================
  
  p = ggplot(analise_2018_03_dia, aes(x=data_busca, y=freq, group=companhia, col = companhia))
  
  p = p + theme_bw()
  
  p = p + geom_line(size=1.2) 
  
  p = p + geom_point(data = analise_2018_03_dia, aes(shape=companhia), size = 2)
  
  p = p + theme(legend.position="bottom", legend.direction="horizontal",
                legend.title = element_blank(), 
                legend.spacing.x = unit(1.0, 'cm'),
                axis.line = element_line(colour = "black"),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.border = element_blank(),
                panel.background = element_blank(),
                axis.text.x=element_text(angle = 90, hjust = 1, colour="black", 
                                         size = 8, face = "bold"),
                axis.text.y=element_text(colour="black", size = 8, face = "bold"),
                plot.title = element_text(hjust = 0.5))
  
  p = p + ggtitle("Evolução do Número de Ausência nas Buscas por Companhia Aérea")
  p = p + labs(x="Data da Busca", y="Frequência")
  
  p
}



