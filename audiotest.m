R = 8;
Rc = 1000; % common mode damping resistor
C = 1e-6;
L = 4*C;

if 1
    [y, Fs] = audioread('sultans.wav', [round(1*44100), round(3*44100)]);
    ym=resample(y(:,1), 10, 1); % mono
    Fs = 10*Fs;
else
    Fs = 441000;
    t = linspace(0,0.1,Fs*0.1);
    f = 10000;
    ym = sin(2*pi*f*t);
%     ym = sawtooth(2*pi*f*t, 0.5);
%     ym(ym > 0) = 1;
%     ym(ym < 0) = -1;
%     [b, a] = butter(1, 20000/(Fs/2));
%     ym = filter(b, a, ym);
end

Ts=1/Fs;
dur=length(ym)*Ts;
t=linspace(0,dur,length(ym));

ys=ym.*10; % scale
%yp=(ys+2+sqrt(4+ys.^2))./(2*ys);
%yp=2./(ys+2+sqrt(4+ys.^2));

D=timeseries(ys, t);
%D2=timeseries((1-yp)*2-1, t);

%%
%simout = sim('power_BoostConverter_bridge', dur);
simout = sim('power_BoostConverter_brfb', dur);
%%
vout = simout.vout;
vmax = prctile(vout, 99.9);
vmean = mean(vout);
signal = -(vout)/(vmax);
%sound(signal, Fs)

%%
figure
hold on
plot(vout);
plot(ys, 'LineWidth',2);
legend('Output', 'Input');

figure
thd(vout, Fs)