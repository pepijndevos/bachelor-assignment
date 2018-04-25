[y, Fs] = audioread('sultans.wav');
Ts=1/Fs;
dur=length(y)*Ts;
t=linspace(0,dur,length(y));
ym=y(:,1); % mono

yp1=(ym+1)/2;
%ys1=1./(yp1*2/3+1/3)/3;
ys1=yp1*2/3+1/3;
D1=timeseries(ys1*2-1, t);

yp2=(-ym+1)/2;
ys2=1./(yp2*2/3+1/3)/3;
ys2=yp2*2/3+1/3;
D2=timeseries(ys2*2-1, t);

%%
simout = sim('power_BoostConverter_bridge', dur);
%%
vout = simout.vout;
vmax = max(vout);
vmean = mean(vout);
signal = -(vout)/6;
%sound(signal, Fs)

%%
figure
hold on
plot(ym);
plot(signal);
legend('Input', 'Output');