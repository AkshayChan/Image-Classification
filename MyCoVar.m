function covar = MyCoVar(X)
    x_mean = MyMean(X);
    Y = bsxfun(@minus,X,x_mean);
    [N , ~] = size(Y);
    covar = 1/(N) * (Y' *  Y);
end

        
