export SimpleNeuron

import BioNetCore.Data: NeuronID, ConnectionID
import BioNetCore.Connection: SimpleDefiningConnection

mutable struct SimpleNeuron
    id::NeuronID
    activation::Float32
    definitions2self::Dict{ConnectionID, SimpleDefiningConnection}
    definitions2other::Dict{ConnectionID, SimpleDefiningConnection}

    function SimpleNeuron(name::Symbol, parent::Symbol)
        new(NeuronID(name, parent), 0.0f0, Dict(), Dict())
    end
end

id(neuron::SimpleNeuron)::NeuronID = neuron.id

issensor(neuron::SimpleNeuron)::Bool = false

activation(neuron::SimpleNeuron)::Float32 = neuron.activation

counter(neuron::SimpleNeuron)::UInt = 1

function definedneurons(neuron::SimpleNeuron)::Dict{NeuronID, AnyNeuron}
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

function definingneurons(neuron::SimpleNeuron)::Dict{NeuronID, AnyNeuron}
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

function definingsensors(neuron::SimpleNeuron)::Dict{NeuronID, AnyNeuron}
    Dict{NeuronID, AnyNeuron}(
        map(
            x -> id(x) => x, filter(
                x -> issensor(x), map(
                    from, values(neuron.definitions2self)
                )
            )
        )
    )
end

function activate(
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
                activate(definedneuron, signal, spreadhorizonal, spreadvertical)
            )
        end
    end

    defined
end