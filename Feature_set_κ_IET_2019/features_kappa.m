function  F = features_kappa( img )
% *************************************************************************
%  This function calculates the kappa based feature for median filtering (MF) detection.
%  Matlab version: 2016b)
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
%  The F feature set is 23 dimensional feature set.
%  1. 18 features from kappa histogram bin heights.
%  2. 4 features from moments of kappa vector.
%  3. 1 feature from number of NaN blocks.
% -------------------------------------------------------------------------
%  Example:
%    img = imread('Lena.bmp'); % read image
%    F = features_kappa(img); % features
%    
% *************************************************************************

% convert data type to 'double' when necessary
if(size(img,3)==3)
        img=rgb2gray(img);
    end
if(~strcmp(class(img),'double'))
    img = double(img);
end
img=img-medfilt2(img,[3 3]);
    p=1;%no. of block initialization
    t=1;%index of org image skewness excluding nan blocks
    
    l=1;%index of org image kurtosis excluding nan blocks
    
    y=1;%index of org image kurtosis excluding nan blocks
    
    nblksk=0;%no. of blocks remaining after nan skewness block removal
    nblkku=0;%no. of blocks remaining after nan kurtosis block removal
      
   %org image variables
   n_nansko=0;
   n_nankuo=0;
   n_nankao=0;
   Imo_b=img;
[mo,no]=size(Imo_b);%original size of images before zero padding
    
 
win_sz=3;
x=win_sz-1;


   
tn_blk=0;
for i=1:x:mo
  for j=1:x:no
      tn_blk=tn_blk+1;
  end
end
for i=1:x:(mo-2)
     for j=1:x:(no-2)
        if(p>tn_blk)
            break
        end
           
          %org image moment calculation
            blk_sel=Imo_b(i:i+(win_sz-1),j:j+(win_sz-1));
            sko(p)=skewness(blk_sel(:));
            kuo(p)=kurtosis(blk_sel(:));          
           p=p+1;
     end
end
p=1;
   for p=1:length(sko)
     if(isnan(sko(p)))
                 n_nansko=n_nansko+1;
               else
                sko_n(t)=sko(p);
                t=t+1;
                nblksk=nblksk+1;
      end
   end
         
     for p=1:length(kuo)
             if((~isnan(kuo(p))))
                 kuo_n(l)=kuo(p);
                 l=l+1;
                 nblkku=nblkku+1;
             end
             if(isnan(kuo(p)))
                 n_nankuo=n_nankuo+1;
             end
      end
    
  kao=((sko_n.^2).*((kuo_n+3).^2))./(4.*(4.*kuo_n-3.*(sko_n.^2)).*(2.*kuo_n-3.*(sko_n.^2)-6));
  
  
  for i=1:length(kao)
  if(isnan(kao(i)))
      n_nankao=n_nankao+1;
  else
      kao_n(y)=kao(i);
          y=y+1;
       end
  end
  
 y=1;
  
  for i=1:length(kao_n)
      if(kao_n(i)>-2 && kao_n(i)<1)
          kao_new(y)=kao_n(i);
          y=y+1;
      end
  end
  
 nblkkao=length(kao_new);   
 f1o=mean(kao_n);
 f2o=var(kao_n);
 f3o=skewness(kao_n);
 f4o=kurtosis(kao_n);
 n_nanskewo=n_nansko;
 [n1,x1]=hist(kao_new,18);
 h_allo(1:18)=n1(1:18);
 
F=[h_allo f1o f2o f3o f4o n_nanskewo];

 end

