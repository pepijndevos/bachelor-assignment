data = LTspice2Matlab('spice/pwm.raw');

gnd1 = find(strcmp(data.variable_name_list, 'V(gnd1)'));
fwd1 = find(strcmp(data.variable_name_list, 'V(fwd1)'));
crs1 = find(strcmp(data.variable_name_list, 'V(crs1)'));
gnd2 = find(strcmp(data.variable_name_list, 'V(d^)'));
fwd2 = find(strcmp(data.variable_name_list, 'V(fwd2)'));
crs2 = find(strcmp(data.variable_name_list, 'V(crs2)'));


t = data.time_vect;
dt = mean(diff(t));
t2 = t(1):dt:t(end);

pwm = data.variable_mat([gnd1,crs1,fwd1,gnd2,crs2,fwd2],:)';
pwm2  = interp1(t, pwm,t2);

TT = array2timetable(pwm2,'RowTimes',seconds(t2));

nt = seconds(linspace(t(1), t(end)));
TT2 = retime(TT,nt,'mean');

figure()
subplot(2,1,1);
area(TT2.Time, TT2(:,1:3).Variables)
legend('V(fwd1)','V(crs1)','V(gnd1)')

subplot(2,1,2);
area(TT2.Time, TT2(:,4:6).Variables)
legend('V(fwd2)','V(crs2)','V(gnd2)')
%legend('V(crs1)',	'V(crs2)',	'V(gnd2)',	'V(fwd1)',	'V(fwd2)',	'V(gnd1)')

%figure()
%area(TT2.Time, TT2(:,[1, 4]).Variables)