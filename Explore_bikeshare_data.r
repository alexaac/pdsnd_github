
ny = read.csv('new_york_city.csv')
wash = read.csv('washington.csv')
chi = read.csv('chicago.csv')

# Question 1
# For NYC, how are ciclists distributed by gender and age?

head(ny)

# look at data

dim(ny) # rows and columns
names(ny) # column names
summary(ny) # summary

# summarize gender and year of birth data


# see number of records per birth year, and maximum records per year
get_max = function(data, column) {
    dob_counts <- table(data[[column]])
    print(dob_counts)
    
    max_cnt = max(dob_counts)
    result = which(dob_counts == max_cnt, arr.ind=TRUE)
    writeLines("\nMax per year")
    
    return (dob_counts[result])
}

print("Records count per year of birth for All")
get_max(ny, "Birth.Year")

print("Records count per year of birth for Women")
get_max(subset(ny, Gender == "Female"), "Birth.Year")

print("Records count per year of birth for Men")
get_max(subset(ny, Gender == "Male"), "Birth.Year")


# see year of birth summary by gender
print("Records count by Gender")
table(ny$Gender)

print("Summary for year of birth by Gender")
by(ny$Birth.Year, ny$Gender, summary)

# explore gender and age data using histogram

library(ggplot2)

# plot the histogram for birth year
ggplot(aes(x = Birth.Year), data = subset(ny, !is.na(Birth.Year))) +
    geom_histogram(binwidth = 1) +
    ggtitle("Birth year Distribution") +
    xlab("Birth year") +
    ylab("Count") 

# explore gender and age data using scatterplot

ggplot(aes(x = Gender, y = Birth.Year), data = subset(ny, !is.na(Birth.Year)))+
    geom_point(alpha = 1/20,
             position = position_jitter(h = 0),
             color = 'blue')+
    geom_jitter(alpha = 1/20) +
    ggtitle("Birth year by Gender") +
    ylab("Birth year") +
    xlab("Gender") 

# Separate by Gender

ggplot(aes(x = Birth.Year), data = subset(ny, !is.na(Birth.Year))) +
    geom_histogram(binwidth = 1) +
    facet_wrap(~Gender) +
    ggtitle("Birth year by Gender") +
    xlab("Birth year") +
    ylab("Count") 

# Separate by Gender and use density, so that each of the bars is a proportion

ggplot(aes(x = Birth.Year, y = ..density..), data = subset(ny, !is.na(Birth.Year))) +
    geom_histogram(binwidth = 1) +
    facet_wrap(~Gender) +
    ggtitle("Birth year by Gender") +
    xlab("Birth year") +
    ylab("Count") 

# Remove empty Gender data

ggplot(data = subset(ny, Gender != "" & !is.na(Birth.Year)), aes(x = Birth.Year, y = ..density..)) +
    geom_histogram(binwidth = 1) +
    facet_wrap(~Gender) +
    ggtitle("Birth year by Gender") +
    xlab("Birth year") +
    ylab("Count") 

# limit the time interval, add labels, title and color

ggplot(data = subset(ny, Gender != "" & !is.na(Birth.Year)), aes(x = Birth.Year, y = ..density..)) +
    geom_histogram(binwidth = 1,colour="orange", fill=NA) +
    facet_wrap(~Gender)+ 
    coord_cartesian(xlim = c(1950,2002)) +
    ggtitle("Birth year by Gender") +
    xlab("Birth year") +
    ylab("Count") 

head(wash)

# look at data

dim(wash)
names(wash)
summary(wash)

# summarize start station and trip duration data

print("Start stations for longer trips - mean")

a <- aggregate(Trip.Duration ~ Start.Station, data = wash, mean)
ordered <- a[order(a$Trip.Duration, decreasing = TRUE), ]
ordered$Duration.Hours <- ordered$Trip.Duration / 3600
head(ordered, 10)
print("Start stations for shorter trips - mean")
a <- aggregate(Trip.Duration ~ Start.Station, data = wash, mean)
ordered <- a[order(a$Trip.Duration, decreasing = TRUE), ]
ordered$Duration.Hours <- ordered$Trip.Duration / 3600
tail(ordered, 10)
print("Start stations for longer trips - sum")
a <- aggregate(Trip.Duration ~ Start.Station, data = wash, sum)
ordered <- a[order(a$Trip.Duration, decreasing = TRUE), ]
ordered$Duration.Hours <- ordered$Trip.Duration / 3600
head(ordered, 10)

# see year of birth summary by gender
print("Records count by Start station")
head(table(wash$Start.Station), 10)

print("Summary for trip duration by Start station")
head(by(wash$Trip.Duration, wash$Start.Station, summary), 10)
head(by(wash$Trip.Duration, wash$Start.Station, sum), 10)

# look at start stations data

library(ggplot2)

# show mean trip duration by start station
ggplot(data = subset(wash, Start.Station != "" & !is.na(Trip.Duration)), 
       aes(x = reorder(Start.Station, -Trip.Duration/3600), y = Trip.Duration/3600)) + 
    # stat_summary(fun.y = mean, geom="bar") +
    geom_bar(stat = "summary_bin", fun.y = mean) +
    theme(axis.text.x = element_text(angle = 90, vjust=0.5, size=5)) +
    #coord_cartesian(ylim = c(0, 10)) +
    ggtitle("Trip duration per start station, in hours") +
    xlab("Start station") +
    ylab("Trip Duration")

# find top ten stations

library(plyr)

# simple method to get top stations by mean duration
a <- aggregate(Trip.Duration ~ Start.Station, data = wash, mean)
ordered <- a[order(a$Trip.Duration, decreasing = TRUE), ]
ordered$Duration.Hours <- ordered$Trip.Duration / 3600
top <- head(ordered, 10)
top 

# alternate method to get top stations
group_mean <- aggregate(wash$Trip.Duration, list(wash$Start.Station), mean)
group_mean
top10Stations <- group_mean[rev(order(group_mean$x)),"Group.1"][0:11]
top10Stations

wash$Group <- ifelse(wash$Start.Station %in% top10Stations, as.character(wash$Start.Station), "Other")
wash$Group <- factor(wash$Group, levels=unique(c(as.character(top10Stations), "Other")))
wash.summary <- ddply(wash, .(Group), summarise, total=sum(Trip.Duration))
wash.summary$prop <- wash.summary$total / sum(wash.summary$total)

# show mean trip duration by top start stations

ggplot(top, aes(x = reorder(Start.Station, -Duration.Hours), y = Duration.Hours)) +
    stat_summary(fun.y="mean", geom="bar") +
    ggtitle("Top ten Start stations by mean Trip duration") +
    xlab("Start station") +
    ylab("Trip duration in hours") +
    coord_flip()


head(chi)

# look at data

dim(chi)
names(chi)
summary(chi)

# summarize gender and trip duration data

# see trip duration summary
summary(chi$Trip.Duration)

# see year of birth summary by gender
print("Records count by Gender")
table(chi$Gender)

# add duration in hours as field
chi$Duration.Hours <- chi$Trip.Duration / 3600

#group by gender
print("Summary for Trip duration by Gender")
grouped <- by(chi$Trip.Duration, chi$Gender, summary)
grouped
print("Summary for Trip duration by Gender, in hours")
grouped <- by(chi$Duration.Hours, chi$Gender, summary)
grouped

# draw a boxplot to show distribution of trip duration by gender

qplot(x = Gender, y = Duration.Hours, data = chi, 
    geom = 'boxplot') +
    ggtitle("Trip duration by Gender") +
    ylab("Trip duration in hours") +
    xlab("Gender") 

# limit trip duration results

qplot(x = Gender, y = Duration.Hours, data = chi,
    geom = 'boxplot', ylim = c(0,7)) +
    ggtitle("Trip duration by Gender") +
    ylab("Trip duration in hours") +
    xlab("Gender") 

# remove empty Gender records

qplot(x = Gender, y = Duration.Hours, data = subset(chi, Gender != ""),
    geom = 'boxplot', ylim = c(0,7)) +
    ggtitle("Trip duration by Gender") +
    ylab("Trip duration in hours") +
    xlab("Gender") 

# limit the trip duration values to 2 hours

qplot(x = Gender, y = Duration.Hours, data = subset(chi, Gender != ""),
    geom = 'boxplot', ylim = c(0,2)) +
    ggtitle("Trip duration by Gender") +
    ylab("Trip duration") +
    xlab("Gender") 

# compare two datasets

names(ny)
names(chi)

# add duration in hours as field to NYC, too
ny$Duration.Hours <- ny$Trip.Duration / 3600

# add source column to bind the data to each dataset
ny$Source <- "ny"
chi$Source <- "chi"

merged <-rbind(ny, chi)

# make boxplot for each data source
qplot(x = Gender, y = Duration.Hours, data = subset(merged, Gender != ""),
    geom = 'boxplot') +
    ggtitle("Trip duration by Gender") +
    ylab("Trip duration") +
    xlab("Gender") + 
    facet_wrap(~Source)

# remove more outliers

qplot(x = Gender, y = Duration.Hours, data = subset(merged, Gender != ""),
    geom = 'boxplot', ylim = c(0,35)) +
    ggtitle("Trip duration by Gender") +
    ylab("Trip duration") +
    xlab("Gender") + 
    facet_wrap(~Source)

# remove more outliers

qplot(x = Gender, y = Duration.Hours, data = subset(merged, Gender != ""),
    geom = 'boxplot', ylim = c(0,5)) +
    ggtitle("Trip duration by Gender") +
    ylab("Trip duration") +
    xlab("Gender") + 
    facet_wrap(~Source)

# make the summary for each source
print("Summary for Trip duration by Gender, in hours, for NYC")
grouped <- by(ny$Duration.Hours, ny$Gender, summary)
grouped
print("Summary for Trip duration by Gender, in hours, for NYC, after removing the 300 hours outlier")
ny_clean <- subset(ny, Duration.Hours < 300)
grouped <- by(ny_clean$Duration.Hours, ny_clean$Gender, summary)
grouped
print("Summary for Trip duration by Gender, in hours, for Chicago")
grouped <- by(chi$Duration.Hours, chi$Gender, summary)
grouped

system('python -m nbconvert Explore_bikeshare_data.ipynb')
