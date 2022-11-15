# plot función genérica en R

?plot()

df<- ToothGrowth
plot(ToothGrowth)

plot(x = ToothGrowth$supp, y =ToothGrowth$len ) #boxplot
plot(x = ToothGrowth$dose, y = ToothGrowth$len) #scatter
plot(x = ToothGrowth$len, y = ToothGrowth$supp)
plot(x = ToothGrowth$supp, y = ToothGrowth$supp)
plot(x = ToothGrowth$supp)

plot(ToothGrowth$len ~ ToothGrowth$supp)

modelo<- lm(ToothGrowth$len ~ ToothGrowth$supp)
summary(modelo)
anova(modelo)

plot(modelo)
hist(ToothGrowth$len)
plot(x = ToothGrowth$len, y = ToothGrowth$dose, type = "b")


#Plot con ggplot2


library(ggplot2)
library(dplyr)

df<- ToothGrowth %>% mutate(dose=case_when(
  dose=="0.5"~ "D0.5",
  dose=="1" ~ "D1",
  dose=="2"~ "D2"
))

ggplot(data = ToothGrowth,
       aes(x = supp, y = len, color=dose))+ #declarar data y mapa estético
geom_point( size=4)
ggplot(data = ToothGrowth,
       aes(x = supp, y = len, fill=dose))+ #declarar data y mapa estético
  geom_point( size=4, pch=21)

c<-ggplot(data = df,
       aes(x = dose, y = len, shape=supp, color=supp))+ #declarar data y mapa estético
  geom_point(size=5)


ggplot(data = df,
       aes(x = dose, y = len, color=supp))+ #declarar data y mapa estético
  geom_boxplot()
ggplot(data = df,
       aes(x = dose, y = len,fill=supp))+ #declarar data y mapa estético
  geom_boxplot()

ggplot(data = df,
       aes(x = dose, y = len,fill=supp, color="red"))+ #declarar data y mapa estético
  geom_col(position = position_dodge())

ggplot(data = df,
       aes(x = dose, y = len,color=supp, color="red"))+ #declarar data y mapa estético
  geom_jitter()+
  geom_boxplot()+
  geom_text(label=rownames(df))

#miscelaneo


b<-ggplot(df, aes(x = supp, y = len, fill=dose))+
  geom_boxplot()+
  scale_fill_manual(values = c("#00FFFF", "#FF00FF", "green"))

ggplot(df, aes(x = supp, y = len, fill=dose))+
  geom_boxplot()+
  scale_fill_brewer(palette = "Spectral")

library(viridis)
a<-ggplot(df, aes(x = supp, y = len, fill=dose))+
  geom_boxplot()+
  scale_fill_viridis_d(option = "turbo")+
  scale_y_continuous(limits = c(0,40))+
  scale_x_discrete(labels= c("OJ"="Jugo", "VC"="Vitamina"))+
  theme_linedraw()+
  theme(axis.title = element_text(size = 24, family = "mono", colour = "red", face = "italic"), 
        axis.text = element_text(size = 20),
        legend.text = element_text(size = 18), 
        legend.title = element_text(size = 20), 
        legend.position = "top", 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(colour = "red"),
        panel.background = element_rect(fill = "lightblue"))

library(cowplot)
plot_grid(a,b,c, labels = c("A", "B", "C"))
