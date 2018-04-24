[y, Fs] = audioread('sultans.wav', [50000, 100000]);
ym=y(:,1);
yp=(ym+1)/2;
Ts=1/Fs;
dur=length(y)*Ts;
t=linspace(0,dur,length(y));
ys=1./(yp*2/3+1/3)/3;
D=timeseries(ys*2-1, t);

%%
simout = sim('power_BoostConverter', dur);
%%
vout = simout.vout;
vmax = max(vout);
vmean = mean(vout);
signal = (vout-2*3.7)/3;
sound(signal, Fs)

%%
figure
hold on
plot(ym);
plot(signal);
legend('Input', 'Output');