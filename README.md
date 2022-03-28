# A simulation-free seismic survey design by maximizing the spectral gap

This repository will contain codes for generating proposed subsampling results in Zhang, Y., Louboutin, M., Siahkoohi, A., Yin, Z., Kumar, R., and Herrmann, F.J., A simulation-free seismic survey design by maximizing the spectral gap.

# MinimizeSR

This code base is using the Julia Language and [DrWatson](https://juliadynamics.github.io/DrWatson.jl/stable/)
to make a reproducible scientific project named
> MinimizeSR

It is authored by Yijun.

To (locally) reproduce this project, do the following:

0. Download this code base. Notice that raw data are typically not included in the
   git-history and may need to be downloaded independently.
1. Open a Julia console and do:
   ```
   julia> using Pkg
   julia> Pkg.add("DrWatson") # install globally, for using `quickactivate`
   julia> Pkg.activate("path/to/this/project")
   julia> Pkg.instantiate()
   ```

This will install all necessary packages for you to be able to run the scripts and
everything should work out of the box, including correctly finding local paths.

Or, you could setup the environment with following dependencies:

## Dependencies

The minimum requirements for theis software, and tested version, are Python 3.x and Julia 1.4.0. This software requires the following dependencies to be installed:

-[JOLI](https://github.com/slimgroup/JOLI.jl),Julia framework for constructing matrix-free linear operators with explicit domain/range type control and applying them in basic algebraic matrix-vector operations.\\
-[SeisJOLI](https://github.com/slimgroup/SeisJOLI.jl). Collection of SLIM in-house operators based on JOLI package.\\
-[Arpack](https://github.com/JuliaLinearAlgebra/Arpack.jl). Julia wrapper for the arpack library designed to solve large scale eigenvalue problems.\\
-[LinearAlgebra](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/). Julia provides native implementations of many common and useful linear algebra operations which can be loaded with using LinearAlgebra.\\
-[Random](https://github.com/JuliaLang/julia/tree/master/stdlib/Random/). Julia provides extended support for random number generation.

First, you need install the following packages from the stable master branch:
```
using Pkg; Pkg.add(PackageSpec(url="https://github.com/slimgroup/JOLI.jl"))
using Pkg; Pkg.add(PackageSpec(url="https://github.com/slimgroup/SeisJOLI.jl"))
```

then install dependencies:
```
Pkg.add("Arpack")
Pkg.add("LinearAlgebra"), ...
```

## Software

This directory contains codes to run the corresponding experiments.You can run the 'Main_optimization.jl' to reproduce the experiments, also you can modify the files to change the settings and design your own experiment.
 
 ```
 Main_optimization.jl #The main function of our experiments to generate subsampled positions to get a subsampling mask. 
 Opt_SpectralRatio_SA.jl #The subfunction that including the simulated annealing algorithm and selecting neighboring states.
 NLfunForward_test1.jl #The subfunction to create mask and get the spectral ratio.
 ```

This directory only includes the proposed simulation-free method to obtain the subsampling mask and the corresponding wavefield reconstruction can be found [here](https://github.com/slimgroup/Software.SEG2020/tree/master/zhang2020SEGwrw).

## Citation

If you find this software useful in your research, we would appreciate it if you cite:

```bibtex
@unpublished {zhang2022SEGass,
	title = {A simulation-free seismic survey design by maximizing the spectral gap},
	year = {2022},
	note = {Submitted},
	month = {03},
	abstract = {Due to the tremendous cost of seismic data acquisition, methods have been developed to reduce the amount of data acquired by designing optimal missing trace reconstruction algorithms. These technologies are designed to record as little data as possible in the field, while providing accurate wavefield reconstruction in the areas of the survey that are not recorded. This is achieved by designing randomized subsampling masks that allow for accurate wavefield reconstruction via matrix completion methods. Motivated by these recent results, we propose a simulation-free seismic survey design that aims at improving the quality of a given randomized subsampling using a simulated annealing algorithm that iteratively increases the spectral gap of the subsampling mask, a property recently linked to the quality of the reconstruction. We demonstrate that our proposed method improves the data reconstruction quality for a fixed subsampling rate on a realistic synthetic dataset.},
	keywords = {Acquisition, matrix factorization, spectral gap, survey design, wavefield reconstruction},
	url = {https://slim.gatech.edu/Publications/Public/Submitted/2022/zhang2022SEGass/Yijun2022SEGass.html},
	author = {Yijun Zhang and Mathias Louboutin and Ali Siahkoohi and Ziyi Yin and Rajiv Kumar and Felix J. Herrmann}
}
```

## Contact

For questions or issue, please contact yzhang3198@gatech.edu.