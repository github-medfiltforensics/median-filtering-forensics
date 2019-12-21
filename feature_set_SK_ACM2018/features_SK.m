function  F = features_SK( img )
% *************************************************************************
%  This function calculates the SK feature for median filtering (MF) detection.
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
%  The SK feature set is 19 dimensional feature set.
%  1. 9 features from skewness histogram bin haights.
%  2. 4 features from kurtosis histogram bin heights.
%  3. 5 features from 1st,2nd and fourth moments of skewness data and 1st
%  and 2nd moments of kurtosis data.
%  4. 1 feature from number of NaN blocks.
% -------------------------------------------------------------------------
%  Example:
%    img = imread('Lena.bmp'); % read image
%    F = features_SK(img); % SK features
%    
% *************************************************************************

% % test time
% tic
%load('C:\divya\min_DN_orgvsmf3C.mat');
%load('C:\divya\max_DN_orgvsmf3C.mat');
%min_val=min_DN_32orgvsmf3C;
%max_val=max_DN_32orgvsmf3C;
% convert data type to 'double' when necessary
 if(size(img,3)==3)
        img=rgb2gray(img);
    end

if(~strcmp(class(img),'double'))
    img = double(img);
end


p=1;
t=1;
l=1;
q=1;
idx=1;
idx2=1;
tn_blk=0;%total number of blocks in image
nblk_skew=0;%no. of blocks in image after removal of NaN skewness blocks
nblk_kurt=0;% no. of blocks in image after removal of NaN kurtosis blocks
n_nanskew=0;% no. of blocks having NaN skewness
n_nankurt=0;%no. of blocks having NaN kurtosis
[m,n]=size(img);%original size of images before zero padding
for i=1:m
        for j=1:n
            tn_blk=tn_blk+1;
        end
end
for i=1:(m-2)
        for j=1:(n-2)
           if(p>tn_blk)
               break
           end
blk_sel=img(i:(i+2),j:(j+2));
skew_blk(p)=skewness(blk_sel(:));
kurt_blk(p)=kurtosis(blk_sel(:));
if(~isnan(skew_blk(p)))
    skew_remnan(t)=skew_blk(p);
    t=t+1;
    nblk_skew=nblk_skew+1;
end
if(~isnan(kurt_blk(p)))
    kurt_remnan(l)=kurt_blk(p);
    l=l+1;
    nblk_kurt=nblk_kurt+1;
end
if(isnan(skew_blk(p)))
    n_nanskew=n_nanskew+1;
    
end
if(isnan(skew_blk(p)))
    
    n_nankurt=n_nankurt+1;
end

p=p+1;
        end 
end

if (all(isnan(skew_blk)))
       mean_sk=0;
       var_sk=0;
       kurt=0;
       mid_pk=0;
       skr_1pk=0;
       skl_1pk=0;
       skr_2pk=0;
       skl_2pk=0;
       skr_3pk=0;
       skl_3pk=0;
       skl_4pk=0;
       skr_4pk=0;
       n_nanskew=tn_blk;
  
else if (all(isnan(kurt_blk)))
        ku_1pk=0;
       ku_2pk=0;
       ku_3pk=0;
       ku_4pk=0;
       mean_ku=0;
       var_ku=0;
    
else
  
  
n_binskew=1+ceil(log2(nblk_skew));
   sigma=(6*(nblk_kurt-2)/(nblk_kurt+1)*(nblk_kurt+3))^(1/2);
   n_binkurt=1+ceil(log2(nblk_kurt)+log2(1+(abs(skewness(kurt_remnan)))/sigma));
   if(isnan(n_binkurt))
       n_binkurt=n_binskew;
   end
 [n1,x1]=hist(skew_remnan,n_binskew);
 [n3,x3]=hist(kurt_remnan,n_binkurt);
 
if(n_binskew==1)
     [N1,edges1]=histcounts(skew_remnan,1);
     bin_wsk=edges1(2)-edges1(1);
else
     bin_wsk=x1(length(x1))-x1(length(x1)-1);
end

 if(n_binkurt==1)
     [N3,edges3]=histcounts(kurt_remnan,1);
     bin_wku=edges3(2)-edges3(1);
 else
     bin_wku=x3(2)-x3(1);
 end
 mean_sk=mean(skew_remnan);
 var_sk=var(skew_remnan);
 kurt=kurtosis(skew_remnan);
 for i=1:length(x1)
      if(((fix((x1(i)+bin_wsk/2)*(10^4))/(10^4))>=2.4748) && ((fix((x1(i)-bin_wsk/2)*(10^4))/(10^4))<=2.4748))
          skr_4pk=n1(i); 
      end
 end
  for i=1:length(x1)
     if(((fix((x1(i)+bin_wsk/2)*(10^4))/(10^4))>=-2.4748) && ((fix((x1(i)-bin_wsk/2)*(10^4))/(10^4))<=-2.4748))
          skl_4pk=n1(i);
      end
  end
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsk/2)*(10^4))/(10^4))>=0.0000) && ((fix((x1(i)-bin_wsk/2)*(10^4))/(10^4))<=0.0000))
          mid_pk=n1(i);
      end
  end
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsk/2)*(10^4))/(10^4))>=1.3363) && ((fix((x1(i)-bin_wsk/2)*(10^4))/(10^4))<=1.3363))
          skr_1pk=n1(i);
      end
  end
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsk/2)*(10^4))/(10^4))>=-1.3363) && ((fix((x1(i)-bin_wsk/2)*(10^4))/(10^4))<=-1.3363))
          skl_1pk=n1(i);
      end
  end
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsk/2)*(10^4))/(10^4))>=0.7071) && ((fix((x1(i)-bin_wsk/2)*(10^4))/(10^4))<=0.7071))
          skr_2pk=n1(i);
      end
  end
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsk/2)*(10^4))/(10^4))>=-0.7071) && ((fix((x1(i)-bin_wsk/2)*(10^4))/(10^4))<=-0.7071))
          skl_2pk=n1(i);
      end
  end
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsk/2)*(10^4))/(10^4))>=0.2236) && ((fix((x1(i)-bin_wsk/2)*(10^4))/(10^4))<=0.2236))
          skr_3pk=n1(i);
      end
  end
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsk/2)*(10^4))/(10^4))>=-0.2236) && ((fix((x1(i)-bin_wsk/2)*(10^4))/(10^4))<=-0.2236))
          skl_3pk=n1(i);
      end
  end
  n_nansk=n_nanskew;
  
  for i=1:length(x3)
      if(((fix((x3(i)+bin_wku/2)*(10^4))/(10^4))>=2.7857) && ((fix((x3(i)-bin_wku/2)*(10^4))/(10^4))<=2.7857))
          ku_1pk=n3(i);
      end
  end
  for i=1:length(x3)
       if(((fix((x3(i)+bin_wku/2)*(10^4))/(10^4))>=1.5000) && ((fix((x3(i)-bin_wku/2)*(10^4))/(10^4))<=1.5000))
          ku_2pk=n3(i);
      end
  end
  for i=1:length(x3)
    if(((fix((x3(i)+bin_wku/2)*(10^4))/(10^4))>=1.0500) && ((fix((x3(i)-bin_wku/2)*(10^4))/(10^4))<=1.0500))
          ku_3pk=n3(i);
    end
  end
  for i=1:length(x3)
      if(((fix((x3(i)+bin_wku/2)*(10^4))/(10^4))>=7.1249) && ((fix((x3(i)-bin_wku/2)*(10^4))/(10^4))<=7.1249))
          ku_4pk=n3(i);
      end
  end
  mean_ku=mean(kurt_remnan);
  var_ku=var(kurt_remnan);
end
  
  F=[skl_4pk skr_4pk mean_sk var_sk kurt mid_pk skr_1pk skl_1pk skr_2pk skl_2pk skr_3pk skl_3pk n_nansk ku_1pk ku_2pk ku_3pk ku_4pk mean_ku var_ku]; 
end

