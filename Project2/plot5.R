# Ques
# How have emissions from motor vehicle sources 
## changed from 1999–2008 in Baltimore City?

# PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")

# Classification of PM2.5 source
SCC <- readRDS("Source_Classification_Code.rds")

# using SCC$Short.Names category to identify 
## motor vehicle SCCs
SCC.motor <- SCC[grep("motor", SCC$Short.Name, ignore.case = T),"SCC"]

# reducing NEI data to only coal combustion sources in Baltimore city
NEI.motor <- subset(NEI, fips== "24510" & SCC %in% SCC.motor,
                    select=c(Emissions, year))

# Total emissions by year
total_PM <- aggregate(Emissions ~ year, data=NEI.motor, sum)

png("plot5.png")

plot(total_PM$year, total_PM$Emissions,
     pch=19, cex=2, col="red",
     xlab="Year", ylab=expression("PM[2.5]"),
     main="Total Emissions in Baltimore from coal combustion related sources.")

dev.off()