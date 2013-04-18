clear all
clf
dt = .5				%Timestep.
tmax = 70			%Number of days.
clockmax = ceil(tmax/dt);	%Number of timesteps.
t = 0				
aSame = .05			%Chance of getting sick if someone is sick on your floor.
aDif = .03			%Chance of getting sick if someone is sick on a different floor.
b = .01				%Average time of recovery.
Stotal=0			%Total of each category.
Itotal=0
Rtotal=0
N=1000			%Total population.

for(floor = 1:25)		%Make an array of floors, each with these variables.
   S(floor)=40
   I(floor)=0
   R(floor)=0
   N(floor)=40
   ItoR(floor)=0
   StoI(floor)=0
end

infectedFloor = round(random('unif',0,25)) %pick a random floor and place 5 infected people on it
I(infectedFloor) = 5
S(infectedFloor) = 35

for clock = 1:clockmax
   t = clock * dt;
   Stotal=0;
   Itotal=0;
   Rtotal=0;
   for(floor = 1:25)			%Go through each floor and change the susceptible, 
       pItoR = dt * b;			%infected and recovered people
       for(i=1:I(floor))
           if(rand<pItoR)			%Randomly move a person to recovered based on the 
               ItoR(floor)=ItoR(floor)+1;	%probability of recovering
           end
       end
       if(ItoR(floor)>I(floor))		%If the number of people that become recovered are more
           ItoR(floor)=I(floor);		%then the number of infected people
       end
       pStoI = dt * aSame * (I(floor) / N(floor));	%Get the rate of infection based on if there is an
       for(s = 1:S(floor))				%infected person on the floor
           if(rand<pStoI)
               StoI(floor) = StoI(floor)+1;		%Randomly move a person to infected based on 
						%probability of getting infected
         	end
       end
    
       for(otherfloor = 1:25)
           pStoI = dt * aDif * (I(otherfloor) / N(otherfloor));	%Get the rate of infectivity if 
           if(rand<pStoI)						%someone is infected on a different 
               StoI(floor) = StoI(floor)+1;				%floor
           end
        
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
      
   tsave(clock) = t;
       Ssave(clock) = Stotal;
       Isave(clock) = Itotal;
       Rsave(clock) = Rtotal;
       Stotal
       Itotal
       Rtotal
    
       subplot (10,1,1), plot(tsave,Ssave)		%Graph the total susceptible over time.
       axis([0,tmax,0,1000]);
       axis manual;
        xlabel('Total number of Suscptible people over time.')
    
       subplot (10,1,2), plot(tsave,Isave)		%Graph the total Infected over time.
       axis([0,tmax,0,1000]);
       axis manual;
       xlabel('Total number of Infected people over time.')

       subplot (10,1,3), plot(tsave,Rsave)		%Graph the total Recovered over time.
       axis([0,tmax,0,1000]);
       axis manual;
       xlabel('Total number of Recovered people over time.')


       Splot=Ssave(clock);     %Make sure the pie chart doesn’t give errors of non-positive values.
       Iplot=Isave(clock);
       Rplot=Rsave(clock);
       if(Splot==0)
           Splot=.001;
       end
      if(Iplot==0)
           Iplot=.001;
      end
       if(Rplot==0)
           Rplot=.001;
       end
       subplot (10,1,4:5),pie([Splot Iplot Rplot],{'Susceptible' 'Infected' 'Recovered'});
       y = zeros(100,100);		%Graph a pie chart of the totals of each category.
       for(a=1:25)
       Y(a,1)=S(a);
       Y(a,2)=I(a);
       Y(a,3)=R(a);
    
       end
    
       subplot (10,1,6:10),barh(Y,'stack');	%3 segmented bar graph of all the floors.
       axis([0,40,0,26]);				%Each section of each bar is the total of each
       axis manual;				%category on that floor.
       grid on
       mycolor = [0 1 0; 1 0 0;0 0 1];	%Green = Susceptible. Red = Infected. Blue = Recovered.
       colormap(mycolor)
       xlabel('People')
       ylabel('Floor')
       
       drawnow
end