function ode=odeparam(step,tol)
%read the default ode parameters and adjust tolerance and timestep value;
%this function is provided for Octave/Matlab compatibility

ode = odeset();

if ~exist('step','var') || (exist('step','var') && isempty(step))
    step=1e-3;
end
    
if ~exist('tol','var')
   tol=1e-4;
end

%----

if isfield(ode,'RelTol') 
    ode.RelTol=1e-4;
    odeset('RelTol',1e-4);
end

if isfield(ode,'AbsTol') 
    ode.AbsTol=tol;
    odeset('AbsTol',tol);
end

if isfield(ode,'Step')
    ode.Step=step;
    odeset('Step',step);
end

if isfield(ode,'InitialStep')
    ode.InitialStep=step/10;
    odeset('InitialStep',step/10);
end

if isfield(ode,'MaxStep')
    ode.MaxStep=step;
    odeset('MaxStep',step);
end