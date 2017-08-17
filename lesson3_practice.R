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
