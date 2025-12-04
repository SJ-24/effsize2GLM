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
\details{
The function fits the specified GLM mean structures under the saturated
and null models, then derives phi\_\{x|z\} and R2\_\{x|z\} using the
cell-level weights implied by the family and dispersion.
}
\author{
Paul Rathouz
}
