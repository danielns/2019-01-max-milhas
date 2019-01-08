## Storytelling

Presente no arquivo `analise2.html` na raiz do projeto.

## Para rodar os comandos do R

Foram utilizadas features simples dos pacotes e softwares. Assim, acredito que não haja problemas em instalar versões mais recentes.

Necessário montar o banco `out_analise2.csv`, a partir do banco `data-raw/out.csv` (log de buscas). Realizar os seguintes comandos do `bash`:

```console
cd data-raw
cut -d";" -f3,4,8,9,16,19,25,31,35 out.csv > out_analise2.csv
```

Softwares necessários:
1. [R](https://www.r-project.org/) versão 3.3.2
2. [Rstudio](https://www.rstudio.com/) versão 1.0.136

Pacotes R:

- data.table versão 1.11.2
- readxl versão 1.1.0
- ggplot2 versão 3.0.0
- kableExtra versão 0.9.0
- knitr versão 1.20

Para instalar um pacote digitar no shell de comandos R:

```R
install.packages("data.table")
```

Abrir primeiro `2019-01-max-milhas.Rproj` e dentro dessa seção do Rstudio abrir `analise2.Rmd`

Em `analise2.Rmd` pressionar o botão `Knit` > `Knit to HTML` para compilar `analise2.html`.
