"""
    File for generating the technology matrix and some associated utilities.

    Authors: Blake Espeland
    2023 - MIT Lisense
"""
module MLTech

using MLIO

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
        tech_println("$TPREFIX Simulating IO Table...")
    else
        tech_println("$TPREFIX Reading IO Table from file system...")
    end

    return 
end

end # MLTech