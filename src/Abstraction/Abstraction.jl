module Abstraction

export AnyConnection
export AnyDefiningConnection, AnyInhibitoryConnection
export AnySequentialConnection, AnySimilarityConnection
export AnyNeuron
export AnySensor
export AnySensoryField
export AnyAssociativeNetwork

abstract type AnyConnection end
abstract type AnyDefiningConnection <: AnyConnection end
abstract type AnyInhibitoryConnection <: AnyConnection end
abstract type AnySequentialConnection <: AnyConnection end
abstract type AnySimilarityConnection <: AnyConnection end

abstract type AnyNeuron end
abstract type AnySensor <: AnyNeuron end

abstract type AnySensoryField end

abstract type AnyAssociativeNetwork end

end