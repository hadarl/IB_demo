function [pXhat_X, pY_Xhat] = IB_demo(pXY, beta, p0Xhat_X)
%{
%% Example: 
% Constructing the joint distribution p(x,y)
pXY = [9:-1:1; 1:9]'
[xDim, yDim] = size(pXY);
pXY = pXY/sum(pXY(:))
figure; 
imagesc(pXY')
xlabel('x')
ylabel('y')
beta = 100;
p0Xhat_X = eye(xDim);
% p0Xhat_X = ones(xDim)/xDim;

%}
%%

[pXhat_X, pY_Xhat, L] = IB_iteration_demo(pXY, beta, p0Xhat_X);

LIB = zeros(10,1);
curr_dif =100;
InfoXXhat = zeros(10,1);
InfoXhatY = zeros(10,1);

i=1;
while curr_dif>0.000001
    LIB(i) = L;
    [InfoXXhat(i), InfoXhatY(i)] = info_curve_point_demo(pXhat_X, pY_Xhat,pXY);
    Lprev = L;
    pXhat_X_prev = pXhat_X;
    [pXhat_X, pY_Xhat, L] = IB_iteration_demo(pXY, beta, pXhat_X_prev);
    curr_dif = abs(L-Lprev);
    i = i +1;
end

LIB(i)=L;
[InfoXXhat(i), InfoXhatY(i)] = info_curve_point_demo(pXhat_X, pY_Xhat,pXY);

%%
%{
figure;
plot(LIB(1:i))
figure;
plot(InfoXXhat(1:i))
hold on
plot(InfoXhatY(1:i),'k')
plot(InfoXXhat(1:i) - beta*InfoXhatY(1:i),'r')

%}