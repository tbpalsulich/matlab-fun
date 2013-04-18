clear all; clf;

StoI = .012;
ItoR = .06;
ItoD = .04;

tmax = 50;  % Days
tstep = .1;
time = 0:tstep:tmax;    % Time vector to represent tmax days in tstep intervals.

S = zeros(length(time), 1);
I = zeros(length(time), 1);
R = zeros(length(time), 1);
D = zeros(length(time), 1);

S(1) = 99;
I(1) = 1;
R(1) = 0;
D(1) = 0;
N = S(1)+I(1)+R(1)+D(1);
R0 = StoI*N/(ItoR + ItoD);

if(false)
    vaccinate = (1-1/R0)*N;
    S(1) = S(1) - vaccinate;
    R(1) = vaccinate;
    disp(['Vaccinated ', num2str(vaccinate), ' people'])
end

for i=1:(length(time)-1)
    dS = -StoI*I(i)*S(i);
    dI =  StoI*I(i)*S(i) - ItoR*I(i) - ItoD*I(i);
    dR =                   ItoR*I(i);
    dD =                               ItoD*I(i);
    S(i+1) = dS*tstep + S(i);
    I(i+1) = dI*tstep + I(i);
    R(i+1) = dR*tstep + R(i);
    D(i+1) = dD*tstep + D(i);
end

hold on
plot(time, S, 'b')
plot(time, I, 'r')
plot(time, R, 'g')
plot(time, D, 'k')
axis([0 tmax 0 N])
hold off
xlabel('Time')
ylabel('People')
title('Modeling an Epidemic')
legend('Susceptible', 'Infected', 'Recovered', 'Dead')

disp('Base Reproductive Ratio:')
disp(StoI*N/(ItoR+ItoD))