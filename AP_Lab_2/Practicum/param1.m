function par=param1(I1,R_m,C_m)
%Parameters for Exercise 1 (RC cell)
%
%function par=param1(I1,R_m,C_m)
%
%you can pass up to three parameters: injected current, cell resistance, cell capacitance
%    
    par.studentname = studentname;
    par.task = 1;
    par.tsim = [0,0.050];
    %par.tsteps = 1000; %use 0 for autostepping

    if ~exist('I1','var')
        I1=-1e-7;               %Default value of the injected current
        warning('injected current not defined, set to %2.2e A',I1);
    end
    if ~exist('R_m','var')
        R_m=1e6;               %Default value of the cell resistance
        warning('model cell resistance not defined, set to %2.2e Ohm',R_m);
    end
    if ~exist('C_m','var')
        C_m=1e-9;               %Default value of the cell capacitance
        warning('model cell capacitance not defined, set to %2.2e F',C_m);
    end
        
    par.R_m = R_m; 
    par.C_m = C_m; 

    par.V_m_start = 0;          %Starting membrane voltage (V)
    
    par.I1 = I1;
    par.t_I1_start = 10e-3;    %Start time for the injected current (s)
    par.t_I1_end   = 30e-3;    %End time for the injected current (s)

end