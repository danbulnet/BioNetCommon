module Neuron

export AnyNeuron, NeuronID
export id, counter

struct NeuronID
    name::Symbol
    parent::Symbol
end

abstract type AnyNeuron end

id(neuron::AnyNeuron) = "todo" # TODO

counter(neuron::AnyNeuron) = 1 # TODO

end
