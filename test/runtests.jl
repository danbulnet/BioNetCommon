using Test
using Dates

using BioNetCommon

@testset "BioNetCommon" begin
    @test BioNetCommon isa Module
end

@testset "distances" begin
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