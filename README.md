# MIG Workshop: Introduction to Simulation for Genomics
<img align="right" width=250 src="assets/logo.png"/>

Welcome!! This repository collects materials for the simulation short course taught through Melbourne Integrative Genomics in June 2024. Here, you can learn about how controllable, template-driven simulations can be designed and applied to subtle questions in high-throughput biology.


* Slides: Session [1](https://go.wisc.edu/gfj36r), [2](https://go.wisc.edu/rc776i), [3](https://go.wisc.edu/54tmr9)
* Exercise Sheets: [1](https://go.wisc.edu/v986n5), [2](https://go.wisc.edu/441a60), [3](https://connect.doit.wisc.edu/content/c7d21c7d-0b34-494a-8012-147af02c5be1/)
* Recordings: Session [1](https://uwmadison.box.com/s/qo4vc9v31obw5gfrqhd8ds2l0hkt3wza), [2](https://uwmadison.box.com/s/bdqrcapmizg5jaueuax8cm4suq0beqa0), [3]()

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

Confirm that you can load the packages without any errors.

```{r}
library(MIGsim)
```

`MIGsim` should install the `scDesigner` package in the background. This is a
simulation package that is still under development and so is not listed in a
public package repository. Check that you can also load this library.

```{r}
library(scDesigner)
```

If you have any difficulties at all, please raise an
[issue](https://github.com/krisrs1128/intro-to-simulation/issues) or send an
[email](mailto:ksankaran@wisc.edu). We appreciate your patience -- this package
is still quite experimental, and your comments help make it better.
