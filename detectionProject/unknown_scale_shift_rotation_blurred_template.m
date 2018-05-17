%%GLRT unknown arrival time and size and rotation using blurred template
%% calculate the test statistic
Z = X(1:end,:);
[m,n] = size(Z);

Tx = zeros(m,11); % 11 is the control where we test against empty data;
%Tx(:,11) = emptyTestData*graydigits(1,:)'- .5*emptyTestData.*emptyTestData';
%loop through for every digit
for i = 1:size(Tx,2)-1
  temp1 = zeros(m,1);
  temp2 = temp1;
  for scale = 1:3
    scaled = scaleDigit(A((i-1)*500 + 1,:),scale);
%    scaled = blurredDigits((scale-1)*10+i,:);
    for theta = linspace(-pi/4,pi/4,25)
      rotated = rotate(scaled,theta);
      %loop through every x shift
      for shiftx = 1:16
        %loop through every y shift
        for shifty = 1:16
          shifted = translate(rotated,shiftx-8,shifty-8);
          shifted = shifted*127;
          blurred = blurDigit(shifted);
          temp1 = Z*blurred';
          temp1 = temp1 - (.5*blurred*blurred');
          temp2 = max([temp1, temp2], [], 2);
        end
      end
    end
  end
  Tx(:,i) = temp2;
end
guess = zeros(m,10);
errors = 0;
[temp1, temp2] = max(Tx, [], 2); % find maximum digit for each trial
%loop through for every trial
for i = 1:m
  guess(i,temp2(i)) = 1;
end
for i = 1:m
  if(sum(abs(guess(i,:) - truth(i,:))) != 0)
    errors = errors+1;
  end
end
error = 100*errors/m;
disp(sprintf("error rate = %d%%",error));