function [newX] = blurDigit(X)
  X = reshape(X,20,20);
  newX = zeros(size(X));
  for i = 2:19
    for j = 2:19
      newX(i,j) = sum(sum(X(i-1:i+1,j-1:j+1)))/9;
    end
  end
  newX = reshape(newX,1,400);
      
