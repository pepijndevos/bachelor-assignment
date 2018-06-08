data = LTspice2Matlab('spice/pwm.raw', []);
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

data = LTspice2Matlab('spice/pwm.raw', [gnd1, fwd1, loop1, gnd2, fwd2, loop2, il1, il2, isw1, isw2, isw3, isw4, isw5, isw6, vout1, vout2]);
%%
t_all = data.time_vect;
start = find(t_all==t_all(1));
end_ = find(t_all==t_all(end));

%%

for idx = 1:length(start)
    
    t = t_all(start(idx):end_(idx));

    dt = mean(diff(t));
    t2 = t(1):dt:t(end);

    pwm = data.variable_mat(:,start(idx):end_(idx))';
    pwm2  = interp1(t, pwm,t2);

    TT = array2timetable(pwm2,'RowTimes',seconds(t2));

    nt = seconds(linspace(t(1), t(end), 500));
    TT2 = retime(TT,nt,'mean');

    figure('visible','off')
    ax1 = subplot(2,1,1);
    area(TT2.Time, TT2(:,[1,3,2]).Variables*20)
    legend('V(gnd1)','V(loop1)','V(fwd1)')
    ylabel('duty cycle (%)')
    ylim([0,100])
    xlabel('time')

    ax2 = subplot(2,1,2);
    area(TT2.Time, TT2(:,[4,6,5]).Variables*20)
    legend('V(gnd2)','V(loop2)','V(fwd2)')
    ylabel('duty cycle (%)')
    ylim([0,100])
    xlabel('time')
    
    printpdf(gcf,sprintf('pwm_frame_%d', idx))

    figure('visible','off')
    ax3 = subplot(2,1,1);
    area(TT2.Time, TT2(:,[9, 10, 11]).Variables)
    legend('I(fwd1)','I(loop1)','I(gnd1)')
    ylabel('current (A)')
    xlabel('time')
    ylim([-5,5])

    ax4 = subplot(2,1,2);
    area(TT2.Time, TT2(:,[13, 14, 12]).Variables)
    legend('I(fwd2)','I(loop2)','I(gnd2)')
    ylabel('current (A)')
    xlabel('time')
    ylim([-5,5])
    
    printpdf(gcf,sprintf('current_frame_%d', idx))

    figure('visible','off')
    ax5 = axes();
    plot(TT2.Time, TT2(:,15).Variables-TT2(:,15).Variables)
    legend('V(out)')
    ylabel('voltage (V)')
    xlabel('time')
    ylim([-10,10])
    
    printpdf(gcf,sprintf('output_frame_%d', idx))

    %linkaxes([ax1,ax2,ax3,ax4, ax5],'x')
end
