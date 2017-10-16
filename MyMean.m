function [mn] = MyMean(X)
    [M N] = size(X);
    mn = zeros(1, N);
    for i=1:N
        for j= 1:M
            mn(i) = mn(i) + X(j,i);
        end
        mn(i) = mn(i)/M;
    end
end

