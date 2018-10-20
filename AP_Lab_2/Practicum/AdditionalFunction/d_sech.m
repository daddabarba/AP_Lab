function y = d_sech(x)
%Computes the derivative with respect to x of the sech function
%
%   y = d_sech(x) given an x returns the derivative of the sech function
%   evaluated at x.

    y = -tanh(x)*sech(x);
end