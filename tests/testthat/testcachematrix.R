source("../../cachematrix.R")

test_that("makeCacheMatrix creates object with expected accessors", {
    m <- makeCacheMatrix()
    expect_named(m, c('get', 'set', 'getinverse', 'setinverse'), ignore.order = TRUE)
    expect_is(m$get, 'function')
    expect_is(m$set, 'function')
    expect_is(m$getinverse, 'function')
    expect_is(m$setinverse, 'function')
})
