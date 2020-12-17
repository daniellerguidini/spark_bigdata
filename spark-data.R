library(sparklyr)
library(dplyr)
library(ggplot2)
spark_install(version = "1.6.2")
options("scipen"=100, "digits"=8)
sc <- spark_connect(master = "local")

data_sp <- spark_read_csv(sc, path = 'data <- spark_read_csv(sc, path = 'hdfs:///user/hadoop/data/US_Accidents_June20.csv'))

city <- data_sp %>%
  group_by(City) %>%
  summarise(count = n()) %>%
  arrange(-count) %>%
  collect()

ggplot(city %>% head() , aes(x = reorder(City, -count), y = count, fill = City)) +
  geom_col() +
  labs(title = 'Accidents by Cities',
       x = 'Cities',
       y = 'Count') +
  theme_minimal()

weather <- data_sp %>%
  group_by(Weather_Condition) %>%
  summarise(count = n()) %>%
  arrange(-count) %>%
  collect()

ggplot(weather %>% head() , aes(x = reorder(Weather_Condition, -count), y = count, fill = Weather_Condition)) +
  geom_col() +
  labs(title = 'Accidents by Weather Conditions',
       x = 'Weather Conditions',
       y = 'Counts') +
  theme_minimal()
  
wind <- data_sp %>%
  group_by(Wind_Direction) %>%
  summarise(count = n()) %>%
  arrange(-count) %>%
  collect()

ggplot(wind %>% head() , aes(x = reorder(Wind_Direction, -count), y = count, fill = Wind_Direction)) +
  geom_col() +
  labs(title = 'Accidents by Wind Direction',
       x = 'Wind Direction',
       y = 'Counts') +
  theme_minimal()

