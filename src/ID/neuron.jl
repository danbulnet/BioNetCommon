export NeuronID

struct NeuronID
    name::Symbol
    parent::Symbol
end

parent(neuronid::NeuronID) = neuronid.parent
name(neuronid::NeuronID) = neuronid.name

function Base.show(io::IO, neuron::NeuronID)
    print(io, neuron.parent, ":", neuron.name)
end