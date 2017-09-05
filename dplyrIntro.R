# Go through:
# http://rstudio-pubs-static.s3.amazonaws.com/11068_8bc42d6df61341b2bed45e9a9a3bf9f4.html

library(hflights)
library(dplyr)

dim(hflights)
data("hflights")
head(hflights)

# dplyr can work with data frames as is, but if you're dealing with large data,
# it's worthwhile to convert them to a tbl_df: this is a wrapper around a data frame that
# won't accidentally print a lot of data to the screen.

hflights_df <- tbl_df(hflights)
hflights_df

# Filter rows with filter()
# filter() allows you to select a subset of the rows of a data frame.
# The first argument is the name of the data frame, and the second and subsequent 
# are filtering expressions evaluated in the context of that data frame:
# For example, we can select all flights on January 1st with:

filter(hflights_df, Month == 1, DayofMonth == 1)

# equivalent to the more verbose:
# hflights[hflights$Month == 1 & hflights$DayofMonth == 1, ]

# filter() works similarly to subset() except that you can give it any number of 
# filtering conditions which are joined together with & (not && which is easy to do accidentally!)

# Arrange rows with arrange()
# arrange() works similarly to filter() except that instead of filtering or selecting rows,
# it reorders them. It takes a data frame, and a set of column names (or more complicated 
# expressions) to order by. Use desc() to order a order in descending order:
  
arrange(hflights_df, DayofMonth, Month, Year)
arrange(hflights_df, desc(ArrDelay))

# The previous code is equivalent to:
# hflights[order(hflights$DayofMonth, hflights$Month, hflights$Year), ]
# hflights[order(desc(hflights$ArrDelay, hflights$Month, hflights$Year), ]

# Select columns with select()
# Often you work with large datasets with many columns where only a few are actually of
# interest to you. select() allows you to rapidly zoom in on a useful subset using
# operations that usually only work on numeric variable positions:
  
# Select columns by name
select(hflights_df, Year, Month, DayOfWeek)

# Select all columns between Year and DayOfWeek (inclusive)
select(hflights_df, Year:DayOfWeek)

# Select all columns except Year and DayOfWeek
select(hflights_df, -(Year:DayOfWeek))

# Add new columns with mutate()
# As well as selecting from the set of existing columns, it's often useful to add new 
# columns that are functions of existing columns. This is the job of mutate():

mutate(hflights_df,
       gain = ArrDelay - DepDelay,
       speed = Distance / AirTime * 60)

# dplyr::mutate() works similarly to base::transform().
# The key difference between mutate() and transform() is that mutate allows you to 
# refer to columns that you just created:

mutate(hflights_df, 
       gain = ArrDelay - DepDelay, 
       gain_per_hour = gain / (AirTime / 60))


# Summarise values with summarise()
# The last verb is summarise(), which collapse a data frame to a single row.
# It's not very useful yet:

summarise(hflights_df, delay = mean(DepDelay, na.rm = TRUE))

# Commonalities

# You may have noticed that all these functions are very similar:
# The first argument is a data frame.
# The subsequent arguments describe what to do with it, and you can refer to columns 
# in the data frame directly without using $.
# The result is a new data frame

# Together these properties make it easy to chain together multiple simple steps to 
# achieve a complex result.

# Grouped operations

# These verbs are useful, but they become really powerful when you combine them with the
# idea of “group by”, repeating the operation individually on each group.
# In dplyr, you use the group_by() function to describe how to break a dataset down into groups.
# You can then use the resulting object in the exactly the same functions as above.

# Of the five verbs, arrange() and select() are unaffected by grouping.
# Group-wise mutate() and arrange() are most useful in conjunction with window functions, and
# are described in detail in the corresponding vignette(). summarise() is easy to understand
# any very useful, and is described in more detail below.

# In the following example, we split the complete dataset into individual planes and then
# summarise each plane by counting the number of flights (count = n()) and computing the
# average distance (dist = mean(Distance, na.rm = TRUE)) and
# delay (delay = mean(ArrDelay, na.rm = TRUE)). We then use ggplot2 to display the output.

planes <- group_by(hflights_df, TailNum)
delay <- summarise(planes,
                   count = n(), 
                   dist = mean(Distance, na.rm = TRUE), 
                   delay = mean(ArrDelay, na.rm = TRUE))
delay <- filter(delay, count > 20, dist < 2000)

# Interestingly, the average delay is only slightly related to the
# average distance flown a plane.
library(ggplot2)
ggplot(delay, aes(dist, delay)) + 
  geom_point(aes(size = count), alpha = 1/2) + 
  geom_smooth() + 
  scale_size_area()

# You use summarise() with aggregate functions, which take a vector of values, and return
# a single number. There are many useful functions in base R like min(), max(), mean(), sum(),
# sd(), median(), and IQR(). dplyr provides a handful of others:

# n(): number of observations in the current group
# count_distinct(x): count the number of unique values in x.
# first_value(x), last_value(x) and nth_value(x, n) - these work similarly 
# to x[1], x[length(x)], and x[n] but give you more control of the result if the value isn't 
# present.

# For example, we could use these to find the number of planes and the number of flights 
# that go to each possible destination:

destinations <- group_by(hflights_df, Dest)
summarise(destinations,
          planes = count_distinct(TailNum),
          flights = n())

# You can also use any function that you write yourself. For performance, dplyr provides
# optimised C++ versions of many of these functions. If you want to provide your own C++
# function, see the hybrid-evaluation vignette for more details.

# When you group by multiple variables, each summary peels off one level of the grouping. 
# That makes it easy to progressively roll-up a dataset:
  
daily <- group_by(hflights_df, Year, Month, DayofMonth)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))

# However you need to be careful when progressively rolling up summaries like this: 
# it's ok for sums and counts, but you need to think about weighting for means and variances, 
# and it's not possible to do exactly for medians.

