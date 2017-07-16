abstract type Contract end

struct Zero <: Contract end

struct Amount{O} <: Contract
    o::O
end
