R = 8;
Rc = 1000; % common mode damping resistor
C = 1e-6;
L = 4*C;

if 0
    [y, Fs] = audioread('sultans.wav', [44100, 2*44100]);
    ym=y(:,1); % mono
else
    Fs = 441000;
    t = linspace(0,0.1,Fs*0.1);
    f = 1000;
    ym = sin(2*pi*f*t);
%     ym = sawtooth(2*pi*f*t, 0.5);
%     ym(ym > 0) = 1;
%     ym(ym < 0) = -1;
    [b, a] = butter(1, 20000/(Fs/2));
    ym = filter(b, a, ym);
end

Ts=1/Fs;
dur=length(ym)*Ts;
t=linspace(0,dur,length(ym));

ys=ym.*2; % scale
%yp=(ys+2+sqrt(4+ys.^2))./(2*ys);
yp=2./(ys+2+sqrt(4+ys.^2));

D1=timeseries(yp*2-1, t);
D2=timeseries((1-yp)*2-1, t);

%%
simout = sim('power_BoostConverter_bridge', dur);
%%
vout = simout.vout;
vmax = prctile(vout, 99.9);
vmean = mean(vout);
signal = -(vout)/(vmax-0.5);
%sound(signal, Fs)

%%
figure
hold on
plot(-signal);
plot(ym, 'LineWidth',2);
legend('Output', 'Input');