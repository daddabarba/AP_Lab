function f = getFrequency(V,t,n)
%Computes the frequency of a Voltage response, given the corrispondent time
%for each voltage value, averaging the period over n loops
%
%   f = getFrequency(V,t,n) returns the frequency of V (f), given the time
%   array t, averaging over the last n loops.
%
%   DEFAULT VALUES
%       n = 3

    
    if ~exist('n','var')
       n = 3;
     end


    %Get first order differenceV
    fod = diff(V);

    %Normalize fod
    fod_dir = fod;
    fod_dir(fod_dir>0) = 1;
    fod_dir(fod_dir<0) = -1;

    %Get second order difference
    fod_2 = diff(fod_dir);

    %Get time points where derivative direction changes (peaks)
    changes = find(fod_2~=0);
    
    %get time of the last peak and the n last peak
    t_last_peak = t(changes(length(changes)));
    
    %get time of the n last peak
    t_nLast_peak = t(changes(length(changes) - 2*n));
    
    %Compute period
    T = (t_last_peak - t_nLast_peak)/n;
    
    %Compute frequency
    f = 1/T;

end