
## Simulation Short Course

Welcome!! This repo collects materials for the Introduction to Simulation for
Genomics short course taught at Melbourne Integrative Genomics in June 2024.
Here, you can learn about how controllable, template-driven simulations can be
designed and applied to subtle questions in high-throughput biology.

* Slides: Session [1](https://go.wisc.edu/gfj36r), [2](https://go.wisc.edu/rc776i), [3]
* Recordings: 
* Compiled Solutions: [1](https://connect.doit.wisc.edu/content/40e0e34c-c63f-444b-b5bf-9c696aa4fcf9), [2](https://connect.doit.wisc.edu/content/a8967d1a-2b04-4a23-b040-1f78e375d13d), [3]()

All data used in these notebooks is contained in the `MIGsim` package. For
example, to load the `atlas` dataset, you can run:

```
library(MIGsim)
data(atlas)
```

Source code for for all problems and soluations are in their respective directories.

### Installation

First, please install the package for this workshop.

```{r}
devtools::install_github("krisrs1128/intro-to-simulation/MIGsim")
```

The simulation package we'll be exploring is currently under development, so
isn't listed publicly. For today's experiments, we can install the private
version at this link -- remember to replace the `auth_token` field with the code
shared in the pre-workshop announcement.

```{r}
devtools::install_github("krisrs1128/scDesigner", auth_token = "paste_token_here")
```

### Contact

Please raise an [issue](https://github.com/krisrs1128/intro-to-simulation/issues) or send an [email](mailto:ksankaran@wisc.edu) if you have any questions!