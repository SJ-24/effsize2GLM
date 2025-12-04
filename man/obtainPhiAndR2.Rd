\name{obtainPhiAndR2}
\alias{obtainPhiAndR2}
\title{Compute phi\_\{x|z\} and R2\_\{x|z\} from GLM design inputs}
\description{
Utility to translate solicited cell-level design parameters into
effect size summaries under generalized linear model assumptions.
}
\usage{
obtainPhiAndR2(piCP, muCMs, Zmat, fam = stats::gaussian(), dispersion = 1, XZmat = NULL)
}
\arguments{
\item{piCP}{Numeric vector of cell proportions. Values are internally normalized if they do not sum to one.}
\item{muCMs}{Numeric vector of cell means under the saturated model.}
\item{Zmat}{Design matrix for cell means under the null model.}
\item{fam}{GLM family object providing link, inverse link, variance, and derivative functions. Defaults to \code{gaussian()}.}
\item{dispersion}{Optional scalar dispersion parameter (ignored for distributions such as binomial and Poisson).}
\item{XZmat}{Optional design matrix under the alternative hypothesis. When \code{NULL}, the saturated model is used.}
}
\value{
List containing the supplied inputs, fitted linear predictors, fitted means,
and computed effect size summaries \code{phi.x.z} and \code{R2.x.z}.
}
\examples{
## Load the package
library(effsize2GLM)

## --- EXAMPLE 1 ---
## Three groups, binary outcome; overall group effect
ex1 <- obtainPhiAndR2(
  muCMs = c(.3, .2, .2),             # saturated means: mu2, mu1, mu0
  piCP  = c(.3, .3, .4),             # cell proportions
  Zmat  = matrix(rep(1, 3), nrow = 3), # intercept-only null model
  dispersion = 1,
  fam = quasi(link = "logit", variance = "mu(1-mu)")
)
ex1$phi.x.z; ex1$R2.x.z

## --- EXAMPLE 2 ---
## 2x2 factorial, binary outcome; effect of 2nd factor allowing interaction
ex2 <- obtainPhiAndR2(
  muCMs = c(.4, .2, .3, .2), # mu11, mu10, mu01, mu00
  piCP  = c(.25, .25, .25, .25),
  Zmat  = matrix(c(1,0,
                   1,0,
                   0,1,
                   0,1),
                 nrow = 4, byrow = TRUE),
  dispersion = 1,
  fam = quasi(link = "logit", variance = "mu(1-mu)")
)
ex2$phi.x.z; ex2$R2.x.z

## --- EXAMPLE 2a ---
## 2x2 factorial, main-effects alternative
ex2a <- obtainPhiAndR2(
  muCMs = c(.4, .2, .3, .2), # mu11, mu10, mu01, mu00
  piCP  = c(.25, .25, .25, .25),
  Zmat  = matrix(c(1,0,
                   1,0,
                   0,1,
                   0,1),
                 nrow = 4, byrow = TRUE),
  XZmat = matrix(c(1,0,1,
                   1,0,0,
                   0,1,1,
                   0,1,0),
                 nrow = 4, byrow = TRUE),
  dispersion = 1,
  fam = quasi(link = "logit", variance = "mu(1-mu)")
)
ex2a$phi.x.z; ex2a$R2.x.z

## --- EXAMPLE 3 ---
## Two groups, gamma-type outcome with log link
ex3 <- obtainPhiAndR2(
  muCMs = c((1 - .15) * exp(.25), exp(.25)), # mu1, mu0
  piCP  = c(.67, .33),
  Zmat  = matrix(rep(1, 2), nrow = 2), # intercept-only null model
  dispersion = 0.58^2,
  fam = quasi(link = "log", variance = "mu^2")
)
ex3$phi.x.z; ex3$R2.x.z
}
\details{
The function fits the specified GLM mean structures under the saturated
and null models, then derives phi\_\{x|z\} and R2\_\{x|z\} using the
cell-level weights implied by the family and dispersion.
}
\author{
Paul Rathouz
}
