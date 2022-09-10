export AnyConnection
export AnyNeuron
export AnySensor
export AnySensoryField
export AnyAssociativeNetwork

abstract type AnyConnection end

abstract type AnyNeuron end

abstract type AnySensor <: AnyNeuron end

abstract type AnySensoryField end

abstract type AnyAssociativeNetwork end