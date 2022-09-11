export NeuronID, ConnectionID

struct NeuronID
    name::Symbol
    parent::Symbol
end

struct ConnectionID
    from::NeuronID
    to::NeuronID
end

function Base.show(io::IO, neuron::NeuronID)
    print(neuron.parent, ":", neuron.name)
end

function Base.show(io::IO, connection::ConnectionID)
    print(connection.from, "=>", connection.to)
end