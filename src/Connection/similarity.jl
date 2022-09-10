export SimpleSimilarityConnection, WeightedSimilarityConnection

import BioNetCommon.Data: AnyNeuron, ConnectionID

mutable struct WeightedSimilarityConnection <: DefiningConnection 
    from::AnyNeuron
    to::AnyNeuron
    weight::Float32
end

from(connection::WeightedSimilarityConnection)::AnyNeuron = connection.from

to(connection::WeightedSimilarityConnection)::AnyNeuron = connection.to

function id(connection::WeightedSimilarityConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

weight(connection::WeightedSimilarityConnection)::AnyNeuron = connection.weight
