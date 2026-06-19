# Reproducing analysis of Morelli et al. 2026
# Melina Leite
# june 2026

# this script was created to run in a container with the R version 4.3.3, and 
# the following package versions

## Packages and versions --------------

#install.packages("remotes")
#remotes::install_version("BH", version = "1.81.0-1")
#remotes::install_version("brms", version = "2.16.3")
library(brms) # version 2.16.3 
#library(readxl)
#library(tidyverse)
#library(broom.mixed)
#library(patchwork)
#library(performance)
#library(DHARMa) # v0.4.7
library(ape)
#remotes::install_version("phangorn", version = "2.8.1")
library(phangorn) # version 2.8.1
#remotes::install_version("MCMCglmm", version = "2.32")
library(MCMCglmm) # version 2.32


# loading already cleaned data data.s + phylo.cov
load("data/data.s_clean.Rdata")

# model
mod.orig_container <- brm(FID ~ SD + Flock + Sex + gender + Built + Grass +
                  Bare.soil + Water + Tree + Bush + (1|City) + (1|Species) +
                  (1|gr(Phylo, cov = A)),  # phylo matrix
                data = data.s, 
                data2 = list(A = phylo.cov2),
                family = gaussian(link="log"),
                cores = 2, chains = 2,
                warmup = 1000, iter = 2000, 
                control = list(adapt_delta =0.99, max_treedepth=15))

# saving model
save(mod.orig_container, file="models/mod.orig_container.Rdata")