source("../../cachematrix.R")

context("makeCacheMatrix")

makeTestMatrix <- function() { matrix(runif(100), 10, 10) }

test_that("matrix object has expected accessors", {
    m <- makeCacheMatrix()

    expect_named(m, c('get', 'set', 'getinverse', 'setinverse'), ignore.order = TRUE)
    expect_is(m$get, 'function')
    expect_is(m$set, 'function')
    expect_is(m$getinverse, 'function')
    expect_is(m$setinverse, 'function')
})

test_that("matrix object's get returns original matrix", {
    expected <- makeTestMatrix()
    m <- makeCacheMatrix(expected)

    result = m$get()

    expect_identical(result, expected)
})

test_that("matrix object's get returns new matrix after set", {
    m <- makeCacheMatrix(makeTestMatrix())
    expected <- makeTestMatrix()
    m$set(expected)

    result = m$get()

    expect_identical(result, expected)
})

test_that("matrix object's getinverse initially returns null", {
    m <- makeCacheMatrix(makeTestMatrix())

    result = m$getinverse()

    expect_null(result)
})

test_that("matrix object's getinverse returns matrix set by setinverse", {
    m <- makeCacheMatrix(makeTestMatrix())
    expected <- makeTestMatrix()
    m$setinverse(expected)

    result = m$getinverse()

    expect_identical(result, expected)
})

test_that("matrix object's getinverse returns null after new matrix set by set", {
    m <- makeCacheMatrix(makeTestMatrix())
    m$setinverse(makeTestMatrix())
    m$set(makeTestMatrix())

    result = m$getinverse()

    expect_null(result)
})

context("cacheSolve")

test_that("it returns inverse of matrix", {
    original <- makeTestMatrix()
    m <- makeCacheMatrix(original)

    result <- cacheSolve(m)

    expect_identical(result, solve(original))
})

test_that("it is at least twice as fast compared to the uncached version", {
    iterations   <- 1:10000
    rawMatrix    <- makeTestMatrix()
    cachedMatrix <- makeCacheMatrix(rawMatrix)

    rawTime    <- system.time(lapply(iterations, function(x) solve(rawMatrix)))
    cachedTime <- system.time(lapply(iterations, function(x) cacheSolve(cachedMatrix)))

    timeFraction <- cachedTime['elapsed'] / rawTime['elapsed']

    expect_less_than(timeFraction, 0.5)
})
