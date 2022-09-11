export WeightedSequentialConnection

import BioNetCore.Abstraction: AnyNeuron, AnySequentialConnection
import BioNetCore.ID: ConnectionID
import BioNetCore.Connection

function Connection.kind(_connection::AnySequentialConnection)::ConnectionKind
    ConnectionKind::Sequential
end

mutable struct WeightedSequentialConnection <: AnySequentialConnection 
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
