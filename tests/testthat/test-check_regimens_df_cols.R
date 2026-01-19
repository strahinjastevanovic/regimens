test_that("Check col names in regimens", {
    expect_true(all(c("regName", "shortString") %in% colnames(regimens)))
})
