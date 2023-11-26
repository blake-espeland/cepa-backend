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

DATA_DIR = joinpath(@__DIR__, "../../data")
CFG_DIR = joinpath(@__DIR__, "../../cfg")

@enum FILE_TYPE begin
    DATA_FT
    CFG_FT
end

FT_TO_DIR = Dict([
    (DATA_FT, "DATA_DIR"),
    (CFG_FT, "CFG_DIR")
])

construct_filepath(filename::String, ft::FILE_TYPE) = joinpath(FT_TO_DIR[ft], filename)

function io_read_csv_as_df(filename::String)::AbstractArray
    fp = construct_filepath(filename, CFG_FT)
    println("Reading config from $fp")

    return CSV.read(fp, DataFrame)
end

function io_read_bytes_as_aa(filename::String, shape::Tuple)::AbstractArray
    fp = construct_filepath(filename, DATA_FT)
    println("Reading data from $fp")

    a = Array{Float16}(undef, shape)
    read!(fp, a)
    return a
end