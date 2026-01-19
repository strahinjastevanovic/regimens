
#' Load the default valid drugs dataframe
#' @param absolute Optional. Absolute path to a custom `.rda` file containing the `validdrugs` dataset. If not provided, the function loads from the `ARTEMIS` package.
#' @export
loadDrugs <- function(absolute = NULL) {
   if (!is.null(absolute)) {
    if (!file.exists(absolute)) {
      stop(paste("Error: The specified file", absolute, "was not found."))
    }
    
    temp_env <- new.env()
    load(absolute, envir = temp_env)
    
    # Ensure `validdrugs` exists after loading
    if (!exists("validdrugs", envir = temp_env)) {
      stop("Error: Loaded file does not contain a dataset named 'validdrugs'.")
    }
    
    validdrugs <- temp_env$validdrugs
  } else {
    data("validdrugs", package = "ARTEMIS")
    
    if (!exists("validdrugs")) {
      stop("Error: Failed to load 'validdrugs' from ARTEMIS package.")
    }
  }
  
  return(validdrugs)
}

#' Load regimens for a given condition
#' @param condition A string indicating which regimen set to load
#' @param absolute Path to system regimen to use as reference
#' Presently, the only condition fully mapped are lungCancer and multiple myeloma
#' Edit: all conditions supported matching a name OR providing a mapping, see example
#' @param mapping A named list of user provids condition to maping
#' @export
loadRegimens <- function(condition = "all", absolute = NULL, 
                         mapping = list("lungCancer" = c("Thoraic Oncology", "Thoraic Oncology"),
                                        "multipleMyeloma" = c("Multiple Myeloma"))) {
  
  # Load from absolute path if provided
  if (!is.null(absolute)) {
    if (!file.exists(absolute)) {
      stop(paste("Error: The specified file", absolute, "was not found."))
    }
    
    regimens_env <- new.env()
    load(absolute, envir = regimens_env)
    
    # Ensure `regimens` exists after loading
    if (!exists("regimens", envir = regimens_env)) {
      stop("Error: Loaded file does not contain a dataset named 'regimens'.")
    }
    
    regimens <- regimens_env$regimens
  } else {
    # Load from ARTEMIS package if no absolute path is given
    data("regimens", package = "ARTEMIS")
    
    if (!exists("regimens")) {
      stop("Error: Failed to load 'regimens' from ARTEMIS package.")
    }
  }
  
  # Handle mapping fallback: if condition is missing, use condition itself
  mapped_conditions <- mapping[[condition]]
  if (is.null(mapped_conditions)) {
    mapped_conditions <- condition
  }
  
  # Filter based on metaCondition
  return(regimens[regimens$metaCondition %in% mapped_conditions, ])
}



#' Display a list of valid conditions
#' @export
validConditions <- function(){
  message("Conditions currently implemented:")
  message("lungCancer")
  message("multipleMyeloma")
}

#' Load the default regimen group dataframe
#' @param absolute Optional. Absolute path to a custom `.rda` file containing the `validdrugs` dataset. If not provided, the function loads from the `ARTEMIS` package.
#' @export
loadGroups <- function(absolute=NULL) {
   if (!is.null(absolute)) {
    if (!file.exists(absolute)) {
      stop(paste("Error: The specified file", absolute, "was not found."))
    }
    
    temp_env <- new.env()
    load(absolute, envir = temp_env)
    
    # Ensure `regimengroups` exists after loading
    if (!exists("regimengroups", envir = temp_env)) {
      stop("Error: Loaded file does not contain a dataset named 'regimengroups'.")
    }
    
    regimengroups <- temp_env$regimengroups
  } else {
    data("regimengroups", package = "ARTEMIS")
    
    if (!exists("regimengroups")) {
      stop("Error: Failed to load 'regimengroups' from ARTEMIS package.")
    }
  }
  
  return(regimengroups)
}
