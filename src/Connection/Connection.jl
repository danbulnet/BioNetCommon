module Connection

export DefiningConnection
export SimilarityConnection
export InhibitoryConnection
export SequentialConnection
export from, to, id, weight, kind

import BioNetCommon.Data: AnyConnection, AnyNeuron, NeuronID, ConnectionID

abstract type DefiningConnection <: AnyConnection end
abstract type SimilarityConnection <: AnyConnection end
abstract type InhibitoryConnection <: AnyConnection end
abstract type SequentialConnection <: AnyConnection end

@enum ConnectionKind begin
    Defining
    Similarity
    Inhibitory
    Sequential
    Unknown
end

include("defining.jl")
include("similarity.jl")
include("inhibitory.jl")
include("sequential.jl")

function from(connection::AnyConnection)::AnyNeuron
    error("no from(connection) implementation for: $connection")
end

function to(connection::AnyConnection)::AnyNeuron
    error("no to(connection) implementation for: $connection")
end

function id(connection::AnyConnection)::ConnectionID
    error("no id(connection) implementation for: $connection")
end

function weight(connection::AnyConnection)::Float32
    error("no weight(connection) implementation for: $connection")
end

kind(connection::AnyConnection)::ConnectionKind = ConnectionKind::Unknown
kind(connection::DefiningConnection)::ConnectionKind = ConnectionKind::Defining
kind(connection::SimilarityConnection)::ConnectionKind = ConnectionKind::Similarity
kind(connection::InhibitoryConnection)::ConnectionKind = ConnectionKind::Inhibitory
kind(connection::SequentialConnection)::ConnectionKind = ConnectionKind::Sequential

function Base.show(io::IO, connection::AnyConnection)
    print(
        "{", id(connection), 
        "|w:", round.(connection.weight; digits=5), "}"
    )
end

end