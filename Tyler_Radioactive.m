clear all
clf

tmax = 60;  % Days
tstep = .3;
time = 0:tstep:tmax;    % Time vector to represent tmax days in tstep intervals.

% k values.
k1 = 1.06;
k2 = .69;
k3 = .19;
k4 = .03;
k5 = 2.5;

% Compartment vector.
x = zeros(length(time), 4);

x(1, 1) = 1;
x(2, 1) = 0;
x(3, 1) = 0;
x(4, 1) = 0;

% Euler's method:
for i=1:(length(time)-1)
    x(i+1, 1) = (x(i, 2)*k2 - x(i, 1)*k1 - x(i, 1)*k3)*tstep + x(i, 1);
    x(i+1, 2) = (x(i, 1)*k1 - x(i, 2)*k2 - x(i, 2)*k4)*tstep + x(i, 2);
    x(i+1, 3) = (x(i, 1)*k3 + x(i, 2)*k4 - x(i, 3)*k5)*tstep + x(i, 3);
    x(i+1, 4) =                           (x(i, 3)*k5)*tstep + x(i, 4);
end

% ODE45 implementation. See react.m for system implementation.
[t, y] = ode45('react', 0:tstep:tmax, [x(1, 1) x(1, 2) x(1, 3) x(1, 4)]);

disp('Maximum error for each compartment between Euler and ODE45:')
disp(max(abs(y-x)))

hold on
plot(time, x)
plot(t, y, 'c')
legend('x1 (Vascular)', 'x2 (Extravascular))', 'x3 (Breakdown)', 'x4 (Excretion)', 'ODE45 Solution')
xlabel(['Time (Steps of ' num2str(tstep) ')'])
ylabel('Fraction of Radioactive Material')
title('Kinetics of Radioactive Tracers')
hold off