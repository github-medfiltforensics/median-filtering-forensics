function [F] = func_p3glbl(img)
% *************************************************************************
%  This function calculates the GDCTF feature set for median filtering (MF) detection.
%  Matlab version: 2016b
% -------------------------------------------------------------------------
%  
% 
% -------------------------------------------------------------------------
%  Input: 
%    img .... input image (one channel)
%        
% ------------------------------------------------------------------------- 
%  Output:
%        F .... resulting feature
% -------------------------------------------------------------------------
%  Notes:
%  The GDCTF feature set is 4 dimensional feature set.
% 
%  4 features from four first order moments of DCT matrix of image residual.
% 
% -------------------------------------------------------------------------
%  Example:
%    img = imread('Lena.bmp'); % read image
%    F = features_GDCTF(img); % GDCTF features
%    
% *************************************************************************
if(size(img,3)==3)
        img=rgb2gray(img);
    end 
img=medfilt2(img,[3 3])-img;  
  A=dct2(double(img));
  A0=mean(A(:));
  A1=var(A(:));
  A2=skewness(A(:));
  A3=kurtosis(A(:));
  F=[A0 A1 A2 A3];
end

