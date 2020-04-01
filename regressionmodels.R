library(tidyverse) # Load tidyverse package
library(reshape2) # Load reshape package

# Poke around in the data to see what it's like

str(college)
head(college)
summary(college)
View(college)

#######################################
# Run a few plots to explore the data #
#######################################

ggplot(college, aes(median, fill = major_category)) + geom_histogram()
# A few majors have very high medians. There may be some pattern in the major
# categories but doesn't appear to be along median earning dimension.
# Shape looks somewhat normal.

ggplot(college, aes(sample_size)) + geom_histogram()
# Sample sizes for many majors appear very small

qplot(x = rank, y = median, data = college)
# Median and rank by median do not appear to match. Questionable data?

ggplot(college, aes(x = median, y = sample_size, color = major_category)) + geom_point()
# No obvious patterns

ggplot(college, aes(major_category, median)) + geom_boxplot()
ggplot(college, aes(major_category, p75th)) + geom_boxplot()
# Some extreme values, not sure what to make of these plots

########################
# Run some regressions #
########################

# Run a linear regression using median earnings as dependent variable
# and major category as independent variable

fit <- lm(median ~ major_category, college)
summary(fit)

# None of the major categories have p values < 0.05. R^2 is only 0.11

# Re-run without using the first category as the intercept

fit2 <- lm(median ~ major_category - 1, college)
summary(fit2)

# Now almost all the categories have p values approaching 0.
# Not sure what has happened here. High R^2 of 0.93
# Economic significance of estimates is quite compressed.
# Highest estimate is 49K (Business) and lowest 28K (Interdisciplinary).
# Most estimates appear to be around 35K to 44K, though.


