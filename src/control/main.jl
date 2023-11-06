"""
    The primary goals of this project are to assist economic planners in better
    projecting the impacts of a plan on the economy, and help planners develop
    better plans in the first place. All things considered — lack of technology,
    lack of modern data science and statistics, etc. — the Soviet Union did a great
    job of planning their economy.

    There is plenty of information out there on the internet about the amazing
    benefits and productivity gains of a planned economy. This is just a relatively
    simple example case of how realtively attainable an advanced planning system
    can be.

    Given the following information:
        - Capital Constraints
        - Per-industry inputs and outputs
        - Capital stock
        - Capital stock accumulation
        - Productive consumption

    we can use linear programming solvers to come up with an optimal* planning solution

    * optimal given the constraints and resources available.

    Authors: Blake Espeland
    2023 - MIT Lisense
"""

using .MLKernels
using .MLTech
include("meta.jl")

using BenchmarkTools


function main()
    if !CUDA.functional() || !CUDA.has_cuda_gpu()
        println("System incompatible with CUDA")
        return
    end

    CUDA.allowscalar(false) # disallowing scalar indexing of CuArray's

    n::Int32 = 100 # number of resources
    ω::Int8 = 3 # plan horizon

    t::Int8 = 1 # timestep

    # ------ Auxillary Tensors ------
    # Capital Constraints
    capital_constraints::CuArray = CUDA.zeros(Float16, n, n)

    # ------ Production Tensors ------
    # This is our IO Table, it represents the amount of resource
    # i to produce resource j (nxn).
    io_table::CuArray = CUDA.zeros(Float16, n, n)

    # This is the "Use Table", or the amount of resource i used to create
    # resource j at time t.
    use::CuArray = CUDA.zeros(Float16, ω, n, n)
    
    # This is the "Output Table", or the output of industry j at time t.
    # o_{i,j} ≤ (u_{t,i,j})/(a_{i,j}) ∀ t
    outputs::CuArray = CUDA.zeros(Float16, ω, n)

    # ------ Stock Tensors ------
    # This is the "Accumulation of stocks" of resource i for resource j
    # at time t.
    capital_stock_acc::CuArray = CUDA.zeros(Float16, ω, n, n)

    # This is the "Capital Stock" tensor, denoting the amount of stock from 
    # resource i to produce resource j at time t.
    # s_{t,i,j} = (1 - d{i,j})s_{t-1,i,j}+α_{t-1,i,j}
    capital_stock::CuArray = CUDA.zeros(Float16, ω, n, n)

    # ------ Consumption Tensors ------
    # P = ∑_i(u_{t,j,i}) ⟶ Reduce U along second axis with 'sum' function
    productive_consumption::CuArray = mapreduce(identity, +, use; dims=2)
    productive_consumption = reshape(productive_consumption, (ω, n))

    # F = O - Α - P
    final_consumption::CuArray = outputs .- capital_stock_acc .- productive_consumption
end

main()
