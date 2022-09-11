module Neuron

export NeuronState

import BioNetCommon.Data: AnyNeuron, NeuronID

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

function definedneurons(neuron::AnyNeuron)::Vector{AnyNeuron}
    error("no definedneurons(neuron) implementation for $(typeof(neuron))")
end

function definingneurons(neuron::AnyNeuron)::Vector{AnyNeuron}
    error("no definingneurons(neuron) implementation for $(typeof(neuron))")
end

function definingsensors(neuron::AnyNeuron)::Vector{AnyNeuron}
    error("no definingsensors(neuron) implementation for $(typeof(neuron))")
end

function Base.show(io::IO, neuron::AnyNeuron)
    print(
        "[", id(neuron), "|a:", activation(neuron), "|s:", issensor(neuron), "]"
    )
end

end
