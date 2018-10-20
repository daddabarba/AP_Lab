function [v,t] = getPeak(V)
%Returns the value and the time of the first peak of a voltage trace
%
%   v = getPeak(V) given an array of voltages V, returns the peak
%   value
%
%   [v,t] = getPeak(V) given an array of voltages V, returns the
%   peak value and at which time the peak is reached


    %Get first order differenceV
    fod = diff(V);
    
    %Normalize fod
    fod_dir = fod;
    fod_dir(fod_dir>0) = 1;
    fod_dir(fod_dir<0) = -1;
    
    %Get second order difference
    fod_2 = diff(fod_dir);
    
    %Get time points where derivative direction changes
    changes = find(fod_2~=0);
    
    %Get highest peak
    [v0, i0] = max(V(changes));
    
    %Get second highest peak
    V(changes(i0)) = -Inf;
    [v1, i1] = max(V(changes));
    
    %Get values at peaks
    v = [v0 v1];
    
    %Get peaks time
    t = [changes(i0), changes(i1)];

end