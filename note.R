age.order <- ordered(reddit$age.range, levels=c("Under 18","18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"), exclude = "NA")
age.order
qplot(date = reddit, x = age.order)

ggplot(aes(x = price), data = diamonds) +
   geom_histogram(color = I('white'), fill = I('#f79420')) +
   scale_x_continuous(limits = c(0, 10000), breaks = seq(0, 19000, 5000)) +
   facet_wrap(~cut, ncol = 5)

ggplot(aes(x = price), data = na.omit(diamonds)) +
   geom_histogram(binwidth = 100, color = I('white'), fill = I('#f79420')) +
   scale_x_continuous(limits = c(0, 10000), breaks = seq(0, 19000, 5000)) +
   facet_grid(cut ~ .)

ggplot(aes(x = price), data = diamonds) +
   geom_histogram(binwidth = 100, color = I('white'), fill = I('#f79420')) +
   scale_x_continuous(limits = c(0, 19000), breaks = seq(0, 19000, 1000)) +
   facet_grid(cut ~ ., scales = "free_y")

ggplot(aes(x = price/carat), data = diamonds) +
   geom_histogram(bins = 150, color = I('white'), fill = I('orange')) +
   scale_x_log10(breaks = seq(1000, 15000, 3000)) +
   facet_grid(cut ~ ., scales = "free_y")

qplot(x = price, data = diamonds) + facet_wrap(~cut)

by(diamonds$price, diamonds$cut, max)
by(diamonds$price, diamonds$cut, summary, digits = max(getOption('digits')))

ggplot(aes(y = price, x = clarity), data = diamonds) +
   geom_boxplot() + 
   scale_y_continuous(breaks = seq(0, 18000, 500)) +
   coord_cartesian(ylim = c(0, 6500))

ggplot(aes(y = price/carat, x = color), data = diamonds) +
   geom_boxplot() +
   scale_y_log10(breaks = seq(1000, 15000, 500)) +
   coord_cartesian(ylim = c(2000, 7000))

birthday$betterDates <- as.Date(birthday$dates, '%m/%d/%Y')

# https://stackoverflow.com/questions/12395548/histgramming-dates-with-unequal-bins-in-ggplot
ggplot(aes(x = betterDates), data = birthday) +
   stat_bin(breaks = as.numeric(seq(min(birthday$betterDates), max(birthday$betterDates), '1 month')),
   position = 'identity') +
   geom_histogram(color='white', fill='orange') +
   scale_x_date(date_breaks = '2 month', labels = date_format('%B')) +
   xlab(NULL)
