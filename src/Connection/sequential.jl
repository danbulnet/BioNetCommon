export WeightedSequentialConnection

import BioNetCore.Data: AnyNeuron, ConnectionID

mutable struct WeightedSequentialConnection <: DefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
    weight::Float32
end

from(connection::WeightedSequentialConnection)::AnyNeuron = connection.from

to(connection::WeightedSequentialConnection)::AnyNeuron = connection.to

function id(connection::WeightedSequentialConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

weight(connection::WeightedSequentialConnection)::AnyNeuron = connection.weight
