abstract type Observable{T} end

struct DateObs <: Observable{Date} end

struct AcquisitionDateObs <: Observable{Date} end

struct ConstObs{T} <: Observable{T}
    val::T
end

obstype{T}(::Observable{T}) = T

obstype{T1}(::Tuple{Observable{T1}}) = Tuple{T1}

obstype{T1, T2}(::Tuple{Observable{T1}, Observable{T2}}) = Tuple{T1, T2}

struct LiftObs{F, A, R} <: Observable{R}
    f::F
    a::A
    function LiftObs{F,A,R}(f, a...) where {F,A,R}
        new(f, a)
    end
end

function LiftObs(f::Function, a::Observable...)
    RR = Base.return_types(f, obstype(a))
    R = length(RR) > 1 ? Any : RR[1]
    LiftObs{typeof(f), typeof(a), R}(f, a...)
end

const AtObs = LiftObs{typeof(==), Tuple{DateObs, ConstObs{Date}}, Bool}
AtObs(t::Date) = LiftObs(==, DateObs(), ConstObs(t))
const At = AtObs

const BeforeObs = LiftObs{typeof(<=), Tuple{DateObs, ConstObs{Date}}, Bool}
BeforeObs(t::Date) = LiftObs(<=,DateObs(),ConstObs(t))
