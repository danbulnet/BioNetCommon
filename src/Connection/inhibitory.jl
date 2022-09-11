module Inhibitory

export WeightedInhibitoryConnection

import BioNetCore.Abstraction: AnyNeuron, AnyInhibitoryConnection
import BioNetCore.ID: ConnectionID
import BioNetCore.Connection

function Connection.kind(_connection::AnyInhibitoryConnection)::ConnectionKind
    ConnectionKind::InhibitoryConnectionKind
end

mutable struct WeightedInhibitoryConnection <: AnyInhibitoryConnection 
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

end