export Spectral_GapR
using JOLI, SeisJOLI

###### Calculate the spectral gap ratio
using LinearAlgebra, Arpack
function calculate_SGR(Mask)
    #Input: the mask in the reconstructed domain
    #Output: the spectral gap ratio for the input mask
	Z = svds(Mask, nsv = 2);
	
    return Z[1].S[2]/Z[1].S[1], rank(Mask)
end

function Spectral_GapR(nR::Int64,locs::Vector)
    # Inputs: 
    # nR:the number of sources
    # locs: subsampling positions
    # Output: Spectral ratio
    
    # construct mask
    nC = nR;
    Mask = zeros(nC,nR);

    #apply reciprocity 
    Mask[76:225,locs] .= 1; 
    Mask[locs,76:225] .= 1;

    # Transfer data from SR-> MO domain 
    SR = joSRtoCMO(nC,nR,DDT=Float64);
    RecMask = reshape(SR*vec(Mask),nC,2*nR-1);

    #return Spectral ratio
    return calculate_SGR(RecMask)
end