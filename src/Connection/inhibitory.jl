module Inhibitory

export WeightedInhibitoryConnection

import BioNetCore.Abstraction: AnyNeuron, AnyInhibitoryConnection
import BioNetCore.ID
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

function ID.id(connection::WeightedInhibitoryConnection)::ConnectionID
    ConnectionID(ID.id(Connection.from(connection)), ID.id(Connection.to(connection)))
end

Connection.weight(connection::WeightedInhibitoryConnection)::AnyNeuron = connection.weight

end