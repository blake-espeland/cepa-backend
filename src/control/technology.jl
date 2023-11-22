"""
    File for generating the technology matrix and some associated utilities.

    Authors: Blake Espeland
    2023 - MIT Lisense
"""

include("io.jl")

using CUDA

const TPREFIX = "[TECH]:"
const TECH_NAMES = [
    "agriculture"
    "industry_inc_eng"
    "construction"
    "services"
    "foreign_trade"
]

function generate_io_table(simulate::Bool)
    if simulate
        println("$TPREFIX Simulating IO Table...")
    else
        println("$TPREFIX Reading IO Table from file system...")
        A = get_io_table()
    end
    
    return Array.zeros(2)
end