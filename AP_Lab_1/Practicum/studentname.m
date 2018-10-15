function [ name ] = studentname
%function [ name ] = studentname  
%edit this file and define the string variable 'weare' to hold your name
%weare = 'studentname'

wearelist={'Barbieri & Perin'};

if ~exist('weare','var')
  weare = wearelist{ceil(rand*length(wearelist))};

itis=clock;
name=sprintf('%s %02d.%02d.%4d %02d:%02d',weare,itis([3,2,1,4,5]));

end