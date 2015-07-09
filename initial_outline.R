# Capstone Collaborative Exercise.

# read in the data

ants <- read.csv("~/Google Drive/ALL THE THINGS/PhD/code/R/IDTC-course/Intro_to_R-1.01/Capstone_Collaborative_Exercise/Data/Ants.csv", stringsAsFactors=FALSE) %>%
  select(-Locality_ID)

library(readxl)
library(dplyr)

# ants <- read_excel("~/Google Drive/ALL THE THINGS/PhD/code/R/IDTC-course/Intro_to_R-1.01/Capstone_Collaborative_Exercise/Data/Data appendix.xlsx")  %>%


# make them factors.

ants$Disturbance <- as.factor(ants$Disturbance)
ants$Hemisphere <- as.factor(ants$Hemisphere)
ants$Continent <- as.factor(ants$Continent)
ants$PIE <- as.factor(ants$PIE)
  
View(ants_xl)

# summarise + visualise

library(GGally)

ggpairs(ants[,c(2:6,13)])

# formulate analysis questions

head(ants)

library(ggplot2)

ggplot(data = ants,
       aes(x = Latitude,
           y = Longitude,
           colour = Species.richness)) + 
  geom_point()

ggplot(data = ants, 
       aes(x = Species.richness)) +
  geom_histogram(aes(y = ..density..)) +
  geom_density(colour = "cyan3",
               fill = "cyan3",
               alpha = 0.6) + 
  stat_function(fun = dnorm(mean(ants$Species.richness),
                            sd(ants$Species.richness)))




# Choose model 

# let's use some decision tree methods

library(randomForest)
library(rpart)
library(rpart.plot)
library(gbm)

# rpart

fit.rpart <- 
  ants %>%
  select(-Disturbance,
         -Hemisphere,
         -Continent,
         -PIE) %>%
  rpart(Species.richness ~ .,
                   data = .)

prp(fit.rpart,
    type = 4,
    extra = 1)

library(rattle)

fancyRpartPlot(fit.rpart,
               cex = 0.5,
               prefix = "Richness = ")


# gbm

fit.gbm <- 
  ants %>%
  select(-Disturbance,
         -Hemisphere,
         -Continent,
         -PIE) %>%
  gbm(Species.richness ~ .,
      data = .,
      n.trees = 1000,
      shrinkage = 0.01,
      bag.fraction = 0.5,
      train.fraction = 0.8,
      cv.folds = 5)

library(neato)

summary(fit.gbm)

## new method for gbm to get importance value

relative.influence(fit.gbm) %>% 
  as.data.frame %>%
  data.frame(importance = .[,1],
             variable = row.names(.),
             row.names = NULL) %>%
  select(variable,
         importance) 

# fit model

# produce and interpret model diagnostics

# predict from the modle, quantify uncertainty assocaited with these predictions

# Reflect and revise analysis questions

# Potentially, repeat.
