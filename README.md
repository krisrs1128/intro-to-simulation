# MIG Workshop: Introduction to Simulation for Genomics

Welcome!! This repository collects materials for the simulation short course taught through Melbourne Integrative Genomics in June 2024. Here, you can learn about how controllable, template-driven simulations can be designed and applied to subtle questions in high-throughput biology.

* Slides: Session [1](https://go.wisc.edu/gfj36r), [2](https://go.wisc.edu/rc776i), [3](https://github.com/krisrs1128/intro-to-simulation/)
* Exercise Sheets: [1](https://connect.doit.wisc.edu/content/40e0e34c-c63f-444b-b5bf-9c696aa4fcf9), [2](https://connect.doit.wisc.edu/content/a8967d1a-2b04-4a23-b040-1f78e375d13d), [3](https://github.com/krisrs1128/intro-to-simulation/)

<img  align="center" src="https://krisrs1128.github.io/talks/2024/20240618/figure/gene-gene_dependence.png" width=400/> 

All data used in these notebooks is contained in the `MIGsim` package. For
example, to load the `atlas` dataset, you can run:

```{r}
library(MIGsim)
data(atlas)
```

Source code for the exercise sheets are in the `.Rmd` files in the `solutions`
directory of the repository. 

### Setup

First, please make sure you have a recent version of R (>= 4.0) ready to go. You
can find more materials on setting up and learning R at this previous workshop's
[homepage](https://melbintgen.github.io/intro-to-r/intro_r_biologists.html).

We've defined a small package called `MIGsim` containing all the data and helper
functions that we'll use today. You can install it with:

```{r}
library(devtools)
install_github("krisrs1128/intro-to-simulation/MIGsim")
```

This line assumes you already have the `devtools` package installed. If not,
make sure to run `install.packages('devtools')` first.

The simulation package we'll be exploring is currently under development, so
isn't listed publicly. For our experiments, we can instesad install the private
version at this link -- remember to replace the `auth_token` field with the code
shared in the pre-workshop announcement.

```{r}
install_github("krisrs1128/scDesigner", auth_token = "paste_token_here")
```

Finally, confirm that you can load the packages without any errors.

```{r}
library(MIGsim)
library(scDesigner)
```

If you have any difficulties at all, please raise an
[issue](https://github.com/krisrs1128/intro-to-simulation/issues) or send an
[email](mailto:ksankaran@wisc.edu). We appreciate your patience -- this package
is still quite experimental, and your comments help make it better.
