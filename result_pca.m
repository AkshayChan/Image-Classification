load('/afs/inf.ed.ac.uk/group/teaching/inf2b/cwk2/d/s1558717/train_data.mat')

train_x = double(train_x)/256;
train_x = reshape(train_x,size(train_x,1),[]);

[Evecs, Evals] = compute_pca(train_x);

Evals_max = [];
Evecs_max = [];

for i=1:10
    Evals_max(i) = Evals(i);
    Evecs_max(:, i) = Evecs(:,i);
end

save('evals.mat', 'Evals_max');
save('evecs.mat', 'Evecs_max');