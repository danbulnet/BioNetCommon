using Test
using Dates

using BioNetCore

@testset "Data.distances" begin
    @test distance(1, 2) == 1.0f0
    @test distance(2, 1) == 1.0f0
    @test distance(2.0, 1.0) == 1.0f0
    @test distance(1.0, 2.0) == 1.0f0
    @test distance(1//1, 1//1) == 0.0f0
    @test distance(1//1, 2//2) == 0.0f0
    @test distance(1//1, 2//1) == 1.0f0

    @test distance("a", "a") == 0.0f0
    @test distance("a", "b") == 1.0f0
    
    @test distance(true, true) == 0.0f0
    @test distance(true, false) == 1.0f0

    t1 = DateTime(Dates.now())
    sleep(1e-3)
    t2 = DateTime(Dates.now())
    tdiff = Float32(abs(Int128(Dates.value(t2)) - Int128(Dates.value(t1))))
    @test distance(t1, t1) == 0.0f0
    @test distance(t1, t2) == tdiff
    @test distance(t2, t1) == tdiff

    d1 = Date(1962, 10, 10)
    d2 = Date(1964, 03, 13)
    ddiff = Float32(Dates.value(d2 - d1))
    @test distance(d1, d1) == 0.0f0
    @test distance(d1, d2) == ddiff
    @test distance(d2, d1) == ddiff
end

@testset "Data.statqualia" begin
    @test statqualia(Any) === Categorical()
    @test statqualia(Nothing) === Categorical()
    @test statqualia(Bool) === Categorical()
    @test statqualia(String) === Categorical()
    @test statqualia(Char) === Categorical()
    @test statqualia(Date) === Ordinal()
    @test statqualia(DateTime) === Ordinal()
    @test statqualia(Rational) === Numerical()
    @test statqualia(Complex) === Numerical()
    @test statqualia(Irrational) === Numerical()
    @test statqualia(Float64) === Numerical()
    @test statqualia(Int) === Numerical()
end

@testset "Neuron" begin
    neuron1 = SimpleNeuron(:n1, :test)
    neuron2 = SimpleNeuron(:n2, :test)

    @test id(neuron1) == NeuronID(:n1, :test)
    @test id(neuron2) == NeuronID(:n2, :test)

    @test issensor(neuron1) == false
    @test issensor(neuron2) == false

    @test activation(neuron1) == 0.0f0
    @test activation(neuron1) == 0.0f0
    
    @test counter(neuron2) === UInt(1)
    @test counter(neuron2) === UInt(1)
    
    @test isempty(definedneurons(neuron1))
    @test isempty(definedneurons(neuron2))
    @test isempty(definingneurons(neuron1))
    @test isempty(definingneurons(neuron2))
    @test isempty(definingsensors(neuron1))
    @test isempty(definingsensors(neuron2))

    define!(neuron1, neuron2)

    @test length(definedneurons(neuron1)) == 1
    @test length(definedneurons(neuron2)) == 0
    @test length(definingneurons(neuron1)) == 0
    @test length(definingneurons(neuron2)) == 1
    @test length(definingsensors(neuron1)) == 0
    @test length(definingsensors(neuron2)) == 0

    @test length(explain(neuron1)) == 0
    @test length(explain(neuron2)) == 1
    @test first(first(explain(neuron2))) == id(neuron1)
    @test id(last(first(explain(neuron2)))) == id(neuron1)
    @test id(explainone(neuron2, :test)) == id(neuron1)

    activate!(neuron1, 1.0, true, true)

    @test activation(neuron1) == 1.0f0
    @test activation(neuron2) == 1.0f0

    deactivate!(neuron1, true, true)

    @test activation(neuron1) == 0.0f0
    @test activation(neuron2) == 0.0f0

    activate!(neuron1, 1.0, false, false)

    @test activation(neuron1) == 1.0f0
    @test activation(neuron2) == 0.0f0

    deactivate!(neuron1, true, true)

    @test activation(neuron1) == 0.0f0
    @test activation(neuron2) == 0.0f0

    activate!(neuron1, 1.0, true, true)

    @test activation(neuron1) == 1.0f0
    @test activation(neuron2) == 1.0f0

    deactivate!(neuron1, false, false)

    @test activation(neuron1) == 0.0f0
    @test activation(neuron2) == 1.0f0
end