clear; clc; 

image = imread('storelayout.png');
imageres = imresize(image,1/100);     %add dynamic resolution based on number of store_items
grayimage = rgb2gray(imageres);
bwimage = grayimage < 0.5;
map = binaryOccupancyMap(bwimage);


store = store_layout;

% waypoints = [];
%for i = 1:length(list)
%    waypoints = [waypoints; mod(store(list(i)), 20), 1 + (store(list(i)) - mod(store(list(i)))/20)];
%end

prmSimple = mobileRobotPRM(map,100);
%show(prmSimple)


waypoints = [0 0; 14 6; 4 12; 12 1; 19 10; 0 0];

rngState = rng;
prm = mobileRobotPRM(map,100);
size_way = size(waypoints);

for i = 1:(size_way(1)-1)
    startLocation = waypoints(i, :);
    endLocation = waypoints(i+1, :);
    path = findpath(prm,startLocation,endLocation);
    hold on
    show(prm)
end


