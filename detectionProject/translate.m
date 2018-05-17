function [newX] = translate(X,shiftX,shiftY)
tempX = zeros(20,20);
tempX = reshape(X,20,20);
temp1 = zeros(20,20);
newX = zeros(20,20);
if shiftX >= 0
  temp1(1+shiftX:end,:) = tempX(1:end-shiftX,:);
else
  temp1(1:end+shiftX,1:end) = tempX(-1*shiftX+1:end,:);
end
if shiftY >= 0
  newX(:,1+shiftY:end) = temp1(:,1:end-shiftY);
else
  newX(:,1:end+shiftY) = temp1(:,-1*shiftY+1:end);
end
newX = newX(:)';