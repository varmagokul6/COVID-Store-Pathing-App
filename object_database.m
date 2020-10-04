function itemLocation = object_database(searchItem)
aisle = 'A';
perpAisle = 1; %Condition of how many aisles are prependicular in the store configuration
itemLib = readtable('Item Library.xlsx'); %Read and copy Excel sheet that lists items by department and relative spacing
posMatrix(size(itemLib,1),size(itemLib,2)) = ['A']; %Generate blank matrix the same size as the item library

for i = 1:size(itemLib,2)-perpAisle %The loop only runs for the amount of parallel aisles there are
    posMatrix(:,i)= [char(aisle+fix(i/2))]; %Assign the letter which alternates every odd number after 1
end

for n = 1:perpAisle
    posMatrix(:,size(itemLib,2)-perpAisle+n)= [char(posMatrix(1,size(itemLib,2)-perpAisle)+n)]; %Assign the letter starting from where the other loop left off aterneating at every number
end
%This program only functions correctly when starting on an aisle with two sides 

[aisleLoc,aisleDes]=find(strcmp(table2array(itemLib),searchItem)); %Locate the input within the item library
itemLocation = {posMatrix(1,aisleDes),aisleLoc}; %Create cell array for output