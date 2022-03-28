export Subsampling_1D
###### define the subsampling function 
using Random
# regular subsample
function Regular_subsample(ns::Int64,p::Int64) 
    # ns: the number of receivers
    #   p=4 --> 75 % subsampling
    #   p=2 --> 50 % subsampling
    selected_locs = collect(1:p:ns);
    return selected_locs
end

# uniform subsampling % white noise subsample
function Uniform_subsample(ns::Int64,p::Int64) 
    # ns: the number of receivers
    # p
    ratio = 1/p;
    Num = Int(round(ns*ratio));
	rand_locs = randperm(ns);
    selected_locs = rand_locs[1:Num];
    # return the subsampling locations for these data
    return sort(selected_locs)
end

#Optimal jittered subsampling %kind of blue noise subsample
function Optimal_Jittered_subsample(ns::Int64, p::Int64)
    # ns: the number of receivers
    # p
    b = collect(1:p)
    ind = []
    for i = 1:Int(round(ns/p))
        push!(ind,rand(b)+(i-1)*p)
    end
    return ind
end

#Blue noise subsampling w/ Farthest Point sampling
#Eldar, Yuval, et al. "The farthest point strategy for progressive image sampling." IEEE Transactions on Image Processing 6.9 (1997): 1305-1315.
function Blue_Noise_subsample(ns::Int64, p::Int64)
    # ns: the number of receivers
    # p
    ind = []
    #step 1: randomly choose one point
    push!(ind, randperm(ns)[1])  
    ratio = 1/p;
    Num = Int(round(ns*ratio));  
    for i = 1:Num-1
        #step 2: randomly choose a set of points
        cand_ind = rand(filter(x->!(x in ind), collect(1:ns)), p); 
        Min_ind = []
        #step 3: calculate the smallest distance between the random set and the existed subpoints
        for j = 1:length(cand_ind)
            push!(Min_ind,minimum(abs.(cand_ind[j] .- ind))); 
        end
        #step 4: find the largest distance among the random set
        Idx = findall(x-> x == maximum(Min_ind), Min_ind);
        #step 5: add one point
        push!(ind, cand_ind[Idx][1])
    end
    return sort(unique(ind))
end

function Subsampling_1D(ns::Int64, p::Int64; SubMethod = "Optimal_Jittered")
    #Regular: Period subsampling
    #Uniform: Uniform random subsampling (White noise subsampling)
    #Optimal_Jittered: Optimal Jittered subsampling
    #Blue_Noise: Blue noise subsampling w/ Farthest Point sampling
    SubMethod == "Regular" && return Regular_subsample(ns,p)
    SubMethod == "Uniform" && return Uniform_subsample(ns,p) 
    SubMethod == "Blue_Noise" && return Blue_Noise_subsample(ns,p)  
    return Optimal_Jittered_subsample(ns, p)
end