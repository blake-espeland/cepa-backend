"""
    Program to provide meta/hyper-parameters to the main execution

    Authors: Blake Espeland
    2023 - MIT Lisense
"""

include("io.jl")

using DataFrames

# Hyper parameter store path
const HYPER_CFG::String = "../../data/hyper.csv"

HyperParameters::AbstractDict = Dict([
    ("simulate", true),
    ("nyears", 1),
    ("harmonyEps", 1.1)
])

function meta_read_meta()
    table = io_read_csv_as_df(HYPER_CFG)
    println(table)
end