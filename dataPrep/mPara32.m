function mParam = mPara32(norm, eleAmount)
% function provides MATLAB with parameters of the geomety, electrical parameters
% and electrode positions for a given EIT observation.
%
% input norm is a number to normalize geometry parameters. 
% normed = original * ( 1 / norm factor)
%
% eleAmount regulates the number of electrodes in the system

mParam.elecFirst  = 01;
mParam.elecLast   = eleAmount;
mParam.iAmp       = 1 * 10^(-3);
mParam.iVal       = 'Amp';

mParam.beltH      = 7 * 10^(-3);

mParam.elecHei      = 2.5 * 10^(-3);
mParam.elecRad      = 10  * 10^(-3);
mParam.elecRes      = 2000; %ohms

mParam.sigma.lung = 0.27161; %S/m
mParam.sigma.heart= 0.70292;
mParam.sigma.softT= 0.3494;
mParam.sigma.agagcl=61.6e6;

mParam.thorR      = 315 * 10^(-3);
mParam.thorH      = 450 * 10^(-3);

mParam.maxNoise   = 3.6 * 10^(-6); % uV
mParam.muxNoise   = 0.07;

mParam.heart.R           = 50 * 10^(-3);
mParam.heart.offsetX     = 0.075;
mParam.heart.offsetY     = -0.01;
mParam.heart.offsetZ     = 0 + mParam.thorH/2 + 0.07;

mParam.lung.left.Wdth    = 145 * 10^(-3);
mParam.lung.left.H       = 218 * 10^(-3);
mParam.lung.left.offsetX = 0.09 - mParam.heart.offsetX;
mParam.lung.left.offsetY = -0.17 - mParam.heart.offsetY;
mParam.lung.left.offsetZ = -0.07 + mParam.heart.offsetZ;

mParam.lung.right.Wdth   = 149 * 10^(-3);
mParam.lung.right.H      = 213 * 10^(-3);
mParam.lung.right.offsetX = 0.175 - mParam.heart.offsetX;
mParam.lung.right.offsetY = 0.115 - mParam.heart.offsetY;
mParam.lung.right.offsetZ = -0.07 + mParam.heart.offsetZ;

mParam.heart.R           = 50 * 10^(-3);
mParam.heart.offsetX     = -mParam.heart.offsetX;
mParam.heart.offsetY     = -mParam.heart.offsetY;
mParam.heart.offsetZ     = 0 + mParam.thorH/2 + 0.07;
%%
mParam.nFactor = 1 / norm;
%%
mParam.norm.thorH = mParam.nFactor * mParam.thorH;
mParam.norm.thorR = mParam.nFactor * mParam.thorR;

mParam.norm.elecHei = mParam.nFactor * mParam.elecHei;
mParam.norm.elecRad = mParam.nFactor * mParam.elecRad;
mParam.norm.beltH = mParam.nFactor * mParam.beltH;

mParam.norm.lung.left.H    = mParam.nFactor * mParam.lung.left.H;
mParam.norm.lung.left.Wdth = mParam.nFactor * mParam.lung.left.Wdth;
mParam.norm.lung.left.offsetX = mParam.nFactor * mParam.lung.left.offsetX;
mParam.norm.lung.left.offsetY = mParam.nFactor * mParam.lung.left.offsetY;
mParam.norm.lung.left.offsetZ = mParam.nFactor * mParam.lung.left.offsetZ;

mParam.norm.lung.right.H    = mParam.nFactor * mParam.lung.right.H;
mParam.norm.lung.right.Wdth = mParam.nFactor * mParam.lung.right.Wdth;
mParam.norm.lung.right.offsetX = mParam.nFactor * mParam.lung.right.offsetX;
mParam.norm.lung.right.offsetY = mParam.nFactor * mParam.lung.right.offsetY;
mParam.norm.lung.right.offsetZ = mParam.nFactor * mParam.lung.right.offsetZ;

mParam.norm.heart.R = mParam.nFactor * mParam.heart.R;
mParam.norm.heart.offsetX = mParam.nFactor * mParam.heart.offsetX;
mParam.norm.heart.offsetY = mParam.nFactor * mParam.heart.offsetY;
mParam.norm.heart.offsetZ = mParam.nFactor * mParam.heart.offsetZ;

