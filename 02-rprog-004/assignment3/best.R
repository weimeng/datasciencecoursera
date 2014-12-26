best <- function(state, outcome) {
        # Read outcome data
        outcome_csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
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
        
        if (!(state %in% outcome_csv[, "State"])) {
                stop("invalid state")
        }
        
        # Convert characters to numeric
        outcome_csv[, outcome_col] <- as.numeric(outcome_csv[, outcome_col])
        
        # Split outcome_csv by states
        outcome_state <- subset(outcome_csv, State == state)
        
        # Return hospital name in the state with lowest 30-day death rate
        outcome_state[order(outcome_state[, outcome_col], outcome_state["Hospital.Name"]), ]["Hospital.Name"][1, 1]
}