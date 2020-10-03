

image = imread('storelayout.png');

J = imresize(image,1/100);

grayimage = rgb2gray(J);
bwimage = grayimage < 0.5;
grid = binaryOccupancyMap(bwimage);

show(grid)

x = checkOccupancy(grid);

y = find(x);