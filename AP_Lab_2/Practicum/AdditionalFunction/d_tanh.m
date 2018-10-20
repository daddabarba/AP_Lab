function y = d_tanh(x)
%Computes the derivative with respect to x of the tanh function
%
%   y = d_tanh(x) given an x returns the derivative of the tanh function
%   evaluated at x.

    y = 1-(tanh(x)^2);
end