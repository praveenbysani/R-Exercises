#custom summary for regression tasks

# create custom logloss summary function for use with caret cross validation
LogLossSummary <- function(data, lev = NULL, model = NULL) {
  
  # this is slightly different from function above as above function leads to errors
  LogLoss <- function(actual, pred, eps = 1e-15) {
    stopifnot(all(dim(actual) == dim(pred)))
    pred[pred < eps] <- eps
    pred[pred > 1 - eps] <- 1 - eps
    -sum(actual * log(pred)) / nrow(pred)
  }
  if (is.character(data$obs)) data$obs <- factor(data$obs, levels = lev)
  pred <- data[, 'pred']
  obs <- data[, 'obs']
  is.na <- is.na(pred)
  pred <- pred[!is.na]
  obs <- obs[!is.na]
  data <- data[!is.na, ]
  class <- levels(obs)
  
  if (length(obs) + length(pred) == 0) {
    out <- rep(NA, 2)
  } else {
    probs <- data[, class]
    actual <- model.matrix(~ obs - 1)
    out <- LogLoss(actual = actual, pred = probs)
  }
  names(out) <- c('LogLoss')
  
  if (any(is.nan(out))) out[is.nan(out)] <- NA
  
  out
}
