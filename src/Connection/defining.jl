export DefiningConnection, SimpleDefiningConnection, WeightedDefiningConnection

import BioNetCore.Data: AnyNeuron, ConnectionID
import BioNetCore.Connection

abstract type DefiningConnection <: AnyConnection end

Connection.kind(connection::DefiningConnection)::ConnectionKind = ConnectionKind::Defining

struct SimpleDefiningConnection <: DefiningConnection 
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

mutable struct WeightedDefiningConnection <: DefiningConnection 
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
