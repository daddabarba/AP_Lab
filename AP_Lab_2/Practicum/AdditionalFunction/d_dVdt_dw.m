function y = d_dVdt_dw(V,w, p)
%Evaluates the derivative of the state function dV/dt(V,w) with respect to
%the w, at (V,w).
%
%   y = d_dVdt_dV(V,w, p) V is the voltage at which we want to evaluate the
%   derivative, w the potasium gating value at which we evaluate the 
%   derivative, p is a struct of parameters

    y = -(p.Gbar_K*V)/p.C_m;

end