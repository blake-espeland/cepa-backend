"""
    Program to read/write from files on filesystem

    Authors: Blake Espeland
    2023 - MIT Lisense
"""

module MLIO

# relative root directory of data
DATA_DIR::String = "../../data/"

# Hyper parameter store path
HYPER_CFG::String = "hyper.csv"

# Raw technology data store path
TECH_DATA::String = DATA_DIR * "tech_data.csv"

end # end module