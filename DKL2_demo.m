function [DKL_sum] = DKL2_demo(p,q)

p = p(:);
q = q(:);

DKL_sum = sum(p.*log2(p./q));