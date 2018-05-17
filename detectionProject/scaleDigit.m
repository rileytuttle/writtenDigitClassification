function [newX] = scaleDigit(X,scale)
tempX = zeros(20,20);
tempX = reshape(X,20,20);
newX = zeros(20,20);
for i = 1:5
  for j = 1:5
    if (tempX(7+i,7+j) == 1)
      newX((i-1)*scale+1:i*scale,(j-1)*scale+1:j*scale)...
      = ones(scale,scale);
    end
%     disp(newX(1:10,1:10))
  end
end
newX = newX(:);
shift = floor((20-scale*5)/2);
newX = translate(newX,shift, shift);