f=1e6;
t=linspace(0, 1e-6, 1000);
Fs=1e9;
D =  (sawtooth(2*pi*f*t, 0.5)+1)/2;
V = (1-2*D)./(D-D.^2);
%V(V>4) = 4;
%V(V<-4) = -4;
figure
plot(t, V);

xlabel('V');
ylabel('t');

%% Home-grown filter
Fc = 2e6;
w0 = 2*pi*Fc;
Q = 100;
%b = [1, 0, 0];
b = [1, 0, 0]/2+[1, w0/Q, w0^2];
a = [1, w0/Q, w0^2];
sys = tf(b, a)
figure
y = lsim(sys, D, t);
plot(t, D, t, y, t, -V/16+0.5);
legend('triangle', 'filtered', 'ideal');
ylim([0,1]);
figure
bode(sys)