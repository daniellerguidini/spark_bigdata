# US Accidents using Hadoop, Spark and R
> Daniel Klug, Danielle Rodrigues Guidini, Eduardo José Silva e Matheus da Conceição Evaldt

Análise do dataset US Accidents, encontrado em: https://www.kaggle.com/sobhanmoosavi/us-accidents?select=US_Accidents_June20.csv, utilizando as ferramentas Hadoop, Spark e R.

O dataset selecionado agrupa cerca de 3,5 milhões de registros de acidentes de trânsito ocorridos entre fevereiro de 2016 e junho de 2020 em 49 estados dos Estados Unidos da 
América. Os dados nele contidos foram coletados de diversas fontes, tais como os departamentos federais e estaduais de transportes, agências policiais, e câmeras e sensores 
de trânsito espalhados ao longo da malha rodoviária . 

Os dados brutos são disponibilizados em formato tabular, organizados em 49 colunas, e estão armazenados em arquivo com extensão CSV de aproximadamente 1.24GB de tamanho.

## Relatório
Está disponível o relatório em pdf com o passo a passo da configuração do ambiente, instalação das ferramentas, análise dos dados e tudo o mais necessário para o desenvolvimento da aplicação (big_data_VF.pdf). Também disponibilizamos um arquivo .pdf com os slides da apresentação (slides_us_accidents.pdf).

## Pré-Requisitos
As ferramentas utilizadas são:
* Máquina Virtual: sistema operacional Linux Ubuntu (64-bit), alocação de 4096 MB de memória e disco com alocação dinâmica com 10 GB de tamanho, em formato VDI
* Hadoop 3.2.1
* Spark 3.0.1 
* R 4.0.3
* RStudio 1.3.1093

## Instalação Hadoop
O processo de configuração do ambiente Hadoop e ingestão dos dados no HDFS pode ser realizado pelo script . ./hadoop-config.sh através do comando:

```
chmod a+rwx hadoop-config.sh && ../hadoop-config.sh
```

## Instalação R e RStudio
O processo de instalação do R e de todas as dependências necessárias para os pacotes que utilizamos na análise pode ser realizado pelo script . ./R-config.sh através do comando:

```
chmod a+rwx R-config.sh && ../R-config.sh
```

A instalação da IDE RStudio pode ser realizada pelos seguintes passos:
1. Acesse https://rstudio.com/products/rstudio/download/#download.
2. Realize o download da versão para o sistema operacional Ubuntu 18/Debian 10.
3. Execute o arquivo baixado e siga os passos da instalação padrão.

## Script .R com a Integração Spark/R e análises do dataset
O script . ./spark-data.R contém o processo de integração do Spark com o R e também os códigos de análise do dataset com o intuito de responder 3 perguntas iniciais:
1. Quais cidades possuem o maior número de acidentes?
2. Qual a distribuição de acidentes de acordo com as condições climáticas na hora do acidente?
3. A direção do vento impacta no número de acidentes?


