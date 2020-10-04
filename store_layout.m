clear;clc;

image = imread('storelayout.png');

J = imresize(image,1/100);

grayimage = rgb2gray(J);
bwimage = grayimage < 0.5;
graph = binaryOccupancyMap(bwimage);

show(graph);
hold on

store_matrix = checkOccupancy(graph)
shelves = find(store_matrix)     %returns matrix indexes where value != 0


%categorize shelves into horizontal and vertical shelves
%    if vertical shelf --> check index +- row#
%    if horizontal shelf --> check index +- 1
vertical_shelves = [];
horizontal_shelves = [];
row_num = size(store_matrix, 1);
col_num = size(store_matrix, 2);
for coord = 1:row_num*col_num
    if store_matrix(coord)==1 && store_matrix(coord+1)==1       %check if shelf is a vertical shelf
        vertical_shelves = [vertical_shelves;coord];
    elseif store_matrix(coord)==1 && store_matrix(coord+row_num)==1         %check if shelf is a horizontal shelf
        horizontal_shelves = [horizontal_shelves;coord];
    elseif store_matrix(coord)==1 && store_matrix(coord+1)==0 && store_matrix(coord-1)==1      %check for last coordinate of a vertical shelf
        vertical_shelves = [vertical_shelves;coord];
    elseif store_matrix(coord)==1 && store_matrix(coord+row_num)==0 && store_matrix(coord-row_num)==1    %check for last coordinate of a horizontal shelf 
        horizontal_shelves = [horizontal_shelves;coord];
    end
end


%categorize vertical and horizontal shelves into separate aisles
%assign Item Library to aisles 
itemDes = ["A","B","C","D","E","F","G"];
aisle_random = randi(length(itemDes));

for i = 1:size(vertical_shelves, 2) 
    if vertical_shelves(i+1)==vertical_shelves(i) + 1
         
        
end

for i = 1:size(horizontal_shelves, 2)
end



% for simplification, we assume the aisles are big enough and that vertical shelves will be filled first. 


% item_locations = [];
% store = containers.Map(store_items, item_locations);





