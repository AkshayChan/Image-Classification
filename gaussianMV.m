function y = gaussianMV(mu, covar, X)

    [n , d ] = size(X);
    [j , k] = size(covar);
    
    % Check that the covariance matrix is the correct dimension
    if (( j~= d | k ~= d))
        error('Dimension of covariance matrix and data should match');
    end
    invcov = inv(covar);
    
    % mu = reshape(mu, 1, d);
    % Ensure that mu is a row vector
    % Replicate mu and subtract from each data point
    
    X = X - ones(n, 1)*mu;
    fact = sum(((X*invcov).*X),2);
    y = exp(-0.5*fact);
    y = y./sqrt((2*pi)^d*det(covar));
end