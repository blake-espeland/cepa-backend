module MLKernels

using CUDA

"""
    H!(x)

***in-place*** harmony of input tensor
"""
function harmony!(x)
    x ./= (1.1 .+ x)
    return x
end

"""
    H(p, g)

Helper function to the objective function. Calculates the minimum
harmony of any industry in a given timestep, for all timesteps: 
   
H(p, g), where p and g ∈ R^{ω × n} are of shape ,  
H(p, g) := [∀t | min(harmony(p_{t, :} / g_{t, :}))]  
H(p, g) ∈ R^ω
"""
function H(p, g) 
    # Reducing over dimension 2 to get the minimum harmony of industry
    # i at time t for all times t.
    return reduce(min, harmony!(p ./ g); dims=2)[1, :]
end

"""
    objective(t, p, g)
     - t: [in] timestep
     - p: [in] amount produced
     - g: [in] production goals

Goal: Maximize the minimum per-year harmony.  
i.e. Maximize ∑_t(H(t, p, g)).  
See H(t, p, g).
"""
function objective(p, g)
    return reduce(+, H(p, g); dims=1)
end


"""
    invH!(h)

***in-place*** inverse harmony of harmony tensor
"""
function inv_harmony!(h)
    h .= (1.1 .* h) ./ (1 .- h)
    return h
end

"""
    depreciate(d, s, α, t)
     - d: [in] depraciation matrix (n,n)
     - α: [in] capital accumulation tensor (t,n,n)
     - t: [in] time step
     - s: [in, out] capital stock tensor (t,n,n)

Calculates the capital stock depreciation for year t ***in-place***.  
    s_{t,i,j} = (1 - d_{i,j})s_{t-1,i,j} + α_{t-1,i,j}  
**Note:** time step *t* **must** be at least 2 and in range.
"""
function D!(d, α, t, s)
    s[t] .= (1 .- d) .* s[t-1,:,:] .+ α[t-1,:,:]
    return
end


function cosine_metric(a, b, n)
    return CUBLAS.dot(n, a, b) ./ CUBLAS.nrm2(CUBLAS.dot(n, b, b))
end

export  harmony!
        inv_harmony!      
        objective  
        cosine_metric
        D!


end # end MLKernels