function [newX] = addnoise(X,sigma2)
  [m,n] = size(X);
  newX = zeros(m,n);
  newX = X + floor(randn(m,n)*sqrt(sigma2));
  newX = newX(:);
  for i = 1:length(X)
    if newX(i) < 0
      newX(i) = 0;
    elseif newX(i) >255
      newX(i) = 255;
    end
  end
  newX = reshape(newX, m,n);
