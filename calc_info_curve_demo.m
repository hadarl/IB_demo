% calc_info_curve_demo(pXY, betaVec)

pXY = [9:-1:1; 1:9]'
pXY = pXY/sum(pXY(:))
figure; 
imagesc(pXY')
xlabel('x')
ylabel('y')

n = 30;
betaVec = logspace(0,3,n); %logspace ( power of min beta, power of max beta, number of beta values )
Info = zeros(n,2);
xDim =size(pXY,1);
p0Xhat_X = eye(xDim);
% p0Xhat_X = ones(xDim)/xDim;

for i = n:-1:1   
    [pXhat_X, pY_Xhat] = IB_demo(pXY,betaVec(i),p0Xhat_X);       
    [Info(i,1), Info(i,2)] = info_curve_point_demo(pXhat_X, pY_Xhat,pXY);
    p0Xhat_X = pXhat_X;   
    imagesc(pXhat_X)
    pause(0.1);
end


figure;
plot(betaVec,Info(:,1))
title('I(X;Xhat)');

figure;
plot(betaVec,Info(:,2))
title('I(Xhat;Y)');

figure;
plot(Info(:,1),Info(:,2))
title('I(Xhat;Y) as a function of I(X;Xhat)');

