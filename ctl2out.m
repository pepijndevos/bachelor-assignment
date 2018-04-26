function [sys] = ctl2out(R, L, C, D, D0)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    s = tf('s');
    sys = (1-s*L*(1-D/D0)/(R*D^2))/(1+s*L/(R*D^2)+s^2*L*C/(D^2));
end

