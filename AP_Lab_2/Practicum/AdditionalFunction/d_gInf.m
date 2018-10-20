function y = d_gInf(V,V1,V2)
%Returns the derivative of the m_infinity(V) function, evaluated at V.
%
%   y = d_mInf(V,V1,V2) returns the m_infinity(V) derivative at V, given
%   parameters V1 and V2

    y = (1/(2*V2)) * d_tanh((V-V1)/V2);

end