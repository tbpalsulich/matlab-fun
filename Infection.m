clear all
clf
dt = .5
tmax = 120
clockmax = ceil(tmax/dt);
t = 0
aSame = .05
aDif = .01
b = .05
Stotal=0
Itotal=0
Rtotal=0
N=1000

for(floor = 1:25)
    S(floor)=40
    I(floor)=0
    R(floor)=0
    N(floor)=40
    ItoR(floor)=0
    StoI(floor)=0
end

infectedFloor = round(random('unif',0,25))
I(infectedFloor) = 1
S(infectedFloor) = 39

for clock = 1:clockmax
    t = clock * dt;
    Stotal=0;
    Itotal=0;
    Rtotal=0;

    for(floor = 1:25)
        ItoR(floor) = dt * b * I(floor);
        if(ItoR(floor)>I(floor))
            ItoR(floor)=I(floor);
        end
        StoI(floor) = dt * aSame * (I(floor) / N(floor)) * S(floor);

        for(otherfloor = 1:25)
            StoI(floor) = StoI(floor) + dt * aDif * (I(otherfloor) / N(otherfloor)) * S(floor);
        end

        if(StoI(floor)>S(floor))
            StoI(floor)=S(floor);
        end
        S(floor) = S(floor) - StoI(floor);
        I(floor) = I(floor) + StoI(floor) - ItoR(floor);
        R(floor) = R(floor) + ItoR(floor);
        Stotal=Stotal+S(floor);
        Itotal=Itotal+I(floor);
        Rtotal=Rtotal+R(floor);
    end

    Itotal

    tsave(clock) = t;
    Ssave(clock) = Stotal;
    Isave(clock) = Itotal;
    Rsave(clock) = Rtotal;

    subplot (3,1,1), plot(tsave,Ssave)
    axis([0,tmax,0,1000]);
    axis manual;

    subplot (4,1,2), plot(tsave,Isave)
    axis([0,tmax,0,1000]);
    axis manual;

    subplot (4,1,3), plot(tsave,Rsave)
    axis([0,tmax,0,1000]);
    axis manual;

    subplot (4,1,4), pie([Ssave(clock) Isave(clock) Rsave(clock)],{'Susceptible' 'Infected' 'Recovered'});

    drawnow
end