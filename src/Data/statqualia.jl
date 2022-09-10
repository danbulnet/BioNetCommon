export StatQualia, Numerical, Ordinal, Categorical
export statqualia

using Dates

abstract type StatQualia end
struct Numerical <: StatQualia end
struct Ordinal <: StatQualia end
struct Categorical <: StatQualia end

statqualia(::Type{<:Any}) = Categorical()

statqualia(::Type{<:AbstractString}) = Categorical()

statqualia(::Type{<:Bool}) = Categorical()

statqualia(::Type{<:Date}) = Ordinal()

statqualia(::Type{<:DateTime}) = Ordinal()

statqualia(::Type{<:Number}) = Numerical()