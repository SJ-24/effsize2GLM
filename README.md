# effsize2GLM

Utility function to compute phi_{x|z} and R^2_{x|z} from solicited design
parameters under GLM assumptions. Includes example scripts mirroring the
original `solicComputation-4.R` demonstrations.

## Install (from source)

```r
# from repository root
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("SJ-24/effsize2GLM")
```

## Usage

```r
library(effsize2GLM)

ex1 <- obtainPhiAndR2(
  muCMs = c(.3, .2, .2),
  piCP  = c(.3, .3, .4),
  Zmat  = matrix(rep(1, 3), nrow = 3),
  fam   = quasi(link = "logit", variance = "mu(1-mu)")
)
print(ex1$phi.x.z)
print(ex1$R2.x.z)
```

For a full walkthrough, open the vignette after installation:

```r
vignette("solicited-computation", package = "effsize2GLM")
```
