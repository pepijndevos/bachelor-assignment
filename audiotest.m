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
    ym = sin(2*pi*f*t)/10;
%     ym(ym > 0) = 1;
%     ym(ym < 0) = -1;
end

Ts=1/Fs;
dur=length(ym)*Ts;
t=linspace(0,dur,length(ym));

yp1=(ym+1)/2;
ys1=1./(yp1*3+1);
% ys1=yp1*2/3+1/3;
D1=timeseries(ys1*2-1, t);

yp2=(-ym+1)/2;
ys2=1./(yp2*3+1);
% ys2=yp2*2/3+1/3;
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
plot(-signal);
legend('Input', 'Output');