clear all; close all;
clf
numSides = 25;
[x, y, dx] = simple_polygon(numSides);
seenVertices = zeros(length(x), 1);
vertex = randi(numSides, 1);
vertex2 = vertex;
while abs(vertex - vertex2) < 4
    vertex2 = randi(numSides, 1);
end
seenVertices(vertex) = 1;
startX = x(vertex);
startY = y(vertex);
goalX = x(vertex2);
goalY = y(vertex2);
hold on
plot(x, y)
plot(startX, startY, 'or')
plot(goalX, goalY, 'og')
hold off

d = pdist([startX, startY; goalX, goalY], 'euclidean');

currentX = startX;
currentY = startY;

while currentX ~= goalX && currentY ~= goalY
    [xi, yi] = polyxpoly([currentX goalX], [currentY goalY], x, y, 'unique');
    % Calculate Vr and Vl
    intersections = zeros(length(x), 1);
    lookingForLeft = 1;
    Vl = -1;
    Vr = -1;
    for i=1:length(seenVertices)
        if(seenVertices(i) == 1)
           intersections(i) = -1; 
        else
           [xTemp, yTemp] = polyxpoly([currentX x(i)], [currentY y(i)], x, y, 'unique');
           if(length(xTemp) < 3 && length(yTemp) < 3)
              intersections(i) = length(xTemp)
           end
        end
    end
    if((length(xi) < 3 && length(yi) < 3))      % You can see the target!
        hold on
        plot([currentX, goalX], [currentY, goalY])
        hold off
        currentY = goalY;
        currentX = goalX;
    else
        % Angle between closest left and right.
        % vector set to true when we have "seen" it. Go clockwise until we
        % reach a point where the next point is more than 2
        % intersections. That is the left vertex. Then find a point where
        % the previous point has more than two intersections. That is the
        % right vertex. Then find the angle between.
        disp('Cannot see it...:(')
        currentX = currentX + .01;
        currentY = currentY + .01;
    end
    hold on
    plot(currentX, currentY, 'r')
    hold off
    drawnow
end