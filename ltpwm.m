data = dlmread('spice/pwm.txt', '', 1, 0);

t = data(:,1);

pwm = data(:,2:7);

TT = array2timetable(pwm,'RowTimes',seconds(t));

nt = seconds(linspace(0, t(end)));
TT2 = retime(TT,nt,'mean');
%level = lowpass(TT, 50e3);

figure()
subplot(2,1,1);
area(TT2.Time, TT2(:,[4,1, 6]).Variables)
legend('V(fwd1)','V(crs1)','V(gnd1)')

subplot(2,1,2);
area(TT2.Time, TT2(:,[5,2, 3]).Variables)
legend('V(fwd2)','V(crs2)','V(gnd2)')
%legend('V(crs1)',	'V(crs2)',	'V(gnd2)',	'V(fwd1)',	'V(fwd2)',	'V(gnd1)')

figure()
area(TT2.Time, TT2(:,[6, 3]).Variables)