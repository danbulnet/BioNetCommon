export NeuronID, ConnectionID

struct NeuronID
    name::Symbol
    parent::Symbol
end

struct ConnectionID
    from::NeuronID
    to::NeuronID
end