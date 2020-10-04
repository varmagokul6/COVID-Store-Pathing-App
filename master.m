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


% if vertical shelf --> check + and - the row# 
% if horizontal shelf --> check + and - the index#  
% collect matrix of these suitable locations
% randomly assign store_items to a coordinate


item_locations = [];
store = containers.Map(store_items, item_locations);

% user input specifies shopping list



% Traversing the Path
store_size = size(x);
path = [];
for row = 1:store_size(1)
    for col = 1:store_size(2)
        if (~x(row, col)) && (item_true)
            path = [path; col, row];
        end
    end
end

hold on
plot(path(:, 1), path(:, 2), '-r');

