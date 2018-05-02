R = 4;
C = 1e-6;
L = 64*C;
D0 = 0.5;


%% D transfer

D = linspace(0.2,0.8);
V = (1-2*D)./(D-D.^2);
pre = (V-V.^2)./(1-2*V);
plot(D, pre);
xlim([0.2, 0.8]);
xlabel('D');
ylabel('Vout');

%% relation between D

D1 = 0.42
D2 = 1
D0 = (D1+D2)*(D1*D2)/(D1^2+D2^2)

%% plot various D
hold on
for d = linspace(0, 0.2, 10)
    D1 = 0.5+d
    D2 = 0.5-d
    D0 = (D1+D2)*(D1*D2)/(D1^2+D2^2)
    
    sys1 = ctl2out(R, L, C, D1, D0);
    sys2 = ctl2out(R, L, C, D2, D0);

    brsys = sys1+sys2
    %bode(brsys)
    stepplot(brsys)
    %pzmap(brsys)
end