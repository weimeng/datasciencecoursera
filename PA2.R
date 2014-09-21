data <- read.csv(bzfile("repdata-data-StormData.csv.bz2", "repdata-data-StormData.csv"))

# Limit data to 1996
# http://www.ncdc.noaa.gov/stormevents/details.jsp
data$BGN_DATE <- as.Date(data$BGN_DATE, format = "%m/%d/%Y")
data <- subset(data, BGN_DATE > as.Date("1995-12-31"))

# Limit data to only those we are interested in
data <- subset(data, FATALITIES > 0 | INJURIES > 0 | PROPDMG > 0 | CROPDMG > 0)

# Clean up event types
data$EVTYPE <- as.factor(tolower(data$EVTYPE))
event_types <- as.character(data$EVTYPE)
event_types[grep("astronomical low tide", event_types)] <- "Astronomical Low Tide"
event_types[grep("avalanche", event_types)] <- "Avalanche"
event_types[grep("blizzard", event_types)] <- "Blizzard"
event_types[grep("coast", event_types)] <- "Coastal Flood"
event_types[grep("extreme", event_types)] <- "Extreme Cold/Wind Chill"
event_types[grep("slide|slump", event_types)] <- "Debris Flow"
event_types[grep("fog", event_types)] <- "Dense Fog"
event_types[grep("freezing fog", event_types)] <- "Freezing Fog"
event_types[grep("smoke", event_types)] <- "Dense Smoke"
event_types[grep("drought", event_types)] <- "Drought"
event_types[grep("devil|landspout", event_types)] <- "Dust Devil"
event_types[grep("dust", event_types)] <- "Dust Storm"
event_types[grep("^heat$|warm", event_types)] <- "Heat"
event_types[grep("heat|hyperthermia", event_types)] <- "Excessive Heat"
event_types[grep("drowning|flash|dam break", event_types)] <- "Flash Flood"
event_types[grep("lakeshore", event_types)] <- "Lakeshore Flood"
event_types[grep("frost|freeze", event_types)] <- "Frost/Freeze"
event_types[grep("funnel", event_types)] <- "Funnel Cloud"
event_types[grep("marine hail", event_types)] <- "Marine Hail"
event_types[grep("hail", event_types)] <- "Hail"
event_types[grep("(heavy|torrential) rain", event_types)] <- "Heavy Rain"
event_types[grep("heavy snow", event_types)] <- "Heavy Snow"
event_types[grep("surf|high swells|astronomical high tide|erosion|rough seas", event_types)] <- "High Surf"
event_types[grep("hurricane|typhoon", event_types)] <- "Hurricane/Typhoon"
event_types[grep("ice", event_types)] <- "Ice Storm"
event_types[grep("lake", event_types)] <- "Lake-Effect Snow"
event_types[grep("lightning", event_types)] <- "Lightning"
event_types[grep("marine high wind", event_types)] <- "Marine High Wind"
event_types[grep("(non( |-)tstm|high) wind", event_types)] <- "High Wind"
event_types[grep("marine strong wind", event_types)] <- "Marine Strong Wind"
event_types[grep("marine (tstm|thunderstorm|accident)", event_types)] <- "Marine Thunderstorm Wind"
event_types[grep("rip", event_types)] <- "Rip Current"
event_types[grep("seiche", event_types)] <- "Seiche"
event_types[grep("sleet", event_types)] <- "Sleet"
event_types[grep("tide|surge|rogue wave|heavy seas|high seas", event_types)] <- "Storm Tide"
event_types[grep("strong|gusty", event_types)] <- "Strong Wind"
event_types[grep("(tstm|thunderstorm) wind|burst|whirlwind", event_types)] <- "Thunderstorm Wind"
event_types[grep("torn", event_types)] <- "Tornado"
event_types[grep("tropical depression", event_types)] <- "Tropical Depression"
event_types[grep("tropical storm", event_types)] <- "Tropical Storm"
event_types[grep("tsunami", event_types)] <- "Tsunami"
event_types[grep("volcanic ash", event_types)] <- "Volcanic ash"
event_types[grep("waterspout", event_types)] <- "Waterspout"
event_types[grep("fire", event_types)] <- "Wildfire"
event_types[grep("(blowing|excessive) snow|winter storm", event_types)] <- "Winter Storm"
event_types[grep("snow squall|winter weather|mix|freezing|icy|glaze|snow", event_types)] <- "Winter Weather"
event_types[grep("flood|high water", event_types)] <- "Flood"
event_types[grep("cold|hypothermia", event_types)] <- "Cold/Wind Chill"
event_types[grep("wind", event_types)] <- "Strong Wind"
event_types[grep("rain", event_types)] <- "Heavy Rain"
event_types[grep("fld", event_types)] <- "Flood"
event_types[grep("thunderstorm", event_types)] <- "Thunderstorm Wind"
event_types[grep("other", event_types)] <- "Other"
data$EVTYPE <- as.factor(event_types)

health_data <- subset(data, FATALITIES > 0 | INJURIES > 0)
econ_data <- subset(data, PROPDMG > 0 | CROPDMG > 0)

health_impact <- aggregate(INJURIES + FATALITIES ~ EVTYPE, health_data, FUN = sum)
health_impact <- health_impact[order(health_impact$"INJURIES + FATALITIES", decreasing = TRUE),]

replace_exponent_factors <- function(exponents) {
  exponents <- as.character(exponents)
  exponents[exponents == ""] <- 0
  exponents[exponents == "K"] <- 3
  exponents[exponents == "M"] <- 6
  exponents[exponents == "B"] <- 9
  exponents <- as.numeric(exponents)
}

econ_data$PROPDMGEXP <- replace_exponent_factors(econ_data$PROPDMGEXP)
econ_data$CROPDMGEXP <- replace_exponent_factors(econ_data$CROPDMGEXP)
