function y = d_dVdt_dV(V,w, p)
%Evaluates the derivative of the state function dV/dt(V,w) with respect to
%the voltage, at (V,w).
%
%   y = d_dVdt_dV(V,w, p) V is the voltage at which we want to evaluate the
%   derivative, w the potasium gating value at which we evaluate the 
%   derivative, p is a struct of parameters

    y = (-1/p.C_m) * ...
        p.Gbar_Ca*d_gInf(V,p.V_1,p.V_2)*(V-p.E_Ca) + ...
        p.Gbar_Ca*gInf(V,p.V_1,p.V_2) + ...
        p.Gbar_K*w + ...
        p.G_L;

end