export ConnectionID

import BioNetCore.ID.NeuronID

struct ConnectionID
    from::NeuronID
    to::NeuronID
end

fromparent(connectionid::ConnectionID) = connectionid.from.parent
fromname(connectionid::ConnectionID) = connectionid.from.name
toparent(connectionid::ConnectionID) = connectionid.to.parent
toname(connectionid::ConnectionID) = connectionid.to.name

function Base.show(io::IO, connection::ConnectionID)
    print(io, connection.from, "=>", connection.to)
end