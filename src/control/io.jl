"""
    Program to read/write from files on filesystem

    Authors: Blake Espeland
    2023 - MIT Lisense
"""

try
    using CSV, DataFrames
catch Exception
    import Pkg
    Pkg.add("CSV")
    Pkg.add("DataFrames")

    using CSV, DataFrames
end 

const IO_PREFIX::String = "[IO]:"

# relative root directory of data
const DATA_DIR::String = "../../data/"

# Hyper parameter store path
const HYPER_CFG::String = "hyper.csv"

# Raw technology data store path
const TECH_DATA::String = DATA_DIR * "tech_data.csv"


function read_csv(path::String)::AbstractArray
    println("$IO_PREFIX Reading $path")
    df::DataFrame = CSV.read(path, DataFrame)
end


function get_io_table()::AbstractArray
    return read_csv(DATA_DIR + TECH_DATA)
end