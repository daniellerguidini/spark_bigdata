library(sparklyr)
library(dplyr)
library(ggplot2)
spark_install(version = "1.6.2")
options("scipen"=100, "digits"=8)
sc <- spark_connect(master = "local")


data_sp <- spark_read_csv(sc,
                          path = 'E:/Dropbox/Aula/Big Data/US_Accidents_June20.csv')

#numero de acidentes por cidade
city <- data_sp %>%
  group_by(City) %>%
  summarise(count = n()) %>%
  arrange(-count) %>%
  collect()

ggplot(city %>% head() , aes(x = reorder(City, -count), y = count, fill = City)) +
  geom_col() +
  labs(title = 'Cities with more accidents',
       x = 'Cities',
       y = 'Count') +
  theme_minimal()

#numero de acidentes por condicoes climaticas
weather <- data_sp %>%
  group_by(Weather_Condition) %>%
  summarise(count = n()) %>%
  arrange(-count) %>%
  collect()

ggplot(weather %>% head() , aes(x = reorder(Weather_Condition, -count), y = count, fill = Weather_Condition)) +
  geom_col() +
  labs(title = 'Weather Conditions with more accidents',
       x = 'Weather Conditions',
       y = 'Counts') +
  theme_minimal()
  
weather <- data_sp %>%
  group_by(Weather_Condition) %>%
  summarise(count = n()) %>%
  arrange(-count) %>%
  collect()

