%%GLRT unknown arrival time
%% calculate the test statistic
Z = E;
[m,n] = size(Z);

Tx = zeros(m,11); % 11 is the control where we test against empty data;
%Tx(:,11) = emptyTestData*graydigits(1,:)'- .5*emptyTestData.*emptyTestData';
%loop through for every digit
for i = 1:size(Tx,2)-1
  temp1 = zeros(m,1);
  temp2 = temp1;
  %loop through every size
  for scale = 1:3
    scaled = scaleDigit(A((i-1)*500 + 1,:),scale);
    temp1 = Z*(scaled*127)';
    temp1 = temp1 - (.5*(scaled*127)*(scaled*127)');
    temp2 = max([temp1,temp2],[],2);
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
error = 100*errors/m;
disp(sprintf("error rate = %d%%",error));