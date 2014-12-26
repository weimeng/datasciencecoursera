complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        
        filename <- function(id) {
                padded_id <- formatC(id, width = 3, format = "d", flag = "0")
                paste(padded_id, "csv", sep=".")
        }
        
        location <- function(directory, filename) {
                paste(directory, filename, sep="/")
        }
        
        complete <- data.frame()
        
        for(monitor in location(directory, filename(id))) {
                data <- read.csv(monitor)
                sulfate_data <- data["sulfate"]
                nitrate_data <- data["nitrate"]                
                good_data <- complete.cases(sulfate_data, nitrate_data)
                monitor_info <- c(data[1, "ID"], sum(good_data))
                complete <- rbind(complete, monitor_info)
        }        
        
        colnames(complete) <- c("id", "nobs")
        complete
}