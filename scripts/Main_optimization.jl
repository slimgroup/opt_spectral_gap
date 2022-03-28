using DrWatson
@quickactivate "MinimizeSR"

include("SubFunction/Subsampling_1D.jl")
include("SubFunction/Opt_SpectralRatio_SA.jl")

ns = 300;  # number of sources
p = 5;     # subsampling factor

# initial by using optimally-jittered subsampling
Ind1 = Subsampling_1D(ns,p); 

r = 0.2;   #To be relocated ratio of the sources
Ind3, Initial_SR, Final_SR = Opt_SpectralRatio_SA(ns, Ind1, r, p); # Spectral ratio Optimization

println(string("Initial_SR ="), Initial_SR)
println(string("Final_SR ="), Final_SR)