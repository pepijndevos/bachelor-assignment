data = LTspice2Matlab('spice/pwm.raw');
%%
gnd1 = find(strcmp(data.variable_name_list, 'V(gnd1)'));
fwd1 = find(strcmp(data.variable_name_list, 'V(fwd1)'));
loop1 = find(strcmp(data.variable_name_list, 'V(crs1)'));
gnd2 = find(strcmp(data.variable_name_list, 'V(gnd2)')); % d^
fwd2 = find(strcmp(data.variable_name_list, 'V(fwd2)'));
loop2 = find(strcmp(data.variable_name_list, 'V(crs2)'));

il1 = find(strcmp(data.variable_name_list, 'I(L1)'));
il2 = find(strcmp(data.variable_name_list, 'I(L1)'));
isw1 = find(strcmp(data.variable_name_list, 'I(S1)'));
isw2 = find(strcmp(data.variable_name_list, 'I(S2)'));
isw3 = find(strcmp(data.variable_name_list, 'I(S3)'));
isw4 = find(strcmp(data.variable_name_list, 'I(S4)'));
isw5 = find(strcmp(data.variable_name_list, 'I(S5)'));
isw6 = find(strcmp(data.variable_name_list, 'I(S6)'));

vout1 = find(strcmp(data.variable_name_list, 'V(out1)'));
vout2 = find(strcmp(data.variable_name_list, 'V(out2)'));


t = data.time_vect;
dt = mean(diff(t));
t2 = t(1):dt:t(end);

pwm = data.variable_mat';
pwm2  = interp1(t, pwm,t2);

TT = array2timetable(pwm2,'RowTimes',seconds(t2));

nt = seconds(linspace(t(1), t(end), 500));
TT2 = retime(TT,nt,'mean');

%%
close all;

figure()
ax1 = subplot(2,1,1);
area(TT2.Time, TT2(:,[gnd1,loop1,fwd1]).Variables*20)
legend('V(gnd1)','V(loop1)','V(fwd)')
ylabel('duty cycle (%)')
ylim([0,100])
xlabel('time')

ax2 = subplot(2,1,2);
area(TT2.Time, TT2(:,[gnd2,loop2,fwd2]).Variables*20)
legend('V(gnd2)','V(loop2)','V(fwd2)')
ylabel('duty cycle (%)')
ylim([0,100])
xlabel('time')

figure()
ax3 = subplot(2,1,1);
area(TT2.Time, TT2(:,[isw3, isw2, isw1]).Variables)
legend('I(fwd1)','I(loop1)','I(gnd1)')
ylabel('current (A)')
xlabel('time')

ax4 = subplot(2,1,2);
area(TT2.Time, TT2(:,[isw5, isw6, isw4]).Variables)
legend('I(fwd2)','I(loop2)','I(gnd2)')
ylabel('current (A)')
xlabel('time')

figure()
ax5 = axes();
plot(TT2.Time, TT2(:,vout1).Variables-TT2(:,vout2).Variables)
legend('V(out)')
ylabel('voltage (V)')
xlabel('time')

linkaxes([ax1,ax2,ax3,ax4, ax5],'x')
