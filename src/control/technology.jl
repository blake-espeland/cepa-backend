"""
    File for generating the technology matrix and some associated utilities.

    Authors: Blake Espeland
    2023 - MIT Lisense
"""

include("io.jl")
include("meta.jl")

using CUDA
using Match

const TPREFIX = "[TECH]:"

@enum TECH_TENSOR_VERSION begin
    IO_TENSOR
    USE_TENSOR
    OUTPUT_TENSOR
    CAP_CONSTRAINTS_TENSOR
    CAP_ACC_CONSTRAINTS_TENSOR
    CAP_STOCK_TENSOR
    PROD_CONSUMPTION_TENSOR
    FINAL_CONSUMPTION_TENSOR
end

const TECH_NAMES = [
    "agriculture"
    "industry_inc_eng"
    "construction"
    "services"
    "foreign_trade"
]

const TECH_PATH = Dict([
    (IO_TENSOR, "../../data/io.tensor"),
    (USE_TENSOR, "../../data/use.tensor"),
    (OUTPUT_TENSOR, "../../data/output.tensor"),
    (CAP_CONSTRAINTS_TENSOR, "../../data/cap_constraints.tensor"),
    (CAP_ACC_CONSTRAINTS_TENSOR, "../../data/cap_acc_constraints.tensor"),
    (CAP_STOCK_TENSOR, "../../data/cap_stock.tensor"),
])

function _tech_simulate_tensor(tensor_type::TECH_TENSOR_VERSION)
    A::AbstractArray

    M = tech_cardinality()
    N = tech_cardinality()
    T = HyperParameters["nyears"]

    A = @match tensor_type begin
        $IO_TENSOR => randn(HyperParameters["iot_σ"], (M, N))
        $USE_TENSOR => randn((M, N, T))
        $OUTPUT_TENSOR => zeros((M, T))
        $CAP_CONSTRAINTS_TENSOR => randn((M, N, T))
        $CAP_ACC_CONSTRAINTS_TENSOR => randn((M, N, T))
        $CAP_STOCK_TENSOR => randn((M, N, T))
        # Invalid tensor arguments
        $PROD_CONSUMPTION_TENSOR ||
        $FINAL_CONSUMPTION_TENSOR => println("Tensor is calculated, not generated")
        _ => println("Invalid tensor type")
    end

    return A
end

function tech_generate_tensor(tensor_type::TECH_TENSOR_VERSION)
    if HyperParameters["simulate"]
        return _tech_simulate_tensor(tensor_type)
    end

    A::AbstractArray

    M = tech_cardinality()
    N = tech_cardinality()
    T = HyperParameters["nyears"]

    A = @match tensor_type begin
        $IO_TENSOR => io_read_bytes_as_aa(TECH_PATH[tensor_type], (M, N))
        $USE_TENSOR => io_read_bytes_as_aa(TECH_PATH[tensor_type], (M, N, T))
        $OUTPUT_TENSOR => io_read_bytes_as_aa(TECH_PATH[tensor_type], (M, T))
        $CAP_CONSTRAINTS_TENSOR => io_read_bytes_as_aa(TECH_PATH[tensor_type], (M, N, T))
        $CAP_ACC_CONSTRAINTS_TENSOR => io_read_bytes_as_aa(TECH_PATH[tensor_type], (M, N, T))
        $CAP_STOCK_TENSOR => io_read_bytes_as_aa(TECH_PATH[tensor_type], (M, N, T))
        # Invalid tensor arguments
        $PROD_CONSUMPTION_TENSOR ||
        $FINAL_CONSUMPTION_TENSOR => println("Tensor is calculated, not generated")
        _ => println("Invalid tensor type")
    end

    return A
end

"""
    enumerate_industries()::Int32

    Function to provide the number of evaluated industries 
    1. Read config from filesystem
    2. Parse number of considered industries
"""
function tech_cardinality()::Int32
    return size(TECH_NAMES, 1)
end


function tech_list_names()::Array
    return TECH_NAMES
end