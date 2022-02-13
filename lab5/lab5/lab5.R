library(rio)
library(here)
library(dplyr)
library(psych)


ecls <- import(here("data", "ecls-k-sub.csv"))

ecls$X1HEIGHT[ecls$X1HEIGHT<0] <- NA

t.test(x = ecls$X1HEIGHT,
       alternative = "two.sided",
       mu = 44)

x_bar <- describe(ecls$X1HEIGHT)$mean
sigma_hat <- describe(ecls$X1HEIGHT)$sd

(x_bar - 44)/sigma_hat

ecls <- import(here("data", "ecls-k-sub.csv"))
##############################################
ecls$X1WEIGHT[ecls$X1WEIGHT<0] <- NA

t.test(x = ecls$X1WEIGHT,
       alternative = "two.sided",
       mu = 47)

x_bar <- describe(ecls$X1WEIGHT)$mean
sigma_hat <- describe(ecls$X1WEIGHT)$sd

(x_bar - 47)/sigma_hat
