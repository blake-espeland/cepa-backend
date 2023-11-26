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

include("meta.jl")
include("technology.jl")

using BenchmarkTools


function main()
    if !CUDA.functional() || !CUDA.has_cuda_gpu()
        println("System incompatible with CUDA")
        return
    end

    CUDA.allowscalar(false) # disallowing scalar indexing of CuArray's
    meta_read_meta() # Populate HyperParameters
    
    # ------ Production Tensors ------
    # This is our IO Table, it represents the amount of resource
    # i to produce resource j (nxn).
    io_table = tech_generate_tensor(IO_TENSOR)

    # This is the "Use Table", or the amount of resource i used to create
    # resource j at time t.
    use = tech_generate_tensor(USE_TENSOR)
    
    # This is the "Output Table", or the output of industry j at time t.
    # o_{i,j} ≤ (u_{t,i,j})/(a_{i,j}) ∀ t
    outputs = tech_generate_tensor(OUTPUT_TENSOR)

    # ------ Auxillary Tensors ------
    # Capital Constraints
    capital_constraints = tech_generate_tensor(CAP_CONSTRAINTS_TENSOR)

    # ------ Stock Tensors ------
    # This is the "Accumulation of stocks" of resource i for resource j
    # at time t.
    capital_stock_acc = tech_generate_tensor(CAP_ACC_CONSTRAINTS_TENSOR)

    # This is the "Capital Stock" tensor, denoting the amount of stock from 
    # resource i to produce resource j at time t.
    # s_{t,i,j} = (1 - d{i,j})s_{t-1,i,j}+α_{t-1,i,j}
    capital_stock = tech_generate_tensor(CAP_STOCK_TENSOR)

    # ------ Consumption Tensors ------
    # P = ∑_i(u_{t,j,i}) ⟶ Reduce U along second axis with 'sum' function
    productive_consumption = mapreduce(identity, +, use; dims=2)
    productive_consumption = reshape(productive_consumption, (ω, n))

    # F = O - Α - P
    final_consumption::CuArray = outputs .- capital_stock_acc .- productive_consumption


end

main()
