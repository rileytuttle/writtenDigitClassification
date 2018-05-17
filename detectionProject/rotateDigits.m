[m,n] = size(A);
D = zeros(m,n);
theta = pi/4;
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
for i = 1:5000
  temp1 = reshape(A(i,:),20,20);
  temp2 = [;];
  for j = 1:20
    for k = 1:20
      if temp1(j,k) == 1
        temp2 = [temp2,[j;k]];
      end
    end
  end
  temp3 = temp2-10;
  temp3 = floor(R*temp3);
  temp3 = temp3 + 10;
  temp4 = zeros(20,20);
  for j = 1:size(temp3,2)
    if temp3(1,j) > 0 && temp3(2,j) > 0
      temp4(temp3(1,j),temp3(2,j)) = 1;
    end
  end
  D(i,:) = temp4(:);
end
displayData([D(1,:);D(501,:);D(1001,:);D(1501,:);D(2001,:);...
             B(1,:);B(501,:);B(1001,:);B(1501,:);B(2001,:);...
             D(2501,:);D(3001,:);D(3501,:);D(4001,:);D(4501,:);...
             B(2501,:);B(3001,:);B(3501,:);B(4001,:);B(4501,:)]);


for i=1:m
  temp1 = zeros(2,n);
  for j=1:n
    if A(i,j) == 1
      temparray(:,j) = [i;j];
    end
  end
  temparray = R*temparray;
  for j = 1:n
    if temparray(:,j) != [0;0]
      D(i,j) == 1;
    end
  end
end
displayData([D(501,:);A(501,:)]);