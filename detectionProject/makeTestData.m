load('DetectionProjectData.mat');
% digits - 10x400 contains the individiual 5x5 digits embedded in the 20x20 frame
%   it contains no noise, shifts, or scaling
% A - 5000x400 contains 500 of each digit
%   no noise, shifts or scaling
% B - 5000x400 contains 500 of each digit with noise
%   values range from 0 to 255
%   has approximate distribution ~floor(N(127, 127))
% C - 5000x400 contains 500 of each digit with noise and shift
%   color of each pixel is from B ~N(155, 127)
%   shift can be +8 to -7 in x direction and +8 to -7 in y direction
%   shift ~ floor(N(.5,7.5))
% D - 5000x400 contains 500 of each digit with only rotation with a disribution
%   ~ U(-pi/4,pi/4)
% E - has a bunch of scaled digits
% F - has scaled and shifted
% graydigits - is digits but grayed out
% blurreddigits - is graydigits but blurred


% scale then rotate then shift then color


[m,n] = size(A);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% B 
B = A*127;
B = B + floor((randn(5000,400)*sqrt(127)));
B = B(:);
for i = 1:length(B)
  if B(i) < 0
    B(i) = 0;
  elseif B(i) > 255
    B(i) = 255;
  end
end
B = reshape(B,5000,400);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% C
C=A;
shifts = floor(randn(5000,2).*sqrt(7.5)+.5);
for i=1:m
  C(i,:) = translate(C(i,:),shifts(i,1),shifts(i,2));
end
C = C*127;
C = C+floor((randn(5000,400)*sqrt(127)));
C = C(:);
for i = 1:length(C)
  if C(i) < 0
    C(i) = 0;
  elseif C(i) > 255
    C(i) = 255
  end
end
C = reshape(C,5000,400);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% D
D = zeros(5000,400);
for i = 1:m
  theta = (rand()-.5)*(pi/2);
  D(i,:) = rotate(A(i,:),theta);
end
D = D*127;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% E
E = zeros(m,n);
for i = 1:m
  scale = ceil(rand()*3);
  E(i,:) = scaleDigit(A(i,:),scale);
end
E = E*127;
E = E + floor((randn(5000,400)*sqrt(127)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% F 
F = zeros(m,n);
for i = 1:m
  scale = ceil(rand()*3);
  F(i,:) = scaleDigit(A(i,:),scale);
  switch scale
    case 1
      shift = floor(randn(2,1)*sqrt(7.5) + .5);
      F(i,:) = translate(F(i,:), shift(1), shift(2));
    case 2
      shift = floor(randn(2,1)*sqrt(5));
      F(i,:) = translate(F(i,:), shift(1), shift(2));
    case 3
      shift = floor(randn(2,1)*sqrt(2.5) + .5);
      F(i,:) = translate(F(i,:), shift(1), shift(2));
  end
end
F = F*127;
F = F + floor((randn(5000,400)*sqrt(127)));
 
G = zeros(m,n);
theta = (rand(m,1)-.5)*(pi/2);
%theta = ones(m,1)*pi/4;
for i = 1:m
  scale = ceil(rand()*3);
  shift = 0;
  G(i,:) = scaleDigit(A(i,:),scale);
  temp = rotate(G(i,:),theta(i));
  G(i,:) = rotate(G(i,:),theta(i));
  switch scale
    case 1
      shift = floor(randn(2,1)*sqrt(7.5) + .5);
    case 2
      shift = floor(randn(2,1)*sqrt(5));
    case 3
      shift = floor(randn(2,1)*sqrt(2.5) + .5);
  end
  G(i,:) = translate(G(i,:), shift(1), shift(2));
end
G = G*127;
G = G+floor((randn(m,n)*sqrt(127)));
G = G(:);
for i = 1:length(G)
  if G(i) < 0
    G(i) = 0;
  elseif G(i) > 255
    G(i) = 255
  end
end
G = reshape(G,m,n);
displayData(G);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% blurredDigits
blurredDigits = zeros(30,400);
for i = 1:10
  blurredDigits(i,:) = blurDigit(graydigits(i,:));
  scaledgray = scaleDigit(A((i-1)*500+1,:),2)*127;
  blurredDigits(i+10,:) = blurDigit(scaledgray);
  scaledgray = scaleDigit(A((i-1)*500+1,:),3)*127;
  blurredDigits(i+20,:) = blurDigit(scaledgray);
end

theta = pi/6;
temp = rotate(A(1,:),theta);
temp = temp*127;
temp = addnoise(temp,127);
displayData(blurredDigits);
  
  
  
  
  
  