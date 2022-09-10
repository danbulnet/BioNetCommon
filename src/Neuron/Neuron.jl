module Neuron

export NeuronState

import BioNetCommon.Data: AnyConnection, AnyNeuron, NeuronID, ConnectionID

@enum NeuronState begin
    active
    inactive
end

include("simple.jl")

end
