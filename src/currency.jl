module Currency

export CurrencyUnit, CurrencyQuantity

struct CurrencyUnit{S}
end

struct CurrencyQuantity{U<:CurrencyUnit, T<:Real} <:Number
  val::T
end

end
