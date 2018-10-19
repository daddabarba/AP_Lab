function y = d_dVdt_dV(V, p)
%Evaluates the derivative of the state function dV/dt(V,w) with respect to
%the voltage, at V.
%
%   y = d_dVdt_dV(V, p) V is the voltage at which we want to evaluate the
%   derivative, p is a struct of parameters

    y = (-1/p.C) * ...
        p.Gbat_Ca*d_mInf(V,p.V1,p.V2)

end

function y = d_tauOmega(V,tau_mu,V1,V2)
%Returns the derivative of the tau_omega(V) function, evaluated at V.
%
%   y = d_tauOmega(V,tau_mu,V1,V2) returns the tau_omega(V) derivative at V, given
%   parameters V1 and V2

    y = (tau_mu/(2*V2)) * d_sech((V-V1)/(2*V2));

end

function y = d_mInf(V,V1,V2)
%Returns the derivative of the m_infinity(V) function, evaluated at V.
%
%   y = d_mInf(V,V1,V2) returns the m_infinity(V) derivative at V, given
%   parameters V1 and V2

    y = (1/(2*V2)) * d_tanh((V-V1)/V2);

end

function y = d_sech(x)
%Computes the derivative with respect to x of the sech function
%
%   y = d_sech(x) given an x returns the derivative of the sech function
%   evaluated at x.

    y = -tanh(x)*sech(x);
end

function y = d_tanh(x)
%Computes the derivative with respect to x of the tanh function
%
%   y = d_tanh(x) given an x returns the derivative of the tanh function
%   evaluated at x.

    y = 1-(tanh(x)^2);
end