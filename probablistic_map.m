clear; clc; 

image = imread('storelayout.png');
imageres = imresize(image,1/100);     %add dynamic resolution based on number of store_items
grayimage = rgb2gray(imageres);
bwimage = grayimage < 0.5;
map = binaryOccupancyMap(bwimage);



prmSimple = mobileRobotPRM(map,50);
show(prmSimple)


path_find = [4 6; 6.5 12.5; 4 12; 12 14; 19 2; 16 12; 10 10; 14 6; 22 3];

rngState = rng;
prm = mobileRobotPRM(map,100);
startLocation = [0 0];
endLocation = [10 2];
for i = 1:(length(path_find)-1)
    
path = findpath(prm,startLocation,endLocation);
show(prm)

