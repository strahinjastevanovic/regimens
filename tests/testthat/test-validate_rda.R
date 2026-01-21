verify_rda_contents <- function(file_path, required_objects) {
  temp_env <- new.env()
  loaded_names <- load(file_path, envir = temp_env)
  
  # Check 1: Do the exact required objects exist?
  expect_equal(sort(loaded_names), sort(required_objects),
               info = "The loaded object names do not exactly match the expected list.")
  
  # Check 2: Check each required object's shape (must be non-scalar)
  for (name in required_objects) {
    obj <- get(name, envir = temp_env)
    
    # Check if the object has dimensions (data frame, matrix, etc.)
    if (!is.null(dim(obj))) {
      expect_true(all(dim(obj) > 1),
                  info = paste0("Object '", name, "' has a dimension of 1 or less. Dimensions: ", paste(dim(obj), collapse = "x")))
    } else {
      # For vectors/lists, check length is > 1
      expect_true(length(obj) > 1,
                  info = paste0("Object '", name, "' is a vector/list of length 1 or 0. Length: ", length(obj)))
    }
  }
}

# Define your user input variable (must be a character vector of names)
user_input_objects <- c("regimens", "drugs", "shortStrings")
rda_file_path <- file.path("data", "regimens.rda") 

test_that("RDA file contains exactly the required non-scalar objects", {
  
  # Use the verification function
  # If any check fails, testthat will stop and report the error
  verify_rda_contents(rda_file_path, user_input_objects)
  
})
