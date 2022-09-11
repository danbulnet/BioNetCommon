export SimpleDefiningConnection, WeightedDefiningConnection

import BioNetCore.Data: AnyNeuron, ConnectionID

struct SimpleDefiningConnection <: DefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
end

from(connection::SimpleDefiningConnection)::AnyNeuron = connection.from

to(connection::SimpleDefiningConnection)::AnyNeuron = connection.to

function id(connection::SimpleDefiningConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

function weight(connection::SimpleDefiningConnection)::AnyNeuron
    1.0f0 / counter(from(connection))
end

mutable struct WeightedDefiningConnection <: DefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
    weight::Float32
end

from(connection::WeightedDefiningConnection)::AnyNeuron = connection.from

to(connection::WeightedDefiningConnection)::AnyNeuron = connection.to

function id(connection::WeightedDefiningConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

weight(connection::WeightedDefiningConnection)::AnyNeuron = connection.weight
