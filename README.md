
## Simulation Short Course

This repo includes materials for the Introduction to Simulation for Genomics
short course taught at Melbourne Integrative Genomics in June 2024.

All data used in these notebooks is contained in the `MIGsim` package. For
example, to load the `atlas` dataset, you can run:

```
library(MIGsim)
data(atlas)
```

Problems and solutions to all the exercises are in their respective directories.

### Installation

First, please install the package for this workshop.

```{r}
devtools::install_github("krisrs1128/intro-to-simulation/MIGsim")
```

The simulation package we'll be exploring is currently under development, so
isn't listed publicly. For the experiments we'll use today, we can install the
private version at this link -- remember to replace the `auth_token` field with
the code shared in the pre-workshop announcement.

```{r}
devtools::install_github("krisrs1128/scDesigner", auth_token = "paste_token_here")
```

### Materials

Slides:
Recordings:
