R = 4;
C = 1e-6;
L = 64*C;

if 0
    [y, Fs] = audioread('sultans.wav', [44100, 2*44100]);
    ym=y(:,1); % mono
else
    Fs = 441000;
    t = linspace(0,0.1,Fs*0.1);
    f = 10000;
    ym = sin(2*pi*f*t);
%     ym(ym > 0) = 1;
%     ym(ym < 0) = -1;
end

Ts=1/Fs;
dur=length(ym)*Ts;
t=linspace(0,dur,length(ym));

ys=ym.*4; % scale
%yp=(ys+2+sqrt(4+ys.^2))./(2*ys);
yp=2./(ys+2+sqrt(4+ys.^2));

D1=timeseries(yp*2-1, t);
D2=timeseries((1-yp)*2-1, t);

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
plot(-signal);
legend('Input', 'Output');