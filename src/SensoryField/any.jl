export datatype, insert!, search, deactivatesensor!

import BioNetCore.Abstraction: AnySensoryField, AnySensor, AnyNeuron
import BioNetCore.ID
import BioNetCore.Data
import BioNetCore.Data: StatQualia
import BioNetCore.Neuron

function ID.id(field::AnySensoryField)::Symbol
    error("no id(field) implementation for $(typeof(field))")
end

function datatype(field::AnySensoryField)::DataType
    error("no datatype(field) implementation for $(typeof(field))")
end

function Data.statqualia(field::AnySensoryField)::StatQualia
    error("no statqualia(field) implementation for $(typeof(field))")
end

function insert!(field::AnySensoryField, item)::AnySensor
    error(
        "no insert(field, item) implementation for ", 
        "($(typeof(field)), $(typeof(item)))"
    )
end

function search(field::AnySensoryField, item)::Union{AnySensor, Nothing}
    error(
        "no search(field, item) implementation for ", 
        "($(typeof(field)), $(typeof(item)))"
    )
end

function Neuron.activate!(
    field::AnySensoryField, 
    item,
    _signal::Real, 
    _spreadhorizonal::Bool, 
    _spreadvertical::Bool
)::Dict{NeuronID, AnyNeuron}
    error(
        "no activate!(field, item, ...) implementation for ", 
        "($(typeof(field)), $(typeof(item)))"
    )
end

function Neuron.deactivate!(
    field::AnySensoryField,
    item,
    _spreadhorizonal::Bool, 
    _spreadvertical::Bool
)::Nothing
    error(
        "no deactivate!(field, item, ...) implementation for ", 
        "($(typeof(field)), $(typeof(item)))"
    )
end

function deactivatesensor!(field::AnySensoryField)::Nothing
    error("no deactivatesensor!(field) implementation for ($(typeof(field))")
end