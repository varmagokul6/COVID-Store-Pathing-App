function store = store_layout()
image = imread('storelayout.png');

J = imresize(image,1/100);

grayimage = rgb2gray(J);
bwimage = grayimage < 0.5;
graph = binaryOccupancyMap(bwimage);



store_matrix = checkOccupancy(graph);
shelves = find(store_matrix);    %returns matrix indexes where value != 0


vertical_shelves = [];
horizontal_shelves = [];
row_num = size(store_matrix, 1);
col_num = size(store_matrix, 2);
total_size = row_num * col_num;
for coord = 1:row_num*col_num
    if store_matrix(coord)==1 && store_matrix(coord+1)==1           %check if shelf is a vertical shelf
        vertical_shelves = [vertical_shelves;coord];
    elseif store_matrix(coord)==1 && store_matrix(coord+row_num)==1 %check if shelf is a horizontal shelf
        horizontal_shelves = [horizontal_shelves;coord];
    elseif store_matrix(coord)==1 && store_matrix(coord+1)==0 && store_matrix(coord-1)==1      %check for last coordinate of a vertical shelf
        vertical_shelves = [vertical_shelves;coord];
    elseif store_matrix(coord)==1 && store_matrix(coord+row_num)==0 && store_matrix(coord-row_num)==1    %check for last coordinate of a horizontal shelf 
        horizontal_shelves = [horizontal_shelves;coord];
    end
end


% Determine available spots for products to be placed
empty_products = [];


%categorize vertical and horizontal shelves into separate aisles
%assign Item Library to aisles 
itemDes = ["A","B","C","D","E","F","G"];

select = 1;
row = 1;

shelf_locations = [];

for i = 1:size(vertical_shelves, 1)
    if (i+1) > length(vertical_shelves)
        formatSpec = "%s%s";
        letter = itemDes(select);
        num = int2str(row);
        str = sprintf(formatSpec, letter, num);
        shelf_locations = [shelf_locations; str];
    elseif vertical_shelves(i+1)==(vertical_shelves(i) + 1)
        formatSpec = "%s%s";
        letter = itemDes(select);
        num = int2str(row);
        str = sprintf(formatSpec, letter, num);
        shelf_locations = [shelf_locations; str];
        row = row + 1;
    elseif vertical_shelves(i-1) == (vertical_shelves(i) - 1)
        formatSpec = "%s%s";
        letter = itemDes(select);
        num = int2str(row);
        str = sprintf(formatSpec, letter, num);
        shelf_locations = [shelf_locations; str];
        row = 1;
        select = select + 1;
    else
        row = 1;
        select = select + 1;
    end
    right_neighbor = vertical_shelves(i) + row_num;
    left_neighbor = vertical_shelves(i) - row_num;
    
    if (right_neighbor < total_size) 
        empty_products = [empty_products, right_neighbor];
    end
    if (left_neighbor > 1)
        empty_products = [empty_products, left_neighbor];
    end
    
end

for i = 1:size(horizontal_shelves, 1)
    if horizontal_shelves(i+1)==(horizontal_shelves(i) + row_num)

        formatSpec = "%s%s";
        letter = itemDes(select);
        num = int2str(row);
        str = sprintf(formatSpec, letter, num);
        shelf_locations = [shelf_locations; str];
        row = row + 1;
    elseif horizontal_shelves(i-1) == (horizontal_shelves(i) - row_num)
        formatSpec = "%s%s";
        letter = itemDes(select);
        num = int2str(row);
        str = sprintf(formatSpec, letter, num);
        shelf_locations = [shelf_locations; str];
        row = row + 1;
    else
        row = row + 1;
        select = select + 1;
    end
    
    top_neighbor = horizontal_shelves(i) - 1;
    bottom_neighbor = vertical_shelves(i) + 1;
end

perpAisle = 1; %Condition of how many aisles are prependicular in the store configuration
itemLib = readtable('Item Library.xlsx'); %Read and copy Excel sheet that lists items by department and relative spacing
posMatrix(size(itemLib,1),size(itemLib,2)) = ['A']; %Generate blank matrix the same size as the item library


store_loc = ["A1"; "A2"; "A3"; "A4"; "A5"; "B1"; "B2"; "B3"; "B4"; "B5"; 
            "B1"; "B2"; "B3"; "B4"; "B5";"C1"; "C2"; "C3"; "C4"; "C5";
            "C1"; "C2"; "C3"; "C4"; "C5";
            "D1"; "D2"; "D3"; "D4"; "D5"; "D1"; "D2"; "D3"; "D4"; "D5";
            "E1"; "E2"; "E3"; "E4"; "E5"; "E1"; "E2"; "E3"; "E4"; "E5";
            "E1"; "E2"; "E3"];

sorted = sort(empty_products,'ascend'); % sorted from max to min

store = containers.Map(store_loc, sorted);
end
