module Simple

export SimpleNeuron

import BioNetCore.Abstraction: AnyNeuron, AnySensor
import BioNetCore.Connection.Defining: SimpleDefiningConnection
import BioNetCore.ID: NeuronID, ConnectionID
import BioNetCore.Neuron

mutable struct SimpleNeuron
    id::NeuronID
    activation::Float32
    definitions2self::Dict{ConnectionID, SimpleDefiningConnection}
    definitions2other::Dict{ConnectionID, SimpleDefiningConnection}

    function SimpleNeuron(name::Symbol, parent::Symbol)
        new(NeuronID(name, parent), 0.0f0, Dict(), Dict())
    end
end

Neuron.id(neuron::SimpleNeuron)::NeuronID = neuron.id

Neuron.issensor(neuron::SimpleNeuron)::Bool = false

Neuron.activation(neuron::SimpleNeuron)::Float32 = neuron.activation

Neuron.counter(neuron::SimpleNeuron)::UInt = 1

function Neuron.definedneurons(neuron::SimpleNeuron)::Dict{NeuronID, AnyNeuron}
    Dict{NeuronID, AnyNeuron}(
        map(
            x -> id(x) => x, filter(
                x -> !issensor(x), map(
                    to, values(neuron.definitions2other)
                )
            )
        )
    )
end

function Neuron.definingneurons(neuron::SimpleNeuron)::Dict{NeuronID, AnyNeuron}
    Dict{NeuronID, AnyNeuron}(
        map(
            x -> id(x) => x, filter(
                x -> !issensor(x), map(
                    from, values(neuron.definitions2self)
                )
            )
        )
    )
end

function Neuron.definingsensors(neuron::SimpleNeuron)::Dict{NeuronID, AnySensor}
    Dict{NeuronID, AnySensor}(
        map(
            x -> id(x) => x, filter(
                x -> issensor(x), map(
                    from, values(neuron.definitions2self)
                )
            )
        )
    )
end

function Neuron.activate!(
    neuron::SimpleNeuron, 
    signal::Float32, 
    spreadhorizonal::Bool, 
    spreadvertical::Bool
)::Dict{NeuronID, AnyNeuron}
    neuron.activation += signal

    defined = definedneurons(neuron)

    if spreadvertical
        for definedneuron in values(defined)
            defined = merge!(
                defined, 
                activate!(definedneuron, signal, spreadhorizonal, spreadvertical)
            )
        end
    end

    defined
end

function Neuron.explain(neuron::SimpleNeuron)::Dict{NeuronID, AnySensor}
    definingsensors(neuron)
end

function Neuron.explainone(
    neuron::SimpleNeuron, sensorname::Symbol
)::Union{AnySensor, Nothing}
    for (id, sensor) in definingsensors(neuron)
        if parent(id) == sensorname
            return sensor
        end
    end
    nothing
end

function Neuron.deactivate!(
    neuron::SimpleNeuron, 
    spreadhorizonal::Bool, 
    spreadvertical::Bool
)::Nothing
    neuron.activation = 0.0f0
    if spreadvertical
        for definedneuron in values(definedneurons(neuron))
            deactivate!(definedneuron, spreadhorizonal, spreadvertical)
        end
    end
    nothing
end

function Neuron.connectto!(
    neuron::SimpleNeuron, to::AnyNeuron
)::SimpleDefiningConnection
    connection = SimpleDefiningConnection(neuron, to)
    push!(neuon.definitions2other, id(connection) => connection)
    connection
end

function Neuron.connectto!(
    neuron::SimpleNeuron, connection::SimpleDefiningConnection
)::SimpleDefiningConnection
    @assert connection.from === neuron
    push!(neuon.definitions2other, id(connection) => connection)
    connection
end

function Neuron.connectfrom!(
    neuron::SimpleNeuron, from::AnyNeuron
)::SimpleDefiningConnection
    connection = SimpleDefiningConnection(from, neuron)
    push!(neuon.definitions2self, id(connection) => connection)
    connection
end

function Neuron.connectfrom!(
    neuron::SimpleNeuron, connection::SimpleDefiningConnection
)::SimpleDefiningConnection
    @assert connection.to === neuron
    push!(neuon.definitions2self, id(connection) => connection)
    connection
end

end