% import and process data

load('/afs/inf.ed.ac.uk/group/teaching/inf2b/cwk2/d/s1558717/train_data.mat')
train_x = double(train_x)/256;
train_x = reshape(train_x,size(train_x,1),[]);

% Reduce the dimentionality;

[Evecs , Evals] = compute_pca(train_x);
train_x100 = train_x*Evecs(:,1:100);

% Get the dimensions of the data

[N , D] = size(train_x100);

% Variable declarations 

class = 5;
means = zeros(class,D);
covariance = zeros(D,D,class);
prior = zeros(1,class);
determinant = zeros(class, 1);

% loop for each of the clases 

for i = 1 : class
    data = train_x100(train_y == i,:);
    [n,d] = size(data);
    data = double(data);
    prior(i) = n/N;
    means(i,:) = MyMean(data);
    covariance(:,:,i) = MyCoVar(data);
    determinant(i) = det(covariance(:,:,i));
    if( means(i,:) == MyMean(data) )
        fprintf('Correct mean for class [%d]\n',i);
    end
    if( covariance(:,:,i) == MyCoVar(data))
        fprintf('Correct covariance for class [%d]\n',i);
    end
end

% import and preprocess data
load('/afs/inf.ed.ac.uk/group/teaching/inf2b/cwk2/d/s1558717/test_data.mat');
test_x = double(test_x)/256;
test_x = reshape(test_x,size(test_x,1),[]);

% Reduce the test data dimensionality;

test_x_100 = test_x*Evecs(:,1:100);

% Get the dimensions of the test data

[N , D] = size(test_x_100);
test_prob = zeros(N,class);

% Calculate the probabilities

for i  = 1 : class
        prob = gaussianMV(means(i,:),covariance(:,:,i),test_x_100);
        test_prob(:,i) = prob*prior(i);
end

[max_out, idx] = max(test_prob, [], 2);
confmatrix = zeros(5);
classification = 0;
  
for i = 1 :N
    confmatrix(test_y(i),idx(i)) = confmatrix(test_y(i),idx(i))+1;
end

for i = 1:5
    classification = classification + confmatrix(i,i);
end

classification = classification*100/N;  
classification

save('confmat_d100.mat','confmatrix');
        
    