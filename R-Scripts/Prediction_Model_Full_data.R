library(readxl)
library(bnlearn)
library(forecast)
data1 = Time_wise_2019_D1_Full_data
data3 = data.frame(data1)
training1 = data3[2:500000, ]
testing1 = data3[500001:781630, ]
res = hc(training1)
plot(res)
res1 = drop.arc(res, from = "Average_intensity", to ="Vehicle_Cat")
res2 = drop.arc(res1, from = "Average_intensity", to ="Time.of.the.day")
res33 = drop.arc(res2, from = "Average_intensity", to ="Average_Speed")
res44 = drop.arc(res33, from = "Average_intensity",  to="Day.in.a.week")

res55 = set.arc(res44, from = "Vehicle_Cat", to ="Average_intensity")
res66 = set.arc(res55, from = "Time.of.the.day", to ="Average_intensity")
res77 = set.arc(res66, from = "Average_Speed", to ="Average_intensity")
res88 = set.arc(res77, from = "Day.in.a.week",  to="Average_intensity")
plot(res88)

res3 = drop.arc(res2, from = "Average_Time", to = "Average_Speed")
#res4 = drop.arc(res3, from = "Average_Intensity", to ="Time.of.the.day")
res5 = drop.arc(res3, from = "Average_Intensity", to ="Average_Speed")
res6 = drop.arc(res5, from = "Week.Day.Week.End", to = "Time.of.the.day")
res7 = set.arc(res6, from = "Average_Speed", to = "Average_Intensity")
res8 = set.arc(res7, from = "Average_Speed", to ="Vehicle_Cat")

plot(res)
res
fitttted = bn.fit(res88, training1)
pred = predict(fitttted,"Average_intensity", testing1)
cbind(predicted =pred, actual = testing1[, "Average_intensity"])
accuracy(forecast(training1$Average_intensity))
accuracy(forecast(testing1$Average_intensity))