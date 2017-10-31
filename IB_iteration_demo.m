function [pXhat_X, pY_Xhat, L] = IB_iteration_demo(pXY, beta, p0Xhat_X)

yDim = size(pXY,2);
xDim = size(pXY, 1); 

pX = sum(pXY,length(size(pXY)));

p0Xhat = pX'*p0Xhat_X';

%Bayes:
p0X_Xhat = (p0Xhat_X.*repmat(pX',[xDim 1])./repmat(p0Xhat',[1 xDim]))';

pY_X = (pXY./repmat(pX,[1 yDim]))';
p0Y_Xhat = pY_X * p0X_Xhat;

DKL_X_Xhat = zeros(xDim);
for i = 1:xDim
    for j = 1:xDim
%         DKL_X_Xhat = DKL_matrix(pY_X,pY_Xhat);
        DKL_X_Xhat(i,j) = DKL2_demo(pY_X(:,i),p0Y_Xhat(:,j));
    end
end

unnorm_pXhat_X = repmat(p0Xhat,[length(pX) 1]).*exp(-beta*DKL_X_Xhat);
% different rows correspond to different Xhats:
unnorm_pXhat_X = unnorm_pXhat_X';

ZX_beta = ones(length(pX)) * unnorm_pXhat_X;
% remark: we could use ones(1,length(pX)) and then replicate for the next
% operation.
pXhat_X = unnorm_pXhat_X./ZX_beta;

%Bayes:
pXhat = pX'*pXhat_X';
pX_Xhat = (pXhat_X.*repmat(pX',[xDim 1])./repmat(pXhat',[1 xDim]))';
pY_Xhat = pY_X * pX_Xhat;

[IX_Xhat, IXhat_Y] = info_curve_point_demo(pXhat_X, pY_Xhat, pXY);
L = IX_Xhat - beta*IXhat_Y;






%{
function [pXhat_X, pY_Xhat, L] = IB_iteration_demo(pXY, beta, p0Xhat_X)

pX = sum(pXY,length(size(pXY)));

yDim = size(pXY,2);
xDim = size(pXY, 1); 

pXhat = pX'*p0Xhat_X';

%Bayes:
pX_Xhat = (p0Xhat_X.*repmat(pX',[xDim 1])./repmat(pXhat',[1 xDim]))';

pY_X = (pXY./repmat(pX,[1 yDim]))';
pY_Xhat = pY_X * pX_Xhat;

DKL_X_Xhat = zeros(xDim);
for i = 1:xDim
    for j = 1:xDim
%         DKL_X_Xhat = DKL_matrix(pY_X,pY_Xhat);
        DKL_X_Xhat(i,j) = DKL2_demo(pY_X(:,i),pY_Xhat(:,j));
    end
end

%repmat(pXhat,[length(pX) 1])
unnorm_pXhat_X = repmat(pXhat,[length(pX) 1]).*exp(-beta*DKL_X_Xhat);
% different rows correspond to different Xhats:
unnorm_pXhat_X = unnorm_pXhat_X';

ZX_beta = ones(length(pXhat)) * unnorm_pXhat_X;
% remark: we could use ones(1,length(pX)) and then replicate for the next
% operation.
pXhat_X = unnorm_pXhat_X./ZX_beta;

[IX_Xhat, IXhat_Y] = info_curve_point_demo(pXhat_X, pY_Xhat, pXY);
L = IX_Xhat - beta*IXhat_Y;

%}


