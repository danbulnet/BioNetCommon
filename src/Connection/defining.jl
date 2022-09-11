module Defining

export SimpleDefiningConnection, WeightedDefiningConnection

import BioNetCore.Abstraction: AnyNeuron, AnyDefiningConnection
import BioNetCore.ID
import BioNetCore.ID: ConnectionID
import BioNetCore.Connection

function Connection.kind(_connection::AnyDefiningConnection)::ConnectionKind
    ConnectionKind::DefiningConnectionKind
end

struct SimpleDefiningConnection <: AnyDefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
end

Connection.from(connection::SimpleDefiningConnection)::AnyNeuron = connection.from

Connection.to(connection::SimpleDefiningConnection)::AnyNeuron = connection.to

function ID.id(connection::SimpleDefiningConnection)::ConnectionID
    ConnectionID(ID.id(Connection.from(connection)), ID.id(Connection.to(connection)))
end

function Connection.weight(connection::SimpleDefiningConnection)::AnyNeuron
    1.0f0 / Neuron.counter(Connection.from(connection))
end

mutable struct WeightedDefiningConnection <: AnyDefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
    weight::Float32
end

Connection.from(connection::WeightedDefiningConnection)::AnyNeuron = connection.from

Connection.to(connection::WeightedDefiningConnection)::AnyNeuron = connection.to

function ID.id(connection::WeightedDefiningConnection)::ConnectionID
    ConnectionID(ID.id(Connection.from(connection)), ID.id(Connection.to(connection)))
end

Connection.weight(connection::WeightedDefiningConnection)::AnyNeuron = connection.weight

end