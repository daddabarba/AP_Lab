function [ P ] = ml_stablepoint(in,I_app)
%function [ P ] = ml_stablepoint(in,I_app)
%calculates the stable point [V,w] 
%given the input parameters in and the applied current

global par; par=in;

if ~exist('I_app','var')
    I_app = 0; 
end
    
for c=1:length(I_app)
    par.I_app = I_app(c);
    V(c) = fzero (@eqV,par.E_K);
    w(c) = w_inf(V(c));
end

P=[V;w];
end

function m=m_inf(V); global par;
    m = (0.5*(1+tanh((V-par.V_1)/par.V_2)));
end

function w=w_inf(V); global par;
    w = (0.5*(1+tanh((V-par.V_3)/par.V_4)));
end

%current at a particular voltage; 
function I = eqV(V); global par;
    I =      ( ...
         m_inf(V) .*    par.Gbar_Ca .* (par.E_Ca -V) + ...
         w_inf(V) .*    par.Gbar_K  .* (par.E_K  -V) + ...
                        par.G_L     .* (par.E_L  -V) + ...
                        par.I_app); 
end