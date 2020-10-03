clear; clc; 

image = imread('storelayout.png');
imageres = imresize(image,1/100);     %add dynamic resolution based on number of store_items
grayimage = rgb2gray(imageres);
bwimage = grayimage < 0.5;
grid = binaryOccupancyMap(bwimage);
show(grid)

occupancy = checkOccupancy(grid)
shelves = find(occupancy)
horizontal_shelves = 
vertical_shelves = 


store_items = ["Milk", "Eggs", "Coffee"];
% line of code to group milk and eggs together, etc (optional)


% if vertical shelf --> check + and - the row# 
% if horizontal shelf --> check + and - the index#  
% collect matrix of these suitable locations
% randomly assign store_items to a coordinate


item_locations = [];
store = containers.Map(items, locations_store);

% user input specifies shopping list