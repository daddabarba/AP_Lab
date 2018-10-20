function J = getJacobian(V,w,p)
%Computes jacobian matrix of system, with respect to state variables V and
%w, given parameters p

    J = [d_dVdt_dV(V,w,p), d_dVdt_dw(V,w,p);...
        d_dwdt_dV(V,w,p), d_dwdt_dw(V,w,p)];

end