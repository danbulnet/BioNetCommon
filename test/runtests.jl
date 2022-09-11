using Test
using Dates

using BioNetCore

@testset "BioNetCore" begin
    @test BioNetCore isa Module
end

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

@testset "Connection" begin
    # @test from(AnyConnection)
end

@testset "Neuron" begin
    neuron1 = SimpleNeuron(:n1, :test)
    neuron2 = SimpleNeuron(:n2, :test)

    @test id(neuron1) == NeuronID(:n1, :test)
    @test id(neuron2) == NeuronID(:n2, :test)

    @test issensor(neuron1) == false
    @test issensor(neuron2) == false
end