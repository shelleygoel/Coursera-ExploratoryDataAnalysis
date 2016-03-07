# Que
# Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#.taNEI <- readRDS("summarySCC_PM25.rds")

# relevant years
years <- c(1999, 2002, 2005, 2008)

# subsetting data to only relevant years and 
## Baltimore City(fips="24510")
NEI <- subset(NEI, (year %in% years & fips == "24510"),
              select=SCC:year)

# split data into one data frames 
## per source type
sourcetype_NEI <- split(NEI, NEI$type)

# new data frame to store mean of emissions for each year 
## and source type
mean_PM <- data.frame(rep(names(sourcetype_NEI),each=4))
names(mean_PM) <- "type"

mean_PM$year <- rep(years,4)

mean_emission <- c()
# Total emissions for each year 
for (type in names(sourcetype_NEI)){
        PM_year <- tapply(sourcetype_NEI[[type]]$Emissions,
                          sourcetype_NEI[[type]]$year, mean)
        mean_emission <- c(mean_emission, PM_year)
}

mean_PM$Emissions <- mean_emission

# plotting emissions vs year from each type of source
library(ggplot2)

png("plot3.png",width=520,height=520,units="px")

g<-ggplot(mean_PM,aes(year,Emissions)) # creating graphics object

g<-g + geom_point(aes(col=type), cex=3) + 
        labs(title="Mean PM2.5 Emissions for Baltimore City")

print(g)
dev.off()