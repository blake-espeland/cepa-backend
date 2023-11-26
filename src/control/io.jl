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

const IO_PREFIX = "[IO]:"

io_read_csv_as_df(path::String) = CSV.read(path, DataFrame)

function io_read_csv_as_aa(path::String)::AbstractArray
    df::DataFrame = io_read_csv_as_df(path)
    return collect(eachrow(df))
end

function io_read_bytes_as_aa(path::String)::AbstractArray

end