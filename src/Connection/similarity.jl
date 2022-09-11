export SimilarityConnection, SimpleSimilarityConnection, WeightedSimilarityConnection

import BioNetCore.Data: AnyNeuron, ConnectionID

abstract type SimilarityConnection <: AnyConnection end

Connection.kind(connection::SimilarityConnection)::ConnectionKind = ConnectionKind::Similarity

mutable struct WeightedSimilarityConnection <: DefiningConnection 
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
