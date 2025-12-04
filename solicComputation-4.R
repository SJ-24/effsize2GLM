## Time-stamp: <2025-04-01 12:17:40 paulrathouz>
## Power / Sample Size Project
##    Examples of translating solicited study parameters to
##    phi_x|z, R2_X|z, and mean(Y)
## P. Rathouz

## Preliminaries
## Install with: devtools::install_local(".")
library(effsize2GLM)

##---EXAMPLE 1---##
## Three groups, binary outcome, logistic regression
## Test for overall group effect
## Solicitated parameters evident in function call
ex1 <- obtainPhiAndR2(
    muCMs=c(.3,.2,.2),            # cell means in _saturated model_: mu2, mu1, mu0
    piCP =c(.3,.3,.4),            # cell rel frequencies (proportions)
    Zmat=matrix(rep(1,3),nrow=3), # this is an intercept-only model
    dispersion=1,
    ## Use the quasi-binomial family, which contains
    ## functions linkfun(), linkinv(), variance(), mu.eta()=(d mu/d eta)(eta)
    fam=quasi(link="logit",variance="mu(1-mu)")  # produces a list with
                                        # functions in it
)
ex1

##---EXAMPLE 2---##
## Two-by-two factorial design, binary outcome, logistic regression
## Test for effect of 2nd factor, allowing for interaction with first
## Solicitated parameters evident in function call
ex2 <- obtainPhiAndR2(
    muCMs=c(.4,.2,.3,.2),     # means: mu11, mu10, mu01, mu00
    piCP =c(.25,.25,.25,.25),
    Zmat=matrix(c(1,0,        # this is a model with only Z as predictor
                  1,0,
                  0,1,
                  0,1),
                nrow=4,byrow=TRUE),
    dispersion=1,
    ## Use the quasi-binomial family, which contains
    ## functions linkfun(), linkinv(), variance(), mu.eta()=(d mu/d eta)(eta)
    fam=quasi(link="logit",variance="mu(1-mu)")  # produces a list with
                                        # functions in it
)
ex2

##---EXAMPLE 2a--##
## Similar, but where HA only has main effects, so need to specify XZmat
ex2a <- obtainPhiAndR2(
    muCMs=c(.4,.2,.3,.2),     # means: mu11, mu10, mu01, mu00
    piCP =c(.25,.25,.25,.25),
    Zmat=matrix(c(1,0,        # this is a model with only Z as predictor
                  1,0,
                  0,1,
                  0,1),
                nrow=4,byrow=TRUE),
    XZmat=matrix(c(1,0,1,   # this is a model with only main effects
                   1,0,0,
                   0,1,1,
                   0,1,0),
                 nrow=4,byrow=TRUE),
    dispersion=1,
    ## Use the quasi-binomial family, which contains
    ## functions linkfun(), linkinv(), variance(), mu.eta()=(d mu/d eta)(eta)
    fam=quasi(link="logit",variance="mu(1-mu)")  # produces a list with
                                        # functions in it
)
ex2a

##---EXAMPLE 3---##
## Three groups, binary outcome, logistic regression
## Test for overall group effect
## Solicitated parameters evident in function call
ex3 <- obtainPhiAndR2(
    muCMs=c((1-.15)*exp(.25),exp(.25)),  # cell means in _saturated model_:
                                        # mu1, mu0
    piCP=c(.67,.33),      # cell rel frequencies (proportions)
    Zmat=matrix(rep(1,2),nrow=2), # this is an intercept-only model
    dispersion=0.58^2,  # need to square to put on variance, not SD, dispersion
    ## Use the quasi-gamma family, which contains
    ## functions linkfun(), linkinv(), variance(), mu.eta()=(d mu/d eta)(eta)
    fam=quasi(link="log",variance="mu^2")  # produces a list with functions
)                                          # in it
ex3

# q("no") 
