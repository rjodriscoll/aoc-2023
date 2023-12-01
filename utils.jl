

using CSV, DataFrames

function read_csv_to_dataframe(path::String)::DataFrame
    return CSV.read(path, DataFrame)
end

function read_text(path::String)::Vector{String}
    open(path) do file
        return readlines(file)
    end
end
