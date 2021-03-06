## A pair of functions implementing a matrix which caches its inverse to avoid costly recalculation.
## See tests at: ./tests/testthat/testcachematrix.R

## Creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
    localInverse <- NULL

    set <- function(y) {
        x <<- y
        localInverse <<- NULL
    }
    get <- function() { x }
    setinverse <- function(inverse) { localInverse <<- inverse }
    getinverse <- function() { localInverse }

    list(set = set, get = get, getinverse = getinverse, setinverse = setinverse)
}


## Computes the inverse of the special "matrix" returned by makeCacheMatrix.
## If the inverse has already been calculated (and the matrix has not changed),
## then retrieves the inverse from the cache.
cacheSolve <- function(x, ...) {
    cached <- x$getinverse()
    if(!is.null(cached)) {
        return(cached)
    }
    data <- x$get()
    inverse <- solve(data, ...)
    x$setinverse(inverse)
    inverse
}
