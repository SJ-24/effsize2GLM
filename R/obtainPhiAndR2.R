##' Compute φ(x|z) and R²(x|z) from GLM design inputs.
##'
##' @param piCP Numeric vector of cell proportions. If values do not sum to 1,
##'   they are internally normalized.
##' @param muCMs Numeric vector of cell means under the saturated model.
##' @param Zmat Design matrix for cell means under the null model.
##' @param fam GLM family object providing `linkfun`, `linkinv`, `variance`,
##'   and `mu.eta`. Defaults to `gaussian`.
##' @param dispersion Optional scalar dispersion parameter (ignored for
##'   distributions such as binomial and Poisson).
##' @param XZmat Optional design matrix under the alternative hypothesis. When
##'   `NULL`, the saturated model is used.
##'
##' @return A list containing the supplied inputs, linear predictors, fitted
##'   means, and computed effect size summaries `phi.x.z` and `R2.x.z`.
##' @export
obtainPhiAndR2 <- function(piCP, muCMs, Zmat,
                           fam = stats::gaussian(),
                           dispersion = 1,
                           XZmat = NULL) {
  ## Normalize proportions if needed.
  if (abs(sum(piCP) - 1) > .Machine$double.eps^0.5) {
    piCP <- piCP / sum(piCP)
  }

  ## When XZmat is NULL, use saturated model.
  if (is.null(XZmat)) {
    XZmat <- diag(length(muCMs))
    muCMxz <- muCMs
  } else {
    muCMxz <- glm.fit(y = muCMs, x = XZmat, family = fam,
                      weights = piCP)$fitted.values
  }

  ## Linear predictor and weights.
  etaCMxz <- fam$linkfun(muCMxz)
  wCMxz <- (1 / fam$variance(muCMxz)) * fam$mu.eta(etaCMxz)^2

  ## Fit eta_z for cells.
  etaCMz <- lm.wfit(y = etaCMxz, x = Zmat, w = wCMxz * piCP)$fitted.values

  ## Cell weight variance.
  varD <- diag(piCP) - outer(piCP, piCP)

  ## φ(x|z) calculation.
  varEtaXZ <- t(etaCMxz - etaCMz) %*% varD %*% (etaCMxz - etaCMz)
  phi.x.z <- 2 * sqrt(varEtaXZ)
  EY <- muCMs %*% piCP
  w1 <- (1 / dispersion) * (1 / fam$variance(EY)) * fam$mu.eta(fam$linkfun(EY))^2
  f2.phi <- w1 * phi.x.z^2 / 4

  ## R²(x|z) calculation.
  muCMxz <- fam$linkinv(etaCMxz)
  muCMz <- fam$linkinv(etaCMz)
  vaCMxz <- fam$variance(muCMxz) * dispersion
  squaredDev <- (muCMxz - muCMz)^2 / vaCMxz
  f2.R2 <- squaredDev %*% piCP
  R2.x.z <- f2.R2 / (f2.R2 + 1)

  list(
    muCMs = muCMs, piCP = piCP,
    etaCMxz = etaCMxz, etaCMz = etaCMz,
    muCMxz = muCMxz, muCMz = muCMz,
    phi.x.z = phi.x.z, EY = EY, w1 = w1, f2.phi = f2.phi,
    R2.x.z = R2.x.z, f2.R2 = f2.R2
  )
}
