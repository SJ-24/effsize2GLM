## Examples of translating solicited study parameters to phi_x|z, R2_x|z, and mean(Y)
## Adapted for the effsize2GLM package.

library(effsize2GLM)

## Function signature:
## obtainPhiAndR2(piCP, muCMs, Zmat, fam = gaussian(), dispersion = 1, XZmat = NULL)

## --- EXAMPLE 1 ---
## Three groups, binary outcome, logistic regression
## Test for overall group effect
ex1 <- obtainPhiAndR2(
  muCMs = c(.3, .2, .2),            # cell means in saturated model: mu2, mu1, mu0
  piCP = c(.3, .3, .4),             # cell relative frequencies (proportions)
  Zmat = matrix(rep(1, 3), nrow = 3), # intercept-only model
  dispersion = 1,
  fam = quasi(link = "logit", variance = "mu(1-mu)")
)
print(ex1)

## --- EXAMPLE 2 ---
## Two-by-two factorial design, binary outcome, logistic regression
## Test for effect of 2nd factor, allowing for interaction with first
ex2 <- obtainPhiAndR2(
  muCMs = c(.4, .2, .3, .2), # means: mu11, mu10, mu01, mu00
  piCP = c(.25, .25, .25, .25),
  Zmat = matrix(c(1, 0,
                  1, 0,
                  0, 1,
                  0, 1),
                nrow = 4, byrow = TRUE),
  dispersion = 1,
  fam = quasi(link = "logit", variance = "mu(1-mu)")
)
print(ex2)

## --- EXAMPLE 2a ---
## Similar, but where HA only has main effects, so need to specify XZmat
ex2a <- obtainPhiAndR2(
  muCMs = c(.4, .2, .3, .2), # means: mu11, mu10, mu01, mu00
  piCP = c(.25, .25, .25, .25),
  Zmat = matrix(c(1, 0,
                  1, 0,
                  0, 1,
                  0, 1),
                nrow = 4, byrow = TRUE),
  XZmat = matrix(c(1, 0, 1,
                   1, 0, 0,
                   0, 1, 1,
                   0, 1, 0),
                 nrow = 4, byrow = TRUE),
  dispersion = 1,
  fam = quasi(link = "logit", variance = "mu(1-mu)")
)
print(ex2a)

## --- EXAMPLE 3 ---
## Two groups, gamma-type outcome, log link
## Test for overall group effect
ex3 <- obtainPhiAndR2(
  muCMs = c((1 - .15) * exp(.25), exp(.25)), # cell means in saturated model: mu1, mu0
  piCP = c(.67, .33),                       # cell relative frequencies (proportions)
  Zmat = matrix(rep(1, 2), nrow = 2),        # intercept-only model
  dispersion = 0.58^2,                       # variance parameter
  fam = quasi(link = "log", variance = "mu^2")
)
print(ex3)
