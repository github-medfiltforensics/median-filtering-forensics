close all;
win_sz=3;
px_ol=2;
r_req=64;
c_req=64;
h=(ones(win_sz))/(win_sz*win_sz);
Imofiles=dir('C:\divya\databases\combined_database\com32_all\*.tif');
Immffiles=dir('C:\divya\databases\combined_database\com32_35\*.tif');
count=length(Imofiles);
label=[ones(count,1);2*ones(count,1)];

skr_1pko=zeros(1,count);
skl_1pko=zeros(1,count);
skr_2pko=zeros(1,count);
skl_2pko=zeros(1,count);
skr_3pko=zeros(1,count);
skl_3pko=zeros(1,count);
skr_1pkmf=zeros(1,count);
skl_1pkmf=zeros(1,count);
skr_2pkmf=zeros(1,count);
skl_2pkmf=zeros(1,count);
skr_3pkmf=zeros(1,count);
skl_3pkmf=zeros(1,count);
skl_4pko=zeros(1,count);
skr_4pko=zeros(1,count);
skl_4pkmf=zeros(1,count);
skr_4pkmf=zeros(1,count);
mid_pko=zeros(1,count);
mid_pkmf=zeros(1,count);
ku_1pko=zeros(1,count);
ku_2pko=zeros(1,count);
ku_3pko=zeros(1,count);
ku_4pko=zeros(1,count);
ku_1pkmf=zeros(1,count);
ku_2pkmf=zeros(1,count);
ku_3pkmf=zeros(1,count);
ku_4pkmf=zeros(1,count);
%mlo_logistic=zeros(count,2);
%ml_logistic=zeros(count,2);
%ml_lognormal=zeros(count,2);
%mlo_lognormal=zeros(count,2);
%skewpklo=zeros(count,3);
%skewpkro=zeros(count,3);
%skewpkl_mf=zeros(count,3);
%skewpkr_mf=zeros(count,3);
%kurtpko=zeros(count,1);
%kurtpk_mf=zeros(count,1);
for t=1:count
    display(t)
    p=1;
    q=1;
    l=1;
    clear Imo Imo_bn Imo_b Immf Immf_bn Immf_b
    Imo=strcat('C:\divya\databases\combined_database\com32_all\',Imofiles(t).name);
    Imo_bn=imread(Imo);
    if(size(Imo_bn,3)==3)
        Imo_bn=rgb2gray(Imo_bn);
    end
    Imo_b=double((Imo_bn));
    Immf=strcat('C:\divya\databases\combined_database\com32_35\',Immffiles(t).name);
    Immf_bn=imread(Immf);
    %Immf_b=medfilt2(Imo_b,[5 5]);
    %imwrite(uint8(Immf_bn),'test15.jpg','Quality',90);
    %Immf_bn=imread('test15.jpg');
    %Immf_bn=imread('C:\divya\ucid_5x5\ucid00301.tif');
   % Imo_b=double(rgb2gray(Imo_bn));
    Immf_b=double(Immf_bn);
    [skeworemnan3x3o,skewmf3x3remnan3x3o,kurtoremnan3x3o,kurtmf3x3remnan3x3o,novblk_remnanskew,novblk_remnankurt,n_nanskewo,n_nanskewmf,n_nankurto,n_nankurtmf,chk_skew,chk_kurt]=Cal_o_n_mf_ovrblk_moments(Imo_b,Immf_b,win_sz,px_ol);
if(chk_skew==1)
      % pk_diffol(t)=0;
      % pk_diffor(t)=0;
      % pk_diffl(t)=0;
      % pk_diffr(t)=0;
       mean_sko(t)=0;
       var_sko(t)=0;
       mean_skmf(t)=0;
       var_skmf(t)=0;
       kurto(t)=0;
       kurtmf(t)=0;
       mid_pko(t)=0;
       mid_pkmf(t)=0;
       skr_1pko(t)=0;
       skl_1pko(t)=0;
       skr_2pko(t)=0;
       skl_2pko(t)=0;
       skr_3pko(t)=0;
       skl_3pko(t)=0;
       skr_1pkmf(t)=0;
       skl_1pkmf(t)=0;
       skr_2pkmf(t)=0;
       skl_2pkmf(t)=0;
       skr_3pkmf(t)=0;
       skl_3pkmf(t)=0;
       skl_4pko(t)=0;
       skr_4pko(t)=0;
       skl_4pkmf(t)=0;
       skr_4pkmf(t)=0;
       n_nansko(t)=n_nanskewo;
       
   end
 if(chk_kurt==1)
       ku_1pko(t)=0;
       ku_2pko(t)=0;
       ku_3pko(t)=0;
       ku_4pko(t)=0;
       ku_1pkmf(t)=0;
       ku_2pkmf(t)=0;
       ku_3pkmf(t)=0;
       ku_4pkmf(t)=0;
       mean_kuo(t)=0;
       mean_kumf(t)=0;
       var_kuo(t)=0;
       var_kumf(t)=0;
 end
if((chk_skew==0)&&(chk_kurt==0))
  n_binskew(t)=1+ceil(log2(novblk_remnanskew));
   sigma=(6*(novblk_remnankurt-2)/(novblk_remnankurt+1)*(novblk_remnankurt+3))^(1/2);
   n_binkurt(t)=1+ceil(log2(novblk_remnankurt)+log2(1+(abs(skewness(kurtoremnan3x3o)))/sigma));
   
   if(isnan(n_binkurt(t)))
       n_binkurt(t)=n_binskew(t);
   end
  
 [n1,x1]=hist(skeworemnan3x3o,n_binskew(t));
 [n2,x2]=hist(skewmf3x3remnan3x3o,n_binskew(t));
 [n3,x3]=hist(kurtoremnan3x3o,n_binkurt(t));
 [n4,x4]=hist(kurtmf3x3remnan3x3o,n_binkurt(t));
 
%   skeworemnan3x3o=fix(skeworemnan3x3o*(10^4))/10^4;
%   skewmf3x3remnan3x3o=fix(skewmf3x3remnan3x3o*(10^4))/10^4;
%   kurtoremnan3x3o=fix(kurtoremnan3x3o*(10^4))/10^4;
%   kurtmf3x3remnan3x3o=fix(kurtmf3x3remnan3x3o*(10^4))/10^4;
%   x1=fix(x1*(10^4))/10^4;
%   x2=fix(x2*(10^4))/10^4;
%   x3=fix(x3*(10^4))/10^4;
%   x4=fix(x4*(10^4))/10^4;
%   
 if(n_binskew(t)==1)
     [N1,edges1]=histcounts(skeworemnan3x3o,1);
     [N2,edges2]=histcounts(skewmf3x3remnan3x3o,1);
     bin_wsko=edges1(2)-edges1(1);
     bin_wskmf=edges2(2)-edges2(1);
     
 else
     bin_wsko=x1(length(x1))-x1(length(x1)-1);
     bin_wskmf=x2(length(x2))-x2(length(x2)-1);
end
 if(n_binkurt(t)==1)
     [N3,edges3]=histcounts(kurtoremnan3x3o,1);
     [N4,edges4]=histcounts(kurtmf3x3remnan3x3o,1);
     bin_wkuo=edges3(2)-edges3(1);
     bin_wkumf=edges4(2)-edges4(1);
 else
     bin_wkuo=x3(2)-x3(1);
     bin_wkumf=x4(2)-x4(1);
 end
% figure
% hist(skeworemnan3x3o,n_binskew(t));
% figure
% hist(skewmf3x3remnan3x3o,n_binskew(t));
% figure
% hist(kurtoremnan3x3o,n_binkurt(t));
% figure
% hist(kurtmf3x3remnan3x3o,n_binkurt(t));
 %f1
%  pk_diffol(t)=n1(1)-n1(2);
%  pk_diffl(t)=n2(1)-n2(2);
  %f2
%  pk_diffor(t)=n1((numel(n1))-1)-n1(numel(n1));
%  pk_diffr(t)=n2((numel(n2))-1)-n2(numel(n2));
  %f3
  mean_sko(t)=mean(skeworemnan3x3o);
  mean_skmf(t)=mean(skewmf3x3remnan3x3o);
  %f4
  var_sko(t)=var(skeworemnan3x3o);
  var_skmf(t)=var(skewmf3x3remnan3x3o);
  %f5
  kurto(t)=kurtosis(skeworemnan3x3o);
  kurtmf(t)=kurtosis(skewmf3x3remnan3x3o);
  %f1
  for i=1:length(x2)
      if(((fix((x2(i)+bin_wskmf/2)*(10^4))/(10^4))>=2.4748) && ((fix((x2(i)-bin_wskmf/2)*(10^4))/(10^4))<=2.4748))
          %skr_4pko(t)=n1(i);
          skr_4pkmf(t)=n2(i);
%       else
%         %  skr_4pko(t)=0;
%           skr_4pkmf(t)=0;
      end
  end
  
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsko/2)*(10^4))/(10^4))>=2.4748) && ((fix((x1(i)-bin_wsko/2)*(10^4))/(10^4))<=2.4748))
          skr_4pko(t)=n1(i);
          %skr_4pkmf(t)=n2(i);
%       else
%           skr_4pko(t)=0;
%           %skr_4pkmf(t)=0;
      end
  end
  %f2
  for i=1:length(x2)
      if(((fix((x2(i)+bin_wskmf/2)*(10^4))/(10^4))>=-2.4748) && ((fix((x2(i)-bin_wskmf/2)*(10^4))/(10^4))<=-2.4748))
          %skl_4pko(t)=n1(i);
          skl_4pkmf(t)=n2(i);
%       else
%           %skl_4pko(t)=0;
%           skl_4pkmf(t)=0;
      end
  end
  
  for i=1:length(x1)
     if(((fix((x1(i)+bin_wsko/2)*(10^4))/(10^4))>=-2.4748) && ((fix((x1(i)-bin_wsko/2)*(10^4))/(10^4))<=-2.4748))
          skl_4pko(t)=n1(i);
          %skl_4pkmf(t)=n2(i);
%       else
%           skl_4pko(t)=0;
%           %skl_4pkmf(t)=0;
      end
  end
  %f6
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsko/2)*(10^4))/(10^4))>=0.0000) && ((fix((x1(i)-bin_wsko/2)*(10^4))/(10^4))<=0.0000))
          mid_pko(t)=n1(i);
          %mid_pkmf(t)=n2(i);
%       else
%           mid_pko(t)=0;
%          % mid_pkmf(t)=0;
      end
  end
  for i=1:length(x2)
      if(((fix((x2(i)+bin_wskmf/2)*(10^4))/(10^4))>=0.0000) && ((fix((x2(i)-bin_wskmf/2)*(10^4))/(10^4))<=0.0000))
          %mid_pko(t)=n1(i);
          mid_pkmf(t)=n2(i);
%       else
%          % mid_pko(t)=0;
%           mid_pkmf(t)=0;
      end
  end
  %f7
  for i=1:length(x2)
      if(((fix((x2(i)+bin_wskmf/2)*(10^4))/(10^4))>=1.3363) && ((fix((x2(i)-bin_wskmf/2)*(10^4))/(10^4))<=1.3363))
         % skr_1pko(t)=n1(i);
          skr_1pkmf(t)=n2(i);
%       else
%          % skr_1pko(t)=0;
%           skr_1pkmf(t)=0;
      end
  end
  
 for i=1:length(x1)
      if(((fix((x1(i)+bin_wsko/2)*(10^4))/(10^4))>=1.3363) && ((fix((x1(i)-bin_wsko/2)*(10^4))/(10^4))<=1.3363))
          skr_1pko(t)=n1(i);
         % skr_1pkmf(t)=n2(i);
%       else
%           skr_1pko(t)=0;
%          % skr_1pkmf(t)=0;
      end
  end
  %f8
  for i=1:length(x2)
      if(((fix((x2(i)+bin_wskmf/2)*(10^4))/(10^4))>=-1.3363) && ((fix((x2(i)-bin_wskmf/2)*(10^4))/(10^4))<=-1.3363))
         % skl_1pko(t)=n1(i);
          skl_1pkmf(t)=n2(i);
%           else
%           %skl_1pko(t)=0;
%           skl_1pkmf(t)=0;
      end
  end
  
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsko/2)*(10^4))/(10^4))>=-1.3363) && ((fix((x1(i)-bin_wsko/2)*(10^4))/(10^4))<=-1.3363))
          skl_1pko(t)=n1(i);
         % skl_1pkmf(t)=n2(i);
%           else
%           skl_1pko(t)=0;
%           %skl_1pkmf(t)=0;
      end
  end
  %f9
  for i=1:length(x2)
      if(((fix((x2(i)+bin_wskmf/2)*(10^4))/(10^4))>=0.7071) && ((fix((x2(i)-bin_wskmf/2)*(10^4))/(10^4))<=0.7071))
         % skr_2pko(t)=n1(i);
          skr_2pkmf(t)=n2(i);
%           else
%          % skr_2pko(t)=0;
%           skr_2pkmf(t)=0;
      end
  end
  
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsko/2)*(10^4))/(10^4))>=0.7071) && ((fix((x1(i)-bin_wsko/2)*(10^4))/(10^4))<=0.7071))
          skr_2pko(t)=n1(i);
         % skr_2pkmf(t)=n2(i);
%           else
%           skr_2pko(t)=0;
%          % skr_2pkmf(t)=0;
      end
  end
  %f10
  for i=1:length(x2)
      if(((fix((x2(i)+bin_wskmf/2)*(10^4))/(10^4))>=-0.7071) && ((fix((x2(i)-bin_wskmf/2)*(10^4))/(10^4))<=-0.7071))
         % skl_2pko(t)=n1(i);
          skl_2pkmf(t)=n2(i);
%           else
%          % skl_2pko(t)=0;
%           skl_2pkmf(t)=0;
      end
  end
  
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsko/2)*(10^4))/(10^4))>=-0.7071) && ((fix((x1(i)-bin_wsko/2)*(10^4))/(10^4))<=-0.7071))
          skl_2pko(t)=n1(i);
         % skl_2pkmf(t)=n2(i);
%           else
%           skl_2pko(t)=0;
%          % skl_2pkmf(t)=0;
      end
  end
  %f11
  for i=1:length(x2)
      if(((fix((x2(i)+bin_wskmf/2)*(10^4))/(10^4))>=0.2236) && ((fix((x2(i)-bin_wskmf/2)*(10^4))/(10^4))<=0.2236))
         % skr_3pko(t)=n1(i);
          skr_3pkmf(t)=n2(i);
%           else
%          % skr_3pko(t)=0;
%           skr_3pkmf(t)=0;
      end
  end
  
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsko/2)*(10^4))/(10^4))>=0.2236) && ((fix((x1(i)-bin_wsko/2)*(10^4))/(10^4))<=0.2236))
          skr_3pko(t)=n1(i);
         % skr_3pkmf(t)=n2(i);
%           else
%           skr_3pko(t)=0;
%          % skr_3pkmf(t)=0;
      end
  end
  %f12
  for i=1:length(x2)
      if(((fix((x2(i)+bin_wskmf/2)*(10^4))/(10^4))>=-0.2236) && ((fix((x2(i)-bin_wskmf/2)*(10^4))/(10^4))<=-0.2236))
          %skl_3pko(t)=n1(i);
          skl_3pkmf(t)=n2(i);
%           else
%           %skl_3pko(t)=0;
%           skl_3pkmf(t)=0;
      end
  end
  
  for i=1:length(x1)
      if(((fix((x1(i)+bin_wsko/2)*(10^4))/(10^4))>=-0.2236) && ((fix((x1(i)-bin_wsko/2)*(10^4))/(10^4))<=-0.2236))
          skl_3pko(t)=n1(i);
          %skl_3pkmf(t)=n2(i);
%           else
%           skl_3pko(t)=0;
%           %skl_3pkmf(t)=0;
      end
  end
  %f13
  n_nansko(t)=n_nanskewo;
  n_nanskmf(t)=n_nanskewmf;
  %f16
  
  for i=1:length(x4)
      if(((fix((x4(i)+bin_wkumf/2)*(10^4))/(10^4))>=2.7857) && ((fix((x4(i)-bin_wkumf/2)*(10^4))/(10^4))<=2.7857))
          %ku_1pko(t)=n3(i);
          ku_1pkmf(t)=n4(i);
%       else
%           %ku_1pko(t)=0;
%           ku_1pkmf(t)=0;
      end
  end
  
  for i=1:length(x3)
      if(((fix((x3(i)+bin_wkuo/2)*(10^4))/(10^4))>=2.7857) && ((fix((x3(i)-bin_wkuo/2)*(10^4))/(10^4))<=2.7857))
          ku_1pko(t)=n3(i);
          %ku_1pkmf(t)=n4(i);
%       else
%           ku_1pko(t)=0;
%           %ku_1pkmf(t)=0;
      end
  end
  %f15
  for i=1:length(x4)
      if(((fix((x4(i)+bin_wkumf/2)*(10^4))/(10^4))>=1.5000) && ((fix((x4(i)-bin_wkumf/2)*(10^4))/(10^4))<=1.5000))
          %ku_2pko(t)=n3(i);
          ku_2pkmf(t)=n4(i);
%           else
%          % ku_2pko(t)=0;
%           ku_2pkmf(t)=0;
      end
  end
  
  for i=1:length(x3)
       if(((fix((x3(i)+bin_wkuo/2)*(10^4))/(10^4))>=1.5000) && ((fix((x3(i)-bin_wkuo/2)*(10^4))/(10^4))<=1.5000))
          ku_2pko(t)=n3(i);
          %ku_2pkmf(t)=n4(i);
%           else
%           ku_2pko(t)=0;
%          % ku_2pkmf(t)=0;
      end
  end
  %f14
  for i=1:length(x4)
      if(((fix((x4(i)+bin_wkumf/2)*(10^4))/(10^4))>=1.0500) && ((fix((x4(i)-bin_wkumf/2)*(10^4))/(10^4))<=1.0500))
         % ku_3pko(t)=n3(i);
          ku_3pkmf(t)=n4(i);
%           else
%          % ku_3pko(t)=0;
%           ku_3pkmf(t)=0;
      end
  end
  
  for i=1:length(x3)
    if(((fix((x3(i)+bin_wkuo/2)*(10^4))/(10^4))>=1.0500) && ((fix((x3(i)-bin_wkuo/2)*(10^4))/(10^4))<=1.0500))
          ku_3pko(t)=n3(i);
         % ku_3pkmf(t)=n4(i);
%           else
%           ku_3pko(t)=0;
%          % ku_3pkmf(t)=0;
      end
  end
  %f17
  for i=1:length(x4)
      if(((fix((x4(i)+bin_wkumf/2)*(10^4))/(10^4))>=7.1249) && ((fix((x4(i)-bin_wkumf/2)*(10^4))/(10^4))<=7.1249))
         % ku_4pko(t)=n3(i);
          ku_4pkmf(t)=n4(i);
%           else
%          % ku_4pko(t)=0;
%           ku_4pkmf(t)=0;
      end
  end
  
  for i=1:length(x3)
      if(((fix((x3(i)+bin_wkuo/2)*(10^4))/(10^4))>=7.1249) && ((fix((x3(i)-bin_wkuo/2)*(10^4))/(10^4))<=7.1249))
          ku_4pko(t)=n3(i);
         % ku_4pkmf(t)=n4(i);
%           else
%           ku_4pko(t)=0;
%          % ku_4pkmf(t)=0;
      end
  end
  %f18
  mean_kuo(t)=mean(kurtoremnan3x3o);
  mean_kumf(t)=mean(kurtmf3x3remnan3x3o);
  %f19
  var_kuo(t)=var(kurtoremnan3x3o);
  var_kumf(t)=var(kurtmf3x3remnan3x3o);  
 end 
end




DU32_allvsmf35J=[skl_4pko' skr_4pko' mean_sko' var_sko' kurto' mid_pko' skr_1pko' skl_1pko' skr_2pko' skl_2pko' skr_3pko' skl_3pko' n_nansko' ku_1pko' ku_2pko' ku_3pko' ku_4pko' mean_kuo' var_kuo' ;skl_4pkmf' skr_4pkmf' mean_skmf' var_skmf' kurtmf' mid_pkmf' skr_1pkmf' skl_1pkmf' skr_2pkmf' skl_2pkmf' skr_3pkmf' skl_3pkmf' n_nanskmf' ku_1pkmf' ku_2pkmf' ku_3pkmf' ku_4pkmf' mean_kumf' var_kumf'];
DUL32_allvsmf35J=[DU32_allvsmf35J label]; 

    for k=1:size(DU32_allvsmf35J,2)
        min_DU32_allvsmf35J(k)=min(DU32_allvsmf35J(:,k));
        max_DUC32_allvsmf35J(k)=max(DU32_allvsmf35J(:,k));
    end


for j=1:(2*count)
    for k=1:size(DU32_allvsmf35J,2)
        DU32_allvsmf35J(j,k)=((2*(DU32_allvsmf35J(j,k)-min_DU32_allvsmf35J(k)))/(max_DUC32_allvsmf35J(k)-min_DU32_allvsmf35J(k)))-1;
%         if(isnan(DNU_orgvsmf5J(j,k)))
%             DNU_orgvsmf5J(j,k)=0;
%         end 
    end
end

DNU32_allvsmf35J=[DU32_allvsmf35J label]; 
save DNU32_allvsmf35J
save DUL32_allvsmf35J
save min_DU32_allvsmf35J
save max_DU32_allvsmf35J
