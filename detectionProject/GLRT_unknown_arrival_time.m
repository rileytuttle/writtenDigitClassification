%%GLRT unknown arrival time
%% calculate the test statistic
Z = C;
[m,n] = size(Z);

Tx = zeros(m,11); % 11 is the control where we test against empty data;
%Tx(:,11) = emptyTestData*graydigits(1,:)'- .5*emptyTestData.*emptyTestData';
%loop through for every digit
for i = 1:size(Tx,2)-1
  temp1 = zeros(m,1);
  temp2 = temp1;
  %loop through every x shift
  for shiftx = 1:16
    %loop through every y shift
    for shifty = 1:16
      shifted = translate(graydigits(i,:),shiftx-8,shifty-8);
      temp1 = Z*shifted';
      temp1 = temp1 - (.5*shifted*shifted');
      temp2 = max([temp1, temp2], [], 2);
    end
  end
  Tx(:,i) = temp2;
end
guess = zeros(m,10);
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
error = 100*sum(abs(guess-truth)(:))/m;
disp(sprintf("error rate = %d%%",error));