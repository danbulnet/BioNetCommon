export NeuronID, ConnectionID

struct NeuronID
    name::Symbol
    parent::Symbol
end

struct ConnectionID
    from::NeuronID
    to::NeuronID
end

parent(neuronid::NeuronID) = neuronid.parent
name(neuronid::NeuronID) = neuronid.name

fromparent(connectionid::ConnectionID) = connectionid.from.parent
fromname(connectionid::ConnectionID) = connectionid.from.name
toparent(connectionid::ConnectionID) = connectionid.to.parent
toname(connectionid::ConnectionID) = connectionid.to.name

function Base.show(io::IO, neuron::NeuronID)
    print(neuron.parent, ":", neuron.name)
end

function Base.show(io::IO, connection::ConnectionID)
    print(connection.from, "=>", connection.to)
end