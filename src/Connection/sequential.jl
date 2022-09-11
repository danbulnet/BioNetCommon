export SequentialConnection, WeightedSequentialConnection

import BioNetCore.Data: AnyNeuron, ConnectionID

abstract type SequentialConnection <: AnyConnection end

Connection.kind(connection::SequentialConnection)::ConnectionKind = ConnectionKind::Sequential

mutable struct WeightedSequentialConnection <: DefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
    weight::Float32
end

Connection.from(connection::WeightedSequentialConnection)::AnyNeuron = connection.from

Connection.to(connection::WeightedSequentialConnection)::AnyNeuron = connection.to

function Connection.id(connection::WeightedSequentialConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

Connection.weight(connection::WeightedSequentialConnection)::AnyNeuron = connection.weight
