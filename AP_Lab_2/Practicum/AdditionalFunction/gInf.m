function y = gInf(V, V1, V2)
%Computes limits of gate value, given V1 and V2 parameters

    y = 0.5*(1+tanh((V-V1)/V2));

end