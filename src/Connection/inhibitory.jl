export WeightedInhibitoryConnection

import BioNetCommon.Data: AnyNeuron, ConnectionID

mutable struct WeightedInhibitoryConnection <: DefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
    weight::Float32
end

from(connection::WeightedInhibitoryConnection)::AnyNeuron = connection.from

to(connection::WeightedInhibitoryConnection)::AnyNeuron = connection.to

function id(connection::WeightedInhibitoryConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

weight(connection::WeightedInhibitoryConnection)::AnyNeuron = connection.weight
