rankall <- function(outcome, num = "best") {
        # Read outcome data
        outcome_csv <- read.csv("outcome-of-care-measures.csv", 
                                colClasses = "character")
        
        # Check that state and outcome are valid
        if (outcome == "heart attack") {
                outcome_col <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
        } else if (outcome == "heart failure") {
                outcome_col <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
        } else if (outcome == "pneumonia") {
                outcome_col <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
        } else {
                stop("invalid outcome")
        }
        
        # Convert characters to numeric
        outcome_csv[, outcome_col] <- as.numeric(outcome_csv[, outcome_col])
        
        # Split outcome_csv by states
        outcome_states <- split(outcome_csv, outcome_csv$State)       
        
        process_state <- function(state) {  
                state <- subset(state, !is.na(state[outcome_col]))
                
                # Convert num argument
                if (num == "best") { 
                        rank <- 1
                } else if (num == "worst") {
                        rank <- length(state[, 1])
                } else if (num > length(state[, 1])) {
                        return(NA)
                } else {
                        rank <- num
                }                  
                
                state[order(state[, outcome_col], state["Hospital.Name"]), ]["Hospital.Name"][rank, 1]
        }
        
        processed <- lapply(outcome_states, function(x) process_state(x))
        processed_matrix <- cbind(processed, names(processed), deparse.level = 0)
        colnames(processed_matrix) <- c("hospital", "state")
        as.data.frame(processed_matrix)
}