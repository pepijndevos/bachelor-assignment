D0 = 0.25;
k0 = 0.3;
t = linspace(-0.2,1)./20e3;
dD = 0.3;

Dgnd = D0 + heaviside(t).*dD;
Dfree = k0 - heaviside(t).*dD.*exp(-2*pi*20e3*t);
Dfwd = 1 - D0 - k0 - heaviside(t).*dD.*(1 - exp(-5*t));
area(seconds(t), [Dgnd; Dfree; Dfwd]')
legend('D_{gnd}', 'D_{free}', 'D_{fwd}')
ylim([0,1])
xlabel('Time')
ylabel('Duty cycle')