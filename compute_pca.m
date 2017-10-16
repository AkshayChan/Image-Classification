function [EVecs , EVals] = compute_pca(X)

        N = length(X);
        x_mean = MyMean(X); % Mean for each column
        x = bsxfun(@minus,X,x_mean); % Mean shift the original matrix
        covar_m = 1/(N-1) * (x' *  x);
        
        % For finding the eigenvectors and eigenvalues
        [EVecs EVals] = eig(covar_m);
        EVals = diag(EVals);
        
        % Sorting in descending order
        [EVals I] = sort(EVals, 1, 'descend');
        EVecs = EVecs(:,I);

        for i = 1 : length(EVecs)
            if EVecs(1,i) < 0
                EVecs(:,i) = EVecs(:,i).*(-1);
            end
        end
        
end
