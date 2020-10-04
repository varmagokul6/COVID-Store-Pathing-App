clear
clc
aisle = 'A';
perpAisle = 2; %Condition of how many aisles are prependicular in the store configuration
itemLib = readtable('Item Library.xlsx'); %Read and copy Excel sheet that lists items by department and relative spacing
posMatrix(size(itemLib,1),size(itemLib,2)) = ['A']; %Generate blank matrix the same size as the item library
for i = 1:size(itemLib,2)-perpAisle %The loop only runs for the amount of parallel aisles there are
    posMatrix(:,i)= [char(aisle+fix(i/2))]; %Assign the letter which alternates every odd number after 1
end
for n = 1:perpAisle
    posMatrix(:,size(itemLib,2)-perpAisle+n)= [char(posMatrix(1,size(itemLib,2)-perpAisle)+n)]; %Assign the letter starting from where the other loop left off aterneating at every number
end