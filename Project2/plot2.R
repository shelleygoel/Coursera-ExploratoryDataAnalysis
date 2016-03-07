# Que
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Que 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


# PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")

# relevant years
years <- c(1999,2002,2005,2008)

# subsetting data to only relevant years and 
#Baltimore City(fips="24510")
NEI <- subset(NEI, (year %in% years & fips == "24510"))

# Total emissions for each year 
total_PM <- tapply(NEI$Emissions,NEI$year,sum)

# plotting emissions vs year
png("plot2.png",width=520,height=520,units="px")

plot(years, total_PM, pch=19, col="red",
     ylab=expression("PM[2.5]"), 
     xlab="year",main="Total Emissions in Baltimore city,Maryland")

dev.off()