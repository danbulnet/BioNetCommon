export distance

using Dates

distance(x::Any, y::Any)::Float32 = x == y ? 0.0f0 : 1.0f0

distance(x::String, y::String)::Float32 = x == y ? 0.0f0 : 1.0f0

distance(x::Number, y::Number)::Float32 = Float32(abs(x - y))

function distance(x::Dates.DateTime, y::Dates.DateTime)::Float32
    Float32(abs(Int128(Dates.value(x)) - Int128(Dates.value(y))))
end

function distance(x::Dates.Date, y::Dates.Date)::Float32
    Float32(abs(Dates.value(x - y)))
end