module Simple

export SimpleNeuron

import BioNetCore.Abstraction: AnyNeuron, AnySensor
import BioNetCore.Connection: to, from
import BioNetCore.Connection.Defining: SimpleDefiningConnection
import BioNetCore.ID
import BioNetCore.ID: NeuronID, ConnectionID
import BioNetCore.Neuron

mutable struct SimpleNeuron <: AnyNeuron
    id::NeuronID
    activation::Float32
    definitions2self::Dict{ConnectionID, SimpleDefiningConnection}
    definitions2other::Dict{ConnectionID, SimpleDefiningConnection}

    function SimpleNeuron(name::Symbol, parent::Symbol)
        new(NeuronID(name, parent), 0.0f0, Dict(), Dict())
    end
end

ID.id(neuron::SimpleNeuron)::NeuronID = neuron.id

Neuron.issensor(neuron::SimpleNeuron)::Bool = false

Neuron.activation(neuron::SimpleNeuron)::Float32 = neuron.activation

Neuron.counter(neuron::SimpleNeuron)::UInt = 1

function Neuron.definedneurons(neuron::SimpleNeuron)::Dict{NeuronID, AnyNeuron}
    Dict{NeuronID, AnyNeuron}(
        map(
            x -> ID.id(x) => x, filter(
                x -> !Neuron.issensor(x), map(
                    to, values(neuron.definitions2other)
                )
            )
        )
    )
end

function Neuron.definingneurons(neuron::SimpleNeuron)::Dict{NeuronID, AnyNeuron}
    Dict{NeuronID, AnyNeuron}(
        map(
            x -> ID.id(x) => x, filter(
                x -> !Neuron.issensor(x), map(
                    from, values(neuron.definitions2self)
                )
            )
        )
    )
end

function Neuron.definingsensors(neuron::SimpleNeuron)::Dict{NeuronID, AnySensor}
    Dict{NeuronID, AnySensor}(
        map(
            x -> ID.id(x) => x, filter(
                x -> Neuron.issensor(x), map(
                    from, values(neuron.definitions2self)
                )
            )
        )
    )
end

function Neuron.activate!(
    neuron::SimpleNeuron, 
    signal::Real, 
    spreadhorizonal::Bool, 
    spreadvertical::Bool
)::Dict{NeuronID, AnyNeuron}
    signal = Float32(signal)
    neuron.activation += signal

    defined = Neuron.definedneurons(neuron)

    if spreadvertical
        for definedneuron in values(defined)
            defined = merge!(
                defined, 
                Neuron.activate!(definedneuron, signal, spreadhorizonal, spreadvertical)
            )
        end
    end

    defined
end

function Neuron.explain(neuron::SimpleNeuron)::Dict{NeuronID, AnyNeuron}
    merge(Neuron.definingsensors(neuron), Neuron.definingneurons(neuron))
end

function Neuron.explainone(
    neuron::SimpleNeuron, parent::Symbol
)::Union{AnyNeuron, Nothing}
    for (id, sensor) in Neuron.definingsensors(neuron)
        if ID.parent(id) == parent
            return sensor
        end
    end
    for (id, neuron) in Neuron.definingneurons(neuron)
        if ID.parent(id) == parent
            return neuron
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
        for definedneuron in values(Neuron.definedneurons(neuron))
            Neuron.deactivate!(definedneuron, spreadhorizonal, spreadvertical)
        end
    end
    nothing
end

function Neuron.defineto!(
    neuron::SimpleNeuron, to::AnyNeuron
)::SimpleDefiningConnection
    connection = SimpleDefiningConnection(neuron, to)
    push!(neuron.definitions2other, ID.id(connection) => connection)
    connection
end

function Neuron.defineto!(
    neuron::SimpleNeuron, connection::SimpleDefiningConnection
)::SimpleDefiningConnection
    @assert connection.from === neuron
    push!(neuron.definitions2other, ID.id(connection) => connection)
    connection
end

function Neuron.definefrom!(
    neuron::SimpleNeuron, from::AnyNeuron
)::SimpleDefiningConnection
    connection = SimpleDefiningConnection(from, neuron)
    push!(neuron.definitions2self, ID.id(connection) => connection)
    connection
end

function Neuron.definefrom!(
    neuron::SimpleNeuron, connection::SimpleDefiningConnection
)::SimpleDefiningConnection
    @assert connection.to === neuron
    push!(neuron.definitions2self, ID.id(connection) => connection)
    connection
end

function Neuron.define!(from::SimpleNeuron, to::SimpleNeuron)::SimpleDefiningConnection
    connection = Neuron.defineto!(from, to)
    Neuron.definefrom!(to, connection)
    connection
end

function Neuron.define!(from::AnySensor, to::SimpleNeuron)::SimpleDefiningConnection
    connection = Neuron.definefrom!(to, from)
    Neuron.defineto!(from, connection)
    connection
end

end