data = read.csv("data.csv",sep=';',header = TRUE,na.strings = ".")
data=data[complete.cases(data), ]
data$Condition.d.accès=strtrim(data$Condition.d.accès,7)
data=filter(data,Condition.d.accès=="gratuit" | Condition.d.accès =="payant")

data_evolution_station <- read.csv("nombre-total-de-points-de-charge.csv", sep=";",header = TRUE) %>% rename(Public = Accessible.au.public)
data_evolution_station_long <- data_evolution_station %>% pivot_longer(c(Public,Particulier,Société),names_to = "Type", values_to = "Nombre")