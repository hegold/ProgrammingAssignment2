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
