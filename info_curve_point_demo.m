function [IX_Xhat, IXhat_Y] = info_curve_point_demo(pXhat_X, pY_Xhat, pXY)

[xDim,  yDim] = size(pXY);

pX = sum(pXY,2);
pXhatX = pXhat_X.*repmat(pX',[xDim 1]);
pXhat = pX'*pXhat_X';
IX_Xhat = DKL2_demo(pXhatX,pXhat'*pX');

pYXhat = pY_Xhat.*repmat(pXhat,[yDim 1]);
pY = pXhat*pY_Xhat';
IXhat_Y = DKL2_demo(pYXhat,pY'*pXhat);






