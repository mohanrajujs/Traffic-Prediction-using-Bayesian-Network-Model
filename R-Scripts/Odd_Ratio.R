data1 = RTM_2020_Cat_Agg
data2 = lapply(data1, as.factor)
data3 = data.frame(data2)
library(oddsratio)
fit_glm = glm(Average_Intensity ~ Average_Time + Vehicle_Cat + Average_Speed + Time.of.the.day , data = data3, family = binomial)
or_glm(data = data3, model = fit_glm, incr = 1)