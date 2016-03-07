# Ques
# Across the United States, how have emissions from coal 
## combustion-related sources changed from 1999–2008?

# PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")

# Classification of PM2.5 source
SCC <- readRDS("Source_Classification_Code.rds")

# using SCC$Short.Names category to identify 
## coal combustion-related SCCs
SCC.coal <- SCC[grep("coal", SCC$Short.Name, ignore.case = T),"SCC"]

# reducing NEI data to only coal combustion sources
NEI.coal <- subset(NEI, SCC %in% SCC.coal, select=c(Emissions, year))

# Total emissions by year
total_PM <- aggregate(Emissions ~ year, data=NEI.coal, sum)

png("plot4.png")

plot(total_PM$year, total_PM$Emissions,
     pch=19, cex=2, col="red",
     xlab="Year", ylab=expression("PM[2.5]"),
     main="Total Emissions in US from coal combustion related sources.")

dev.off()
