# Traffic-Prediction-using-Bayesian-Network-Model
# Traffic-Prediction-using-Bayesian-Network-Model ITC - University of Twente, Netherlands (Master Thesis | 2020)
## About
As part of my academic master thesis, submitted to the faculty of Geo-Information Science and Earth Observation, Earth Observation Department, ITC-University of Twente.
### The entire work flow is categorised into various different sections.

### 1. Area Selection
### 2. Bayesian Network Model
![Picture1](https://user-images.githubusercontent.com/5634888/121435212-1fc4bb80-c99c-11eb-9072-9fd3c188a9c7.png)

### 3. Literature study
### 4. R-Scripts
#### Bayesian Network Model
#### Bayesian Prediction Model
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

### 6. ShapeFiles

### 7. Street Network

#### Amsterdam
![Picture1](https://user-images.githubusercontent.com/5634888/121436489-4edc2c80-c99e-11eb-9e2e-6310bec0c031.png)
![Picture2](https://user-images.githubusercontent.com/5634888/121436493-500d5980-c99e-11eb-987c-ef940b4c3d87.png)

#### Rotterdam
![Picture4](https://user-images.githubusercontent.com/5634888/121436637-95318b80-c99e-11eb-9f13-efd965cc0917.png)
![Picture3](https://user-images.githubusercontent.com/5634888/121436640-9662b880-c99e-11eb-87b8-ea19a2996a7f.png)



### 8. Outputs





