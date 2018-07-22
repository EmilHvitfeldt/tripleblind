strip <- function(x, ...) {
  UseMethod("strip", x)
}

strip.factor <- function(x, ...) {
  org_levels <- levels(x)

  new_levels <- sample(paste0("level", seq_len(length(org_levels))))
  levels(x) <- new_levels
  list(data = x,
       conversion = list(old = org_levels,
                         new = new_levels))
}

strip.logical <- function(x, ...) {
  new_levels <- sample(c("logical1", "logical2"))

  list(data = ifelse(x, new_levels[1], new_levels[2]),
       conversion = list(old = c(TRUE, FALSE),
                         new = new_levels))
}

strip.default <- function(x, ...) {
  list(data = x,
       conversion = NA)
}
