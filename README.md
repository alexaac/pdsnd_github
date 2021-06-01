### Date created

2021-06-01

### Project Title

Explore Bike Share Data

### Description

Explore the available bikeshare data from Washington, Chicago, and New York using R.

#### Question 1

**For NYC, how are ciclists distributed by gender and age?**

The final view of NYC cicling data, showing the proportion of female and male ciclists distributed by year of birth, depicts a greater density of women ciclists.

There are noticeable peaks of records for both genders in 1989, a positive trend towards 1989, and a slightly negative trend after 1989.

Summary:

- minimum year of birth: 1885
- minimum year of birth for women: 1893
- minimum year of birth for men: 1886
- maximum year of birth: 2001
- maximum number of records per year of birth: 2050 in 1989
- maximum number of records per year of birth for women: 574 in 1989
- maximum number of records per year of birth for men: 1510 in 1985
- number of women: 12159
- number of men: 37201

### Question 2

**How is the trip duration distributed by start station in Washington?**

For Washington, the top start stations by mean trip duration are:

1.  Reston YMCA (22633.484 seconds ~ 6 hours)
2.  Franklin & S Washington St
3.  New Hampshire & Kirklynn Ave
4.  Sligo Ave & Carroll Ln
5.  Division Ave & Foote St NE
6.  3rd & Underwood St NW
7.  Key West Ave & Siesta Key Way
8.  Barcroft Community Center
9.  S Walter Reed Dr & 8th St S
10. Minnesota Ave Metro/DOES

The top start stations by lowest mean trip duration are:

1.  Columbus Ave & Gramercy Blvd (88.7610 seconds)
2.  Solutions & Greensboro Dr
3.  Columbia Pike & S Taylor St
4.  Westpark & Park Run Dr
5.  Greensboro & International Dr
6.  Columbus Ave & Tribeca St
7.  Tysons Corner Station
8.  Lee Center
9.  Westpark Dr & Leesburg Pike
10. Benning Branch Library

Trips that lasted more than 6 hours have originated in Reston YMCA station.

### Question 3

**How is the trip duration distributed by gender in Chicago?**

This final view, showing the trip duration distributed by gender in Chicago, through quartiles, shows that the median of trip duration is a little higher for female ciclists, but the maximum trip duration was reached by a man.

Summary:

- maximum trip duration for women: 12913 seconds - 3.586944 hours
- maximum trip duration for men: 21634 seconds - 6.009444 hours
- maximum trip duration: 85408 seconds - 23.72444 hours
- median of trip duration for women: 668 seconds - 0.1855556 hours
- median of trip duration for men: 536 seconds - 0.1488889 hours
- median of trip duration: 1370 seconds - 0.3805556 hours
- number of women: 1723
- number of men: 5159

Women trip duration summary:

- min: 60 seconds - 0.01667 hours
- 1st quartile: 406 seconds - 0.11278 hours
- median: 668 seconds - 0.18556 hours
- mean: 774 seconds - 0.21500 hours
- 3rd quartile: 1004 seconds - 0.27903 hours
- max: 12913 seconds - 3.58694 hours

Men trip duration summary:

- min: 60 seconds - 0.01667 hours
- 1st quartile: 338 seconds - 0.09389 hours
- median: 536 seconds - 0.14889 hours
- mean: 655.4 seconds - 0.18206 hours
- 3rd quartile: 847.5 seconds - 0.23542 hours
- max: 21634 seconds - 6.00944 hours

### Files used

new_york_city.csv

washington.csv

chicago.csv

### Credits

udacity.com
