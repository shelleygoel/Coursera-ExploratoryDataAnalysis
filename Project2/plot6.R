# Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County.
## (fips == "06037")
## Which city has seen greater changes over time in motor vehicle emissions?

# PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")

# Classification of PM2.5 source
SCC <- readRDS("Source_Classification_Code.rds")

# using SCC$Short.Names category to identify 
## motor vehicle SCCs
SCC.motor <- SCC[grep("motor", SCC$Short.Name, 
                      ignore.case=T),"SCC"]

# reducing NEI data to only motor sources in Baltimore city
# and Los Angeles County
NEI.motor <- subset(NEI, (fips=="24510" | fips=="06037") 
                    & SCC %in% SCC.motor,
                    select=c(Emissions, year, fips))


        
# Total emissions by year
total_PM <- aggregate(Emissions ~ year + fips, data=NEI.motor, sum)

# substituting fips for name of counties
names(total_PM)[2] <- "County"
total_PM$County[total_PM$County=="24510"] <- "Baltimore County"
total_PM$County[total_PM$County=="06037"] <- "Los Angeles County"

png("plot6.png", width=500)

g <- ggplot(total_PM,aes(year,Emissions)) 
g <- g + geom_line(aes(col=County)) + geom_point(aes(col=County)) + 
        labs(y=expression("Total PM"[2.5]),
               title="Comparision of PM2.5 Emissions from Motor Vehicles by County") 
        

print(g)
dev.off()