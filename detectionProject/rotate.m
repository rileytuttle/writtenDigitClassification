function [newX] = rotate(X,theta)
  R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
  newX = zeros(size(X));
  temp1 = reshape(X,20,20);
  temp2 = [;];
  for i = 1:20
    for j = 1:20
      if temp1(i,j) == 1
        temp2 = [temp2,[i;j]];
      end
    end
  end
  temp3 = temp2-10;
  temp32 = temp3;
  temp3 = floor(R*temp3);
  temp32 = ceil(R*temp32);
  temp3 = temp3 + 10;
  temp32 = temp32 + 10;
  temp4 = zeros(20,20);
  temp6 = zeros(20,20);
  for i = 1:size(temp3,2)
    if temp3(1,i) > 0 && temp3(2,i) > 0
      temp4(temp3(1,i),temp3(2,i)) = 1;
    end
  end
  newX = temp4(:)';