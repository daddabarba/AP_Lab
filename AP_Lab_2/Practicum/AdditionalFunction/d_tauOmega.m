function y = d_tauOmega(V,tau_mu,V1,V2)
%Returns the derivative of the tau_omega(V) function, evaluated at V.
%
%   y = d_tauOmega(V,tau_mu,V1,V2) returns the tau_omega(V) derivative at V, given
%   parameters V1 and V2

    y = (tau_mu/(2*V2)) * d_sech((V-V1)/(2*V2));

end