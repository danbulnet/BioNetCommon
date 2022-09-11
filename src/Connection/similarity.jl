module Similarity

export WeightedSimilarityConnection

import BioNetCore.Abstraction: AnyNeuron, AnySimilarityConnection
import BioNetCore.ID: ConnectionID
import BioNetCore.Connection

function Connection.kind(connection::AnySimilarityConnection)::ConnectionKind
    ConnectionKind::SimilarityConnectionKind
end

mutable struct WeightedSimilarityConnection <: AnySimilarityConnection 
    from::AnyNeuron
    to::AnyNeuron
    weight::Float32
end

Connection.from(connection::WeightedSimilarityConnection)::AnyNeuron = connection.from

Connection.to(connection::WeightedSimilarityConnection)::AnyNeuron = connection.to

function Connection.id(connection::WeightedSimilarityConnection)::ConnectionID
    ConnectionID(id(from(connection)), id(to(connection)))
end

Connection.weight(connection::WeightedSimilarityConnection)::AnyNeuron = connection.weight

end