# instalacao e carregamento dos pacotes necessarios
install.packages("sparklyr")
install.packages("shiny")
library(sparklyr)
library(shiny)

# instalacao spark
spark_install(version = "3.0.1", hadoop_version = "3.2")

# conexao com o Spark
sc <- spark_connect(master = "local")


