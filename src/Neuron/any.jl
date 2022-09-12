export issensor, activation, counter
export definedneurons, definingneurons, definingsensors
export activate!, explain, explainone, deactivate!
export define!, defineto!, definefrom!

import BioNetCore.Abstraction: AnyConnection, AnyNeuron
import BioNetCore.ID
import BioNetCore.ID: NeuronID

function ID.id(neuron::AnyNeuron)::NeuronID
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
    _signal::Real, 
    _spreadhorizonal::Bool, 
    _spreadvertical::Bool
)::Dict{NeuronID, AnyNeuron}
    error("no activate!(neuron, ...) implementation for $(typeof(neuron))")
end

function explain(neuron::AnyNeuron)::Dict{NeuronID, AnySensor}
    error("no explain(neuron) implementation for $(typeof(neuron))")
end

function explainone(
    neuron::AnyNeuron, _sensorname::Symbol
)::Union{AnySensor, Nothing}
    error("no explainone(neuron, ...) implementation for $(typeof(neuron))")
end

function deactivate!(
    neuron::AnyNeuron, 
    _spreadhorizonal::Bool, 
    _spreadvertical::Bool
)::Nothing
    error("no deactivate!(neuron, ...) implementation for $(typeof(neuron))")
end

function defineto!(neuron::AnyNeuron, _to::AnyNeuron)::AnyConnection
    error("no defineto!(neuron, ...) implementation for $(typeof(neuron))")
end

function defineto!(neuron::AnyNeuron, connection::AnyConnection)::AnyConnection
    error(
        "no defineto!(neuron, connection) implementation for ", 
        "($(typeof(neuron)), $(typeof(connection)))"
    )
end

function definefrom!(neuron::AnyNeuron, _from::AnyNeuron)::AnyConnection
    error("no definefrom!(neuron, ...) implementation for $(typeof(neuron))")
end

function definefrom!(neuron::AnyNeuron, connection::AnyConnection)::AnyConnection
    error(
        "no definefrom!(neuron, connection) implementation for ", 
        "($(typeof(neuron)), $(typeof(connection)))"
    )
end

function define!(from::AnyNeuron, to::AnyNeuron)::AnyConnection
    error(
        "no define!(neuron, neuron) implementation for ", 
        "($(typeof(from)), $(typeof(to)))"
    )
end

function Base.show(io::IO, neuron::AnyNeuron)
    print(
        "[", id(neuron), "|a:", activation(neuron), "|s:", issensor(neuron), "]"
    )
end