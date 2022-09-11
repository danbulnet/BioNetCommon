export SimpleDefiningConnection, WeightedDefiningConnection

import BioNetCore.Abstraction: AnyNeuron, AnyDefiningConnection
import BioNetCore.ID: ConnectionID
import BioNetCore.Connection

function Connection.kind(_connection::AnyDefiningConnection)::ConnectionKind
    ConnectionKind::Defining
end

struct SimpleDefiningConnection <: AnyDefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
end

Connection.from(connection::SimpleDefiningConnection)::AnyNeuron = connection.from

Connection.to(connection::SimpleDefiningConnection)::AnyNeuron = connection.to

function Connection.id(connection::SimpleDefiningConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

function Connection.weight(connection::SimpleDefiningConnection)::AnyNeuron
    1.0f0 / counter(from(connection))
end

mutable struct WeightedDefiningConnection <: AnyDefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
    weight::Float32
end

Connection.from(connection::WeightedDefiningConnection)::AnyNeuron = connection.from

Connection.to(connection::WeightedDefiningConnection)::AnyNeuron = connection.to

function Connection.id(connection::WeightedDefiningConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

Connection.weight(connection::WeightedDefiningConnection)::AnyNeuron = connection.weight
