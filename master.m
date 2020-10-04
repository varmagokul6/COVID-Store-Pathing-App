clear; clc; 

image = imread('storelayout.png');
imageres = imresize(image,1/100);     %add dynamic resolution based on number of store_items
grayimage = rgb2gray(imageres);
bwimage = grayimage < 0.5;
grid = binaryOccupancyMap(bwimage);
show(grid)

occupancy = checkOccupancy(grid);
shelves = find(occupancy);


store_items = ["Milk", "Eggs", "Coffee"];
% line of code to group milk and eggs together, etc (optional)


item_locations = [];
%store = containers.Map(store_items, item_locations);

% user input specifies shopping list
shop_list = [object_database('Apples'), object_database('Donuts')];
disp(shop_list);



