# Traffic-Prediction-using-Bayesian-Network-Model 
### ITC - University of Twente, Netherlands (Master Thesis | 2020)
## About
As part of my academic master thesis, submitted to the faculty of Geo-Information Science and Earth Observation, Earth Observation Department, ITC-University of Twente.
### The entire work flow is categorised into various different sections:-

### 1. Area Selection
For this case study, I have choosen major cities in Netherlands. Namely, Amsterdam & Rotterdam.
| Indicators | Amsterdam  | Rotterdam  |
| :---:   | :-: | :-: |
| Area covered | 193.5 Sq km | 161.6 Sq km |
| No. of edges in network | 26580 | 25387 |
| Avg street length | 102.58 | 97.7 |
### 2. Bayesian Network Model
The model was validated using k-fold cross validation criteria where in the bayesian network was designed based on IAMB & Hill climbing learning algorithms.
![Picture1](https://user-images.githubusercontent.com/5634888/121435212-1fc4bb80-c99c-11eb-9072-9fd3c188a9c7.png)

### 3. Literature study
Various research papers were studied to understand the complexities of the baysian networks. The detailed study papers can be found in the folder 'literature study'.
### 4. R-Scripts
  - 4.1  Bayesian Network Model
```
library(readxl)
library(bnlearn)
data1 = RTM_2020_Cat_Agg
data2 = lapply(data1, as.factor)
data3 = data.frame(data2)
pdag = hc(data3)
pdag
plot(pdag)
dag = set.arc(pdag, from = "Vehicle_Cat", to = "Average_Intensity")
dag1 = set.arc(dag, from = "Time.of.the.day", to = "Average_Time")
dag2 = set.arc(dag1, from = "Time.of.the.day", to = "Average_Intensity")
dag3 = drop.arc(dag2, from = "Day.in.a.week", to = "Average_Speed")
dag4 = drop.arc(dag3, from = "Day.in.a.week", to = "Week.Day.Week.End")
dag5 = set.arc(dag4, from = "Day.in.a.week", to ="Average_Speed")
dag6 = set.arc(dag5, from = "Week.Day.Week.End", to = "Average_Time")
dag7 = set.arc(dag6, from = "Average_Time", to = "Average_Intensity")
dag8 = set.arc(dag7, from = "Average_Time", to = "Average_Speed")
dag9 = set.arc(dag8, from = "Average_Speed", to = "Average_Intensity")
dag10 = drop.arc(dag9, from = "Day.in.a.week", to = "Average_Intensity")
getOption("max.print")
dag10
plot(dag10)
score(dag10, data3, type = "bic")
score(dag10, data3, type ="aic")
score(dag10, data3, type="bde")
score(dag10, data3, type="k2")

fit = bn.fit(dag10, data3)
print(fit$Day.in.a.week)
print(fit$Week.Day.Week.End)
print(fit$Time.of.the.day)
print(fit$Average_Speed)
print(fit$Average_Time)
print(fit$Average_Intensity)
print(fit$Vehicle_Cat)
fit
cpquery(fit, event = (Average_Time =="High"), evidence = (Average_Speed=="High"))
cpquery(fit, event = (Average_Intensity =="High"), evidence = (Average_Speed=="Low" & Average_Time =="High"))
bn.cv(data3, bn ="iamb", k =5)

# Hill climbing Algorithm
data3 = data.frame(data2)
pdag1 = hc(data3)
pdag1
plot(pdag1)
pdag1 = set.arc(pdag1, from = "Vehicle_Cat", to = "Average_Intensity")
plot(pdag1)
score(pdag1, data3, type = "bic")
score(pdag1, data3, type ="aic")
score(pdag1, data3, type="bde")
score(pdag1, data3, type="k2")
```
  - 4.2  Bayesian Prediction Model
```
library(readxl)
library(bnlearn)
library(forecast)
data1 = Time_Wise_2020_D1_Cont
data3 = data.frame(data1)
abc = data3[1:200, ]
def = data3[201:743, ]
pdag = hc(abc)
pdag
plot(pdag)
dag = set.arc(pdag, from = "Vehicle_Cat", to = "Average_Intensity")
dag2 = set.arc(dag, from = "Time.of.the.day", to = "Average_Intensity")
dag3 = drop.arc(dag2, from = "Day.in.a.week", to = "Average_Speed")
dag4 = drop.arc(dag3, from = "Day.in.a.week", to = "Week_Day_Week_End")
dag5 = set.arc(dag4, from = "Day.in.a.week", to ="Average_Speed")
dag6 = set.arc(dag5, from = "Week_Day_Week_End", to = "Average_Time")
dag7 = set.arc(dag6, from = "Average_Time", to = "Average_Intensity")
dag8 = set.arc(dag7, from = "Average_Time", to = "Average_Speed")
dag9 = set.arc(dag8, from = "Average_Speed", to = "Average_Intensity")
options(max.print=1000000)
dag9
plot(dag9)
fitttted = bn.fit(dag9, abc)
pred = predict(fitttted, "Average_Intensity", def)
#cbind(pred, def[, "Average_Intensity"])
cbind(predicted =pred, actual = def[, "Average_Intensity"])
accuracy(forecast(pred))
accuracy(f = pred, x = def[, "Average_Intensity"])
accuracy(forecast(def$Average_Intensity))
accuracy(forecast(abc$Average_Intensity))
```
### 5. Sensor Data
Traffic data was downlaoded from National dataware house agency, a repository for traffic related information: [NDW, NL](https://www.ndw.nu/)
### 6. ShapeFiles
For the developement of BN model, various vector tiles was stacked on top of eachother, the vector files were used to extract the street related information.
### 7. Street Network [Outputs]

 - #### Amsterdam
![Picture1](https://user-images.githubusercontent.com/5634888/121436489-4edc2c80-c99e-11eb-9e2e-6310bec0c031.png)
![Picture2](https://user-images.githubusercontent.com/5634888/121436493-500d5980-c99e-11eb-987c-ef940b4c3d87.png)

 - #### Rotterdam
![Picture4](https://user-images.githubusercontent.com/5634888/121436637-95318b80-c99e-11eb-9f13-efd965cc0917.png)
![Picture3](https://user-images.githubusercontent.com/5634888/121436640-9662b880-c99e-11eb-87b8-ea19a2996a7f.png)


