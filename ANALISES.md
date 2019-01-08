# Análise 1: Horários de Acesso

1. Qual é a análise:

Identificar quais faixas de horários, por dia da semana, há mais buscas ao site.

2. Motivação da análise:

Ao identificar as faixas de horário em que são realizadas um maior número de buscas, é possível utilizar esses horários para apresentar informações relevantes bem como promoções que possuem uma data de inicio e fim. Assim, por exemplo, se identificarmos que a maioria dos acessos ocorrem ao meio dia, podemos determinar esse horário como ínicio de uma promoção com duração de 24 horas.

Por sua vez, ao identificar as faixas de horário com menor acesso podemos utilizar esses horários para realizar manutenção em servidores bem como no site. Contudo essa análise deve levar em consideração uma faixa de horário que não destoa muito do horário comercial usual.

3. Como executar

A partir da variável `data_busca` que possui informações do dia, mês, ano, horas, minutos e segundos da busca. É possível com base no ano, mês e dia identificar o dia da semana. Assim, podemos agregar o banco para identificar o número de acessos por dia da semana e hora. Ao plotar por dia da semana, as horas de acesso, será possível identificar faixas de crescimento no número de buscas, bem como faixas de queda. Essas faixas que nos darão uma boa percepção dos horários de maior e menor acesso.


# Análise 2: Oferta das Companhias Aereas por Destino

1. Qual é a análise:

Identificar por destino, quantas companhias áreas usualmente oferecem voos e se em todas as buscas por esses destinos essas companhias estão aparecendo.

2. Motivação da análise:

Avaliar o motor de busca da plataforma. Por exemplo, suponha que para a maioria das buscas por voos para o trajeto Belo Horizonte - MG Navegantes -SC são apresentados ofertas das 4 companias aéreas. Entretanto, para uma certa porcentagem dessas buscas só são apresentadas ofertas de 2 companhias. Talvez a ausência dessas companhias nas ofertas possa sugerir algum problema no momento da busca.

3. Como executar

Identificar pelo banco de buscas quais são as companhias que aparecem com maior frequência para cada trajeto. Com base nesse valor esperado, identificar o quantitativo de buscas para esses trajetos que apresentam menos companhias ofertando voos. Essa análise foi realizada no storytelling presente em `analise2.html`.



# Análise 3: Avaliação do Tempo de Execução das Buscas

1. Qual é a análise:

Avaliar o tempo de execução das buscas, procurando identificar padrões paras as buscas mais rápidas e as buscas mais demoradas;

2. Motivação da análise:

Melhorar o motor de busca da plataforma, identificando os padrões de busca que demoram mais para ser executados. Uma vez identificados melhorias podem ser realizadas.

3. Como executar

A partir do campo `diff_segundos_entre_fim_da_busca_e_recebimento` conseguimos identificar o tempo de execução de cada busca. Podemos utilizar um limite de 2 minutos para diferenciar as buscas entre rápidas e demoradas. Uma vez categorizadas as buscas entre rápidas e demoradas, podemos minerar os dados em busca de padrões.

