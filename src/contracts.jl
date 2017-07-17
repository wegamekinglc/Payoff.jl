include("observables.jl")
include("currency.jl")
using .Currency

abstract type Contract end

struct Zero <: Contract end

struct Amount{O} <: Contract
    o::O
end

struct Scale{O<:Observable, C<:Contract} <: Contract
    s::O
    c::C
end

Scale(x::Number, c::Contract) = Scale(ConstObs(x), C)

struct Both{C1<:Contract, C2<:Contract} <: Contract
    c1::C1
    c2::C2
end

struct Either{C1<:Contract, C2<:Contract} <: Contract
    c1::C1
    c2::C2
end

struct Give{C<:Contract} <: Contract
    c::C
end

struct Cond{P<:Observable{Bool}, T1<:Contract, T2<:Contract} <: Contract
    p::P
    c1::T1
    c2::T2
end

struct When{P<:Observable{Bool}, C<:Contract} <: Contract
    p::P
    c::C
end

struct Anytime{P<:Observable{Bool}, C<:Contract} <: Contract
    p::P
    c::C
end

struct Until{P<:Observable{Bool}, C<:Contract} <: Contract
    p::P
    c::C
end


# Derived Contracts

Receive{T} = Amount{ConstObs{T}}
Receive(x::Union{Real, CurrencyQuantity}) = Amount(ConstObs(X))
