module Neuron

export NeuronState

import BioNetCore.Data: AnyNeuron, AnySensor, NeuronID

@enum NeuronState begin
    active
    inactive
end

include("simple.jl")

function id(neuron::AnyNeuron)::NeuronID
    error("no id(neuron) implementation for $(typeof(neuron))")
end

function issensor(neuron::AnyNeuron)::Bool
    error("no issensor(neuron) implementation for $(typeof(neuron))")
end

function activation(neuron::AnyNeuron)::Float32
    error("no activation(neuron) implementation for $(typeof(neuron))")
end

function counter(neuron::AnyNeuron)::UInt
    error("no counter(neuron) implementation for $(typeof(neuron))")
end

function definedneurons(neuron::AnyNeuron)::Dict{NeuronID, AnyNeuron}
    error("no definedneurons(neuron) implementation for $(typeof(neuron))")
end

function definingneurons(neuron::AnyNeuron)::Dict{NeuronID, AnyNeuron}
    error("no definingneurons(neuron) implementation for $(typeof(neuron))")
end

function definingsensors(neuron::AnyNeuron)::Dict{NeuronID, AnySensor}
    error("no definingsensors(neuron) implementation for $(typeof(neuron))")
end

function activate!(
    neuron::AnyNeuron, 
    _signal::Float32, 
    _spreadhorizonal::Bool, 
    _spreadvertical::Bool
)::Dict{NeuronID, AnyNeuron}
    error("no activate!(neuron, ...) implementation for $(typeof(neuron))")
end

function explain(neuron::SimpleNeuron)::Dict{NeuronID, AnySensor}
    error("no explain(neuron) implementation for $(typeof(neuron))")
end

function explainone(
    neuron::SimpleNeuron, _sensorname::Symbol
)::Union{AnySensor, Nothing}
    error("no explainone(neuron, ...) implementation for $(typeof(neuron))")
end

function deactivate!(
    neuron::SimpleNeuron, 
    _spreadhorizonal::Bool, 
    _spreadvertical::Bool
)::Nothing
    error("no deactivate!(neuron, ...) implementation for $(typeof(neuron))")
end

function Base.show(io::IO, neuron::AnyNeuron)
    print(
        "[", id(neuron), "|a:", activation(neuron), "|s:", issensor(neuron), "]"
    )
end

end
