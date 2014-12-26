corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations

        filename <- function(id = 1:332) {
                padded_id <- formatC(id, width = 3, format = "d", flag = "0")
                paste(padded_id, "csv", sep=".")
        }
        
        location <- function(directory, filename) {
                paste(directory, filename, sep="/")
        }
        
        complete_data <- vector()
        
        for(monitor in location(directory, filename())) {
                data <- read.csv(monitor)             
                valid <- complete.cases(data)
                good_data <- data[valid, ]                
                
                if(nrow(good_data) > threshold) {
                        correlation <- cor(good_data["sulfate"], good_data["nitrate"])
                        complete_data <- append(complete_data, correlation)
                }
        }
        
        complete_data
}