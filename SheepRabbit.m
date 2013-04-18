clear all

x = zeros(1, 100);
y = zeros(1, 100);

x(1) = 50;
y(1) = 25;

r = .9;
s = .1;
as = .5;
ar = .05;
Kr = 300;
Ks = 150;


for t=2:100
   dx = r*x(t-1)*(1-((x(t-1) + as*y(t-1))/Kr));
   dy = s*y(t-1)*(1-((y(t-1) + ar*x(t-1))/Ks));
   x(t) = x(t - 1) + dx;
   y(t) = y(t - 1) + dy;
end

figure(1)
hold on
plot(1:100, x, 'r')
plot(1:100, y)
legend('Rabbits', 'Sheep')
title('Competitive Sheep and Rabbit Populations Over Time')
xlabel('Time')
ylabel('Population')
hold off

figure(2)
plot(y, x, 'g')
ylabel('Rabbits')
xlabel('Sheep')



