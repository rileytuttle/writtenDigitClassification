% use a replica correlator to attempt to detect t_test
% start with data that was colored (B)
load('DetectionProjectData.mat')
%% calculate the test statistic
Z = B;
[m,n] = size(Z);
Tx = zeros(5000,11); % 11 is the control where we test against empty data;
%Tx(:,11) = emptyTestData*graydigits(1,:)'- .5*emptyTestData.*emptyTestData';
for i = 1:size(Tx,2)-1
  Tx(:,i) = Z*graydigits(i,:)';
  Tx(:,i) = Tx(:,i) - (.5*graydigits(i,:)*graydigits(i,:)');
end
guess = zeros(m,10);
[temp1, temp2] = max(Tx, [], 2);
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