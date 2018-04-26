R = 4;
C = 1e-6;
L = 64*C;
D0 = 0.5;

hold on
for d = linspace(0, 0.2, 10)
    sys1 = ctl2out(R, L, C, D0+d, D0);
    sys2 = ctl2out(R, L, C, D0-d, D0);

    brsys = sys1+sys2
    bode(brsys)
    %stepplot(brsys)
end