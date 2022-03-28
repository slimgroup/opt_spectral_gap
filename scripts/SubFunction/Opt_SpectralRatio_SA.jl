export Opt_SpectralRatio_SA
include("Spectral_GapR.jl")
using Statistics,  Random, Distributions
# return SG Ratio

###### neighbor perturb
function sample_neighbour(nR::Int64, rec::Vector, r::Float64, p::Int64)
    #rec: the subsampled locations
    #r: the ratio of subsampled points to be perturbed
    #p: subsampling factor

    #the number of all 
    n = length(rec);

    #random choose the perturb locations
    Num = Int(round(length(rec)*r));
    A = sortperm(randn(length(rec)));
    Perturb_rec = rec[A[1:Num]];

    #constructed perturbed area based on selected locations and neightbor range
    test_range = Int(floor((Perturb_rec[1] -1) / p)) 
    Perturb_range = Array(collect(test_range*p+1:1:(test_range+1)*p)')
    for i = 2: Num
    	test_range = Int(floor((Perturb_rec[i] -1) / p)) 
    	Perturb_range = vcat(Perturb_range, Array(collect(test_range*p+1:1:(test_range+1)*p)'))
    end

    # range constraint especially for the edge
    Perturb_range[findall(x-> x.<=0, Perturb_range)] .= 1
    Perturb_range[findall(x-> x.>=nR, Perturb_range)] .= nR

    # replace range and remove repeated locations
    new_rec = copy(rec);
    new_rec[A[1:Num]] .= Perturb_range[CartesianIndex.(Tuple.(eachrow(hcat(1:Num,rand(1:5,Num)))))];

    return sort(unique(new_rec))
end


function Opt_SpectralRatio_SA(nR::Int64, locs1::Vector, pprob::Int64, r::Float64)
    #Input: nR: number of sources
    #       locs1: given locations (Uniform random or optimal jittered)
    #       p: subsampling factor
    #       r: the percentage of data to be removed and here we set r=20%
    #Output: best_locs: the subsampled locations with smaller spectral ratio
    #        best_sgr[1]: the initial SG ratio
    #        best_sgr[end]: the output SG ratio
	
	best_locs = locs1; 

	# calculate the evaluation (Spectral ratio)
	cur_sgr,_= Spectral_GapR(nR, locs1)
	best_sgr = [cur_sgr];

    # set the probability used to control the moves
	function prob(n, res)
	    return exp(-res/(95f-2 * (70f-2)^n))
	end

	max_itr = 4000 #iteration numbers
	prob_hist = [];
	for itr in range(1, max_itr, step=1)
        # sample neighbour to get the new location and calculate the SG ratio
	    locs =  sample_neighbour(nR, best_locs, r, pprob);
	    cur_sgr, _ = Spectral_GapR(nR, locs);
    
        # if better, move to the new locations
        if cur_sgr < best_sgr[end] 
            push!(best_sgr, cur_sgr)
            push!(prob_hist, 1)
            best_locs = locs
        else #else use the probability to decide move or not
            p = prob(itr, cur_sgr-best_sgr[end]) 
            if rand() < p
                best_locs = locs;
                push!(best_sgr, cur_sgr)  
            end
	    end
	end

    # return the new locations, the input SG ratio and the output SG ratio
	return best_locs, best_sgr[1], best_sgr[end];
end