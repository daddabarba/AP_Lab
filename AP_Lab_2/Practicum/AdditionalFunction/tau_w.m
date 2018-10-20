function y = tau_w(V, tau_mu, V1, V2)
%Computes limits of time constabt for w

    y = tau_mu*sech((V-V1)/(2*V2));

end