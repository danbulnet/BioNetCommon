export SimpleNeuron

import BioNetCommon.Data: NeuronID, ConnectionID
import BioNetCommon.Connection: SimpleDefiningConnection

mutable struct SimpleNeuron
    id::NeuronID
    activation::Float32
    definitions2self::Dict{ConnectionID, SimpleDefiningConnection}
    definitions2other::Dict{ConnectionID, SimpleDefiningConnection}

    function SimpleNeuron(name::Symbol, parent::Symbol)
        new(NeuronID(name, parent), 0.0f0, Dict(), Dict())
    end
end

id(neuron::AnyNeuron) = "todo" # TODO

counter(neuron::AnyNeuron) = 1 # TODO