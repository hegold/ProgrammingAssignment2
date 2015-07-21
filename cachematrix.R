## A pair of functions implementing a matrix which caches its inverse to avoid costly recalculation.

## Creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
    set <- function(y) { x <<- y }
    get <- function() { x }
    setinverse <- function(inverse) {}
    getinverse <- function() {}

    list(set = set, get = get, getinverse = getinverse, setinverse = setinverse)
}


## Computes the inverse of the special "matrix" returned by makeCacheMatrix.
## If the inverse has already been calculated (and the matrix has not changed),
## then retrieves the inverse from the cache.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
}
