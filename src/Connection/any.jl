export from, to, weight, kind

import BioNetCore.Abstraction: AnyConnection, AnyNeuron
import BioNetCore.ID
import BioNetCore.ID: ConnectionID

function ID.id(connection::AnyConnection)::ConnectionID
    error("no id(connection) implementation for $(typeof(connection))")
end

function from(connection::AnyConnection)::AnyNeuron
    error("no from(connection) implementation for $(typeof(connection))")
end

function to(connection::AnyConnection)::AnyNeuron
    error("no to(connection) implementation for $(typeof(connection))")
end

function weight(connection::AnyConnection)::Float32
    error("no weight(connection) implementation for $(typeof(connection))")
end

function kind(connection::AnyConnection)::ConnectionKind
    error("no kind(connection) implementation for $(typeof(connection))")
end

function Base.show(io::IO, connection::AnyConnection)
    print(
        "{", id(connection), 
        "|w:", round.(connection.weight; digits=5), "}"
    )
end