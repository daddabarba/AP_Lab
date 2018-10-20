function y = d_dwdt_dV(V,w, p)
%Evaluates the derivative of the state function dw/dt(V,w) with respect to
%the V, at (V,w).
%
%   y = d_dwdt_dV(V,w, p) V is the voltage at which we want to evaluate the
%   derivative, w the potasium gating value at which we evaluate the 
%   derivative, p is a struct of parameters

    y = -d_tauOmega(V,p.tau_w,p.V_3,p.V_4)/(tau_w(V,p.tau_w,p.V_3,p.V_4)^2)*...
        (gInf(V,p.V_3,p.V_4) - w) + ...
        (d_gInf(V,p.V_3,p.V_4))/tau_w(V,p.tau_w,p.V_3,p.V_4);

end