function par=param2(I1,G_K,G_Na)
%exercise 2 and 3
%parameter set for a passive cell with Na and K channels
%function par=param2(I1,G_K,G_Na)
%for the calculation of equilibrium potential (exercise 3)
%use e.g. param2(0,1e-6,1e-6)


   if ~exist('I1','var')
        I1=-1e-7;               
        warning('I1 not defined, set to %2.2e A',I1);
    end
   if ~exist('G_K','var')
        G_K= 0e-6;               
        warning('G_K not defined, set to %2.2e S',G_K);
   end
   if ~exist('G_Na','var')
        G_Na = 1e-6; 
        warning('G_Na not defined, set to %2.2e S',G_Na);        
   end
   
    par.studentname = studentname;
    par.task = 2;
    par.tsim = [0,0.050];
    %par.tsteps = 1000; %not defined for autostepping
    
    par.C_m = 1e-9;            %Cell capacitance(F)

    %reversal potentials
    par.E_Na = +0.040;                 %reversal potential for Na (V)
    par.E_K  = -0.080;                %reversal potential for Na (V)
    %conductances
    par.G_K = G_K;
    par.G_Na = G_Na;
    
    %boundary conditions
    par.V_m_start = 0;         %Starting membrane voltage (V)
  
    %stimulation parameters
    par.I1 = I1;
    par.t_I1_start = 10e-3;   %Injected current pulse start time (s)
    par.t_I1_end   = 30e-3;   %Injected current pulse end time (s)
end