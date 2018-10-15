%function y = nernst (z,c_ext,c_int,T)
%         y = R .* T ./ z ./ F .* log (c_ext ./ c_int);
% calculates the Nernst potential, unit [V], 
% of an electrochemical cell for an ion
% with the charge z, referenced against the external side at external 
% concentration c_ext (mol/l), internal concentration c_int (mol/l) 
% and temperature T (K). if T is not given, it is set to 300 K. 
 function y = nernst (z,c_ext,c_int,T)

R = 8.3144; %(J/K)
F = 96485; %(As/V)
if ~exist('T')
	T = 300;
end
         y = R .* T ./ z ./ F .* log (c_ext ./ c_int);
         
