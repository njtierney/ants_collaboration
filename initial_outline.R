# Capstone Collaborative Exercise.

# read in the data

ants <- read.csv("~/Google Drive/ALL THE THINGS/PhD/code/R/IDTC-course/Intro_to_R-1.01/Capstone_Collaborative_Exercise/Data/Ants.csv", stringsAsFactors=FALSE)

library(readxl)

ants_xl <- read_excel("~/Intro_to_R-1.01/Capstone_Collaborative_Exercise/Data/Data appendix.xlsx")

# summarise + visualise

library(GGally)

ggpairs(ants[,c(2:6,13)])

# formulate analysis questions

head(ants)

# Choose model 

# fit model

# produce and interpret model diagnostics

# predict from the modle, quantify uncertainty assocaited with these predictions

# Reflect and revise analysis questions

# Potentially, repeat.
