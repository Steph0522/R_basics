library(tidyverse)
df<- iris
class(df)
df_tibble<- as.tibble(df) #coerción
df_matrix<- as.matrix(df)
class(df_tibble)
class(df_matrix)
df_tibble

# tibble
# tidy data = debemos tener un valor numérico por cada fila, 
#para ggplot2 siempre tidy data
#ejemplo de cómo transformar mi data a tidy
b<-billboard
b1<-billboard %>%
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    values_to = "rank",
    values_drop_na = TRUE
  )
#ejemplo de gráfico
b1[1:83,] %>% ggplot(aes(x=week, y = rank, color=artist))+geom_point()

#Dplyr

#pipe = operador que me permite ejecutar función
#  %>% 

select(.data = iris, Species)

iris %>% select(Species)

iris %>% select(Species) %>% filter(
  !Species=="setosa") %>% group_by(Species) %>% count()

#te aplica la función sobre el resultado de la función anterior



#Select : select, select_if, select_at, select_all

#select = seleccionar columnas

iris %>% select(Species, Petal.Length) %>% glimpse()# solo se imprime en la consola
iris_select<- iris %>% select(Species, Petal.Length, Sepal.Length) #asignado un objeto nuevo
iris_select<- iris %>% select(especies=Species, long_sepalo=Petal.Length) #cambiando nombres y seleccionas las que quieres

#Rename
iris_rename<- iris %>% rename(especies=Species) #cambia el nombre que indico pero sin cambiar lo demás
iris %>% select(!Species) %>% glimpse() #condición negativa
iris %>% select(-Species) %>% glimpse() #condición negativa

#select_if = selecciona con condición, is.character, is.numeric, is.factor
iris %>% select_if(is.numeric) %>% glimpse()

#select_at = selecciona por posición o nombre de de columna
iris %>% select_at(c(1:3)) %>% glimpse()
iris %>% select_at(c(1,3,5)) %>% glimpse()
iris %>% select_at(c("Species", "Sepal.Width")) %>% glimpse()


#select_all = hacer cambios a todos los nombres de las columnas
iris %>% select_all(tolower) %>% glimpse()
iris %>% select(-Species) %>%  select_all(~str_replace(., ".", " ")) %>% glimpse()

#Filter = filtrar o hacer subcojuntos de nuestros datos

#filter
setosa<-iris %>% filter(Species == "setosa")
# ! filtra todo lo que no sea eso, no cumpla esa condición
no_setosa<-iris %>% filter(!Species == "setosa")
varias_cond<- iris %>% filter(Species=="setosa", Sepal.Length < 5)

#filter_if

iris[1,1]<-NA
iris %>% filter_if(is.numeric,any_vars(is.na(.)))

#filter_at
iris %>% filter_at(c("Sepal.Length", "Sepal.Width"), all_vars(.<5))

#filter_all
iris %>% select(-Species) %>% filter_all(all_vars(.<5))

#Mutate = hacer cambios sobre tus datos y crear nuevas columnas

#mutate = crear nuevas columnas

iris %>% mutate(Nueva = "probando")
iris %>% mutate(operacion = Sepal.Length/Sepal.Width)
iris_case<- iris %>% mutate(categoria = case_when(
   2 < Sepal.Width & Sepal.Width >=3  ~ "Bajo",
   3 < Sepal.Width & Sepal.Width >= 3.5 ~ "Medio",
   Sepal.Width > 3.5 ~ "Alto"))

iris_case<- iris %>% mutate(especies= case_when(
  Species=="setosa" ~"S",
  Species=="virginica" ~ "V", 
  Species== "versicolor" ~ "U"))

#mutate_if

iris %>% mutate_if(is.numeric, as.character) %>% glimpse()
iris %>% mutate_if(is.numeric, round) %>% glimpse()


#mutate_at


iris %>% mutate_at(c("Sepal.Length"), as.character) %>% glimpse()
iris %>% mutate_at(c("Sepal.Length"), ~(.*100)) %>% glimpse()


#mutate_all = menos recomendado

iris %>% mutate_all(tolower) %>% glimpse()

iris %>% mutate_all(~(.*100)) %>% glimpse()

#Group by
iris %>% group_by(Species) %>% count()
ToothGrowth %>% group_by(dose, supp) %>% count()

#Summarize = resumen de tus datos agrupados por categorías

iris %>% group_by(Species) %>% summarise(mean=mean(Sepal.Length),
                                         desvest= sd(Sepal.Length),
                                         mediana= median(Sepal.Length))


iris %>% group_by(Species) %>% summarise_if(is.numeric, sum)

iris %>%  group_by(Species) %>% summarise_at(c("Sepal.Length"), mean)

iris %>% group_by(Species) %>% summarise_all(mean)



# otras funciones del tidyverse

iris %>% rownames_to_column(var = "ids") %>% glimpse()
a<-iris %>% mutate(ids= paste0(Species, rownames(.))) %>% 
  column_to_rownames(var = "ids")

iris %>% unite("nueva", c("Species", "Sepal.Width"), sep = "_")
iris %>% separate(c("val1", "val2"), Sepal.Width, sep = ".")


#joins 
band_members; band_instruments

band_members %>% inner_join(band_instruments) #unión
band_members %>% full_join(band_instruments)#todo
band_members %>% left_join(band_instruments)# prioriza lo de la izquierda
band_members %>% right_join(band_instruments, by = c("name"="name")) #prioriza lo de la derecha

cbind(band_members, band_instruments) #una al lado de otra
rbind(band_members, band_members) #una arriba de otra


