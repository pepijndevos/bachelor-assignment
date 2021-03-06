R = 2e3;
C = 10e-9;
w0 = 1/(R*C);
f0 = w0/(2*pi)

n=1;
m=1;
R1=m*R;
R2=R/m;
C1=n*C;
C2=C/n;

Q=n*m/(m^2+1)

%% tf
close all

figure
hold on
s = tf('s');

lp = w0^2/(s^2+s*w0/Q+w0^2)
stepplot(lp)

hpi = 1-s^2/(s^2+s*w0/Q+w0^2)
stepplot(hpi)

figure
hold on
lpi = 1-w0^2/(s^2+s*w0/Q+w0^2)
stepplot(lpi)

hp = s^2/(s^2+s*w0/Q+w0^2)
stepplot(hp)