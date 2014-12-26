## Matrix inversion is usually a costly computation and there may be some
## benefit to caching the inverse of a matrix rather than computing it
## repeatedly.
##
## This file contains a pair of functions that can be used together to assist in
## computing and caching a matrix and its inverse for further manipulation.

makeCacheMatrix <- function(x = matrix()) {
        ## Creates a special "matrix" object that can also cache its inverse.
        ##
        ## Args:
        ##   x: A matrix, assumed to be invertible.
        ##
        ## Returns:
        ##   A special "matrix" object, actually a list of functions:
        ##     $set: Stores a new matrix, sets cached inversed matrix to NULL
        ##     $get: Retrieves the stored matrix
        ##     $setsolve: Receives and stores an inversed matrix
        ##     $getsolve: Retrieves the stored inversed matrix

        s <- NULL
        set <- function(y) {
                x <<- y
                s <<- NULL
        }
        get <- function() x
        setsolve <- function(inverse) s <<- inverse
        getsolve <- function() s
        list(set = set, get = get,
             setsolve = setsolve,
             getsolve = getsolve)
}


cacheSolve <- function(x, ...) {
        ## Computes the inverse of the "matrix" returned by makeCacheMatrix()
        ##
        ## This function computes the inverse of the "matrix" object returned by
        ## the makeCacheMatrix function. It first attempts to retrieve and
        ## return a cached inversed matrix in the object. If no such cached
        ## inversed matrix exists, the function then computes the inverse matrix
        ## and stores it into the "matrix" object and returns the inversed
        ## matrix.
        ##
        ## Args:
        ##   x:   A list object as returned by makeCacheMatrix()
        ##   ...: Further arguments to be passed to solve the matrix
        ##
        ## Returns:
        ##   The inverse of the matrix supplied in the argument 'x'

        s <- x$getsolve()
        if(!is.null(s)) {
                message("getting cached data")
                return(s)
        }
        data <- x$get()
        s <- solve(data, ...)
        x$setsolve(s)
        s
}
