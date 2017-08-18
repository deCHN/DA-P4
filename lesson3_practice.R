# lesson 4 practice

library(ggplot2)

data(diamonds)
?diamonds

summary(diamonds)
summary(names(diamonds))
summary(diamonds$color)
typeof(diamonds$color)

# Create a histogram of the price of
# all the diamonds in the diamond data set.

# TYPE YOUR CODE BELOW THE LINE
# =======================================
ggplot(aes(x = price), data = diamonds) +
  geom_histogram(binwidth = 100, color = I('white'), fill = I('#f79420')) +
  scale_x_continuous(limits = c(0, 19000), breaks = seq(0, 19000, 2000))

summary(diamonds$price)

# how many diamonds cost less than $500?
nrow(subset(diamonds, price < 500))

# how many diamonds cost less than $250?
nrow(subset(diamonds, price < 250))

# how many diamonds cost $15000 or more?
nrow(subset(diamonds, price > 15000 | price == 15000 ))

# Explore the largest peak in the
# price histogram you created earlier.

# Try limiting the x-axis, altering the bin width,
# and setting different breaks on the x-axis.

# There won’t be a solution video for this
# question so go to the discussions to
# share your thoughts and discover
# what other people find.

# You can save images by using the ggsave() command.
# ggsave() will save the last plot created.
# For example...
#                  qplot(x = price, data = diamonds)
#                  ggsave('priceHistogram.png')

# ggsave currently recognises the extensions eps/ps, tex (pictex),
# pdf, jpeg, tiff, png, bmp, svg and wmf (windows only).

# Submit your final code when you are ready.

# TYPE YOUR CODE BELOW THE LINE
# ======================================================================
library(Cairo)

ggplot(aes(x = price), data = diamonds) +
  geom_histogram(binwidth = 100, color = I('white'), fill = I('#f79420')) +
  scale_x_continuous(limits = c(0, 19000), breaks = seq(0, 19000, 2000)) +
  ggsave('diamondPrice.png')

# Break out the histogram of diamond prices by cut.
# You should have five histograms in separate
# panels on your resulting plot.
# TYPE YOUR CODE BELOW THE LINE
# ======================================================
ggplot(aes(x = price), data = diamonds) +
  geom_histogram(binwidth = 100, color = I('white'), fill = I('#f79420')) +
  scale_x_continuous(limits = c(0, 19000), breaks = seq(0, 19000, 1000)) +
  facet_grid(cut ~ .)

# price statistics by cut
by(diamonds$price, diamonds$cut, max)
by(diamonds$price, diamonds$cut, summary, digits = max(getOption('digits')))


# In the two last exercises, we looked at
# the distribution for diamonds by cut.

# Run the code below in R Studio to generate
# the histogram as a reminder.

# ===============================================================

qplot(x = price, data = diamonds) + facet_wrap(~cut)

# ===============================================================

# In the last exercise, we looked at the summary statistics
# for diamond price by cut. If we look at the output table, the
# the median and quartiles are reasonably close to each other.

# diamonds$cut: Fair
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     337    2050    3282    4359    5206   18570 
# ------------------------------------------------------------------------ 
# diamonds$cut: Good
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     327    1145    3050    3929    5028   18790 
# ------------------------------------------------------------------------ 
# diamonds$cut: Very Good
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     336     912    2648    3982    5373   18820 
# ------------------------------------------------------------------------ 
# diamonds$cut: Premium
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     326    1046    3185    4584    6296   18820 
# ------------------------------------------------------------------------ 
# diamonds$cut: Ideal
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     326     878    1810    3458    4678   18810 

# This means the distributions should be somewhat similar,
# but the histograms we created don't show that.

# The 'Fair' and 'Good' diamonds appear to have 
# different distributions compared to the better
# cut diamonds. They seem somewhat uniform
# on the left with long tails on the right.

# Let's look in to this more.

# Look up the documentation for facet_wrap in R Studio.
# Then, scroll back up and add a parameter to facet_wrap so that
# the y-axis in the histograms is not fixed. You want the y-axis to
# be different for each histogram.

# If you want a hint, check out the Instructor Notes.
ggplot(aes(x = price), data = diamonds) +
  geom_histogram(binwidth = 100, color = I('white'), fill = I('#f79420')) +
  scale_x_continuous(limits = c(0, 19000), breaks = seq(0, 19000, 1000)) +
  facet_grid(cut ~ ., scales = "free_y")


# Create a histogram of price per carat
# and facet it by cut. You can make adjustments
# to the code from the previous exercise to get
# started.
# Adjust the bin width and transform the scale
# of the x-axis using log10.
by(diamonds$price/diamonds$carat, diamonds$cut, max)

ggplot(aes(x = price/carat), data = diamonds) +
  geom_histogram(bins = 150, color = I('white'), fill = I('orange')) +
  scale_x_log10(breaks = seq(1000, 15000, 1000)) +
  facet_grid(cut ~ ., scales = "free_y")

  
# Investigate the price of diamonds using box plots,
# numerical summaries, and one of the following categorical
# variables: cut, clarity, or color.

# There won’t be a solution video for this
# exercise so go to the discussion thread for either
# BOXPLOTS BY CLARITY, BOXPLOT BY COLOR, or BOXPLOTS BY CUT
# to share you thoughts and to
# see what other people found.

# You can save images by using the ggsave() command.
# ggsave() will save the last plot created.
# For example...
#                  qplot(x = price, data = diamonds)
#                  ggsave('priceHistogram.png')

# ggsave currently recognises the extensions eps/ps, tex (pictex),
# pdf, jpeg, tiff, png, bmp, svg and wmf (windows only).

# Copy and paste all of the code that you used for
# your investigation, and submit it when you are ready.
# =================================================================
# 在箱线图中，我们将 y 参数作为连续数据，将 x 参数作为分类数据。
by(diamonds$price, diamonds$clarity, summary)
ggplot(aes(y = price, x = clarity), data = diamonds) +
  geom_boxplot() + 
  scale_y_continuous(breaks = seq(0, 18000, 500))

by(diamonds$price, diamonds$color, IQR)


# Investigate the price per carat of diamonds across
# the different colors of diamonds using boxplots.
# Go to the discussions to
# share your thoughts and to discover
# what other people found.

# You can save images by using the ggsave() command.
# ggsave() will save the last plot created.
# For example...
#                  qplot(x = price, data = diamonds)
#                  ggsave('priceHistogram.png')

# ggsave currently recognises the extensions eps/ps, tex (pictex),
# pdf, jpeg, tiff, png, bmp, svg and wmf (windows only).

# Copy and paste all of the code that you used for
# your investigation, and submit it when you are ready.

# SUBMIT YOUR CODE BELOW THIS LINE
# ===================================================================
ggplot(aes(y = price/carat, x = color), data = diamonds) +
  geom_boxplot() +
  scale_y_log10(breaks = seq(1000, 15000, 500))

ggplot(aes(x = carat), data = diamonds) +
  geom_histogram(binwidth = 0.05, color = 'white', fill = 'orange') + 
  scale_x_continuous(limits = c(0, 3), breaks = seq(0, 3, 0.1)) +
  scale_y_continuous(breaks = seq(0, 15000, 1000))

ggplot(aes(x = carat), data = diamonds) +
  geom_freqpoly(binwidth = 0.1, color = 'orange') +
  scale_x_continuous(limits = c(0, 3), breaks = seq(0, 3, 0.1)) +
  scale_y_continuous(breaks = seq(0, 15000, 1000))


# The Gapminder website contains over 500 data sets with information about
# the world's population. Your task is to download a data set of your choice
# and create 2-5 plots that make use of the techniques from Lesson 3.

# You might use a simple histogram, a boxplot split over a categorical variable,
# or a frequency polygon. The choice is yours!

# You can find a link to the Gapminder website in the Instructor Notes.

# Once you've completed your investigation, create a post in the discussions that includes:
#       1. any questions you answered, your observations, and summary statistics
#       2. snippets of code that created the plots
#       3. links to the images of your plots

# You can save images by using the ggsave() command.
# ggsave() will save the last plot created.
# For example...
#                  qplot(x = price, data = diamonds)
#                  ggsave('priceHistogram.png')

# ggsave currently recognises the extensions eps/ps, tex (pictex),
# pdf, jpeg, tiff, png, bmp, svg and wmf (windows only).

# Copy and paste all of the code that you used for
# your investigation, and submit it when you are ready.

# 对于一些 Gapminder 数据集，在转换为 csv 格式后，以下命令可能会很有用： read.csv('data.csv', header = T, row.names = 1, check.names = F)
# 如果你想对调数据框中的行和列，可以使用这个函数：t()。
# ====================================================================================
library(readxl)
pg <- read_excel('./population-growth.xlsx')
dim(pg)

tpg <- t(pg)

ggplot(data = pg) +
  geom_line()


# Your task is to investigate the distribution of your friends'
# birth months and days.

# Here some questions you could answer, and we hope you think of others.

# **********************************************************************

# How many people share your birthday? Do you know them?
# (Reserve time with them or save money to buy them a gift!)

# Which month contains the most number of birthdays?

# How many birthdays are in each month?

# Which day of the year has the most number of birthdays?

# Do you have at least 365 friends that have birthdays on everyday
# of the year?

# **********************************************************************

# You will need to do some data munging and additional research to
# complete this task. This task won't be easy, and you may encounter some
# unexpected challenges along the way. We hope you learn a lot from it though.

# You can expect to spend 30 min or more on this task depending if you
# use the provided data or obtain your personal data. We also encourage you
# to use the lubridate package for working with dates. Read over the documentation
# in RStudio and search for examples online if you need help.

# You'll need to export your Facebooks friends' birthdays to a csv file.
# You may need to create a calendar of your Facebook friends’ birthdays
# in a program like Outlook or Gmail and then export the calendar as a
# csv file.

# Once you load the data into R Studio, you can use the strptime() function
# to extract the birth months and birth days. We recommend looking up the
# documentation for the function and finding examples online.

# We've included some links in the Instructor Notes to help get you started.

# Once you've completed your investigation, create a post in the discussions that includes:
#       1. any questions you answered, your observations, and summary statistics
#       2. snippets of code that created the plots
#       3. links to the images of your plots

# You can save images by using the ggsave() command.
# ggsave() will save the last plot created.
# For example...
#                  qplot(x = price, data = diamonds)
#                  ggsave('priceHistogram.png')

# ggsave currently recognises the extensions eps/ps, tex (pictex),
# pdf, jpeg, tiff, png, bmp, svg and wmf (windows only).

# Copy and paste all of the code that you used for
# your investigation below the line. Submit it when you are ready.
# ===============================================================================
?read.csv
