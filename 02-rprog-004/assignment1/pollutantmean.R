pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        
        filename <- function(id) {
                padded_id <- formatC(id, width = 3, format = "d", flag = "0")
                paste(padded_id, "csv", sep=".")
        }
        
        location <- function(directory, filename) {
                paste(directory, filename, sep="/")
        }
        
        pollutants <- numeric()
        
        for(monitor in location(directory, filename(id))) {
                data <- read.csv(monitor)
                pollutant_data <- data[pollutant]
                good_data <- complete.cases(pollutant_data)
                pollutants <- append(pollutants, pollutant_data[good_data, ])
        }
        
        mean(pollutants)
}