export InhibitoryConnection, WeightedInhibitoryConnection

import BioNetCore.Data: AnyNeuron, ConnectionID

abstract type InhibitoryConnection <: AnyConnection end

Connection.kind(connection::InhibitoryConnection)::ConnectionKind = ConnectionKind::Inhibitory

mutable struct WeightedInhibitoryConnection <: DefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
    weight::Float32
end

Connection.from(connection::WeightedInhibitoryConnection)::AnyNeuron = connection.from

Connection.to(connection::WeightedInhibitoryConnection)::AnyNeuron = connection.to

function Connection.id(connection::WeightedInhibitoryConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

Connection.weight(connection::WeightedInhibitoryConnection)::AnyNeuron = connection.weight
