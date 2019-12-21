close all;
win_sz=3;
px_ol=2;
Imofiles=dir('C:\divya\databases\ucid\ucid128_mf3\*.tif');
Immffiles=dir('C:\divya\databases\ucid\ucid128_mf5\*.tif');
count=length(Imofiles);
label=[ones(count,1);2*ones(count,1)];
f1o=zeros(1,count);
f1mf=zeros(1,count);
f2o=zeros(1,count);
f2mf=zeros(1,count);
f3o=zeros(1,count);
f3mf=zeros(1,count);
f4o=zeros(1,count);
f4mf=zeros(1,count);
n_nanskewo=zeros(1,count);
n_nanskewmf=zeros(1,count);
h1o=zeros(1,count);
h1mf=zeros(1,count);
h2o=zeros(1,count);
h2mf=zeros(1,count);
h3o=zeros(1,count);
h3mf=zeros(1,count);
h4o=zeros(1,count);
h4mf=zeros(1,count);
h_allo=zeros(count,11);
h_allmf=zeros(count,11);
%%
for t=1:count
    display(t)
I1=strcat('C:\divya\databases\ucid\ucid128_mf3\',Imofiles(t).name);
I2=imread(I1);
    
    if(size(I2,3)==3)
        I2=rgb2gray(I2);
    end
    I4=I2;
    imwrite((I4),'test19.jpg','Quality',30);
    I5=imread('test19.jpg');
    I6=double(I5);
    I7=medfilt2((I6),[3 3]);
    Iro=I6-I7;
Immf=strcat('C:\divya\databases\ucid\ucid128_mf5\',Immffiles(t).name);
%I2=double(I2);
%I8=medfilt2((I2),[5 5]);
Immf=imread(Immf);
imwrite(uint8(Immf),'test42.jpg','Quality',30);
I9=imread('test42.jpg');
I10=double(I9);
I11=medfilt2((I10),[3 3]);
Irmf=I10-I11;

[m,n]=size(Iro);
[M,N]=size(Irmf);
if((m~=M)||(n~=N))
     disp('error')
end
 [ kao_n,kao_new,kamf_n,kamf_new,nblkkao,nblkkamf,n_nansko,n_nanskmf,chk_ka ] = kappacal(Iro,Irmf,win_sz,px_ol);
 if(chk_ka==1)
     f1o(t)=0;f2o(t)=0;f3o(t)=0;f4o(t)=0;f1mf(t)=0;f2mf(t)=0;f3mf(t)=0;f4mf(t)=0;n_nanskewo(t)=n_nansko;n_nanskewmf(t)=n_nanskmf;
     h1o(t)=0;h1mf(t)=0;h2o(t)=0;h2mf(t)=0;h3o(t)=0;h3mf(t)=0;h4o(t)=0;h4mf(t)=0;
 end

if(chk_ka==0)
 f1o(t)=mean(kao_n);
 f1mf(t)=mean(kamf_n);
 f2o(t)=var(kao_n);
 f2mf(t)=var(kamf_n);
 f3o(t)=skewness(kao_n);
 f3mf(t)=skewness(kamf_n);
 f4o(t)=kurtosis(kao_n);
 f4mf(t)=kurtosis(kamf_n);
 
 n_nanskewo(t)=n_nansko;
 n_nanskewmf(t)=n_nanskmf;
 
 %nblkkao=length(kao_new);
 %nblkkamf=length(kamf_new);
 %There is not large difference between number of blocks nblkkao and nblkkamf. so, equal no. of bins are taken for both histograms. 
 %sigma1=(6*(nblkkamf-2)/(nblkkamf+1)*(nblkkamf+3))^(1/2);
 %n_binka=1+ceil(log2(nblkkamf)+log2(1+(abs(skewness(kamf_new)))/sigma1));
 
 [n1,x1]=hist(kao_new,18);
 [n2,x2]=hist(kamf_new,18);
 h_allo(t,1:11)=n1(3:13);
 h_allmf(t,1:11)=n2(3:13);
%  bin_wkao=x1(2)-x1(1);
%  bin_wkamf=x2(2)-x2(1);
 
%  figure
%  hist(kao_n,n_binka);
%  figure
%  hist(kamf_n,n_binka);
 
%  for i=1:length(x1)
%  if((fix((x1(i)+(bin_wkao/2))*(10^4))/10^4)>=-1.5312 && (fix((x1(i)-(bin_wkao/2))*(10^4))/10^4)<=-1.5312)
%  %if(fix(x1(i+1)*(10^4))/(10^4)>=-1.5321 && fix(x1(i)*(10^4))/(10^4)<=-1.5321)
%  h1o(t)=n1(i);
%  end
%  end
%  
%  for i=1:length(x1)
% % if (fix(x1(i+1)*(10^4))/(10^4)>=-0.4464 && fix(x1(i)*(10^4))/(10^4)<=-0.4464)
%  if((fix((x1(i)+(bin_wkao/2))*(10^4))/10^4)>=-0.4464 && (fix((x1(i)-(bin_wkao/2))*(10^4))/10^4)<=-0.4464)
%  h2o(t)=n1(i);
%  end
%  end
%  
%  for i=1:length(x1)
%  %if(fix(x1(i+1)*(10^4))/(10^4)>=-0.1250 && fix(x1(i)*(10^4))/(10^4)<=-0.1250)
%  if((fix((x1(i)+(bin_wkao/2))*(10^4))/10^4)>=-0.1250 && (fix((x1(i)-(bin_wkao/2))*(10^4))/10^4)<=-0.1250)
%  h3o(t)=n1(i);
%  end
%  end
%  
%  for i=1:length(x1)
%  %if(fix(x1(i+1)*(10^4))/(10^4)>=-0.0125 && fix(x1(i)*(10^4))/(10^4)<=-0.0125)
%  if((fix((x1(i)+(bin_wkao/2))*(10^4))/10^4)>=-0.0125 && (fix((x1(i)-(bin_wkao/2))*(10^4))/10^4)<=-0.0125)
%  h4o(t)=n1(i);
%  end
%  end
%  
%  for i=1:length(x2)
%  if((fix((x2(i)+(bin_wkamf/2))*(10^4))/10^4)>=-1.5312 && (fix((x2(i)-(bin_wkamf/2))*(10^4))/10^4)<=-1.5312)
%  h1mf(t)=n2(i);
%  end
%  end
%  
%  for i=1:length(x2)
%  if((fix((x2(i)+(bin_wkamf/2))*(10^4))/10^4)>=-0.4464 && (fix((x2(i)-(bin_wkamf/2))*(10^4))/10^4)<=-0.4464)
%  %if((x1(i)+(bin_wkao/2))>=-0.4464 && (x1(i)-(bin_wkao/2))<=-0.4464)
%  h2mf(t)=n2(i);
%  end
%  end
%  
%  for i=1:length(x2)
%  if((fix((x2(i)+(bin_wkamf/2))*(10^4))/10^4)>=-0.1250 && (fix((x2(i)-(bin_wkamf/2))*(10^4))/10^4)<=-0.1250)
%  %if((x1(i)+(bin_wkao/2))>=-0.1250 && (x1(i)-(bin_wkao/2))<=-0.1250)
%  h3mf(t)=n2(i);
%  end
%  end
%  
%  for i=1:length(x2)
%  if((fix((x2(i)+(bin_wkamf/2))*(10^4))/10^4)>=-0.0125 && (fix((x2(i)-(bin_wkamf/2))*(10^4))/10^4)<=-0.0125)
%  %if((x1(i)+(bin_wkao/2))>=-0.0125 && (x1(i)-(bin_wkao/2))<=-0.0125)
%  h4mf(t)=n2(i);
%  end
%  
%  end
% %  h1mf(t)=n2(3);
% %  h2o(t)=n1(10);
% %  h2mf(t)=n2(10);
% %  h3o(t)=n1(12);
% %  h3mf(t)=n2(12);
% %  h4o(t)=n1(13);
% %  h4mf(t)=n2(13);
% %  pd1=fitdist(kao_new,'wbl');
% %  pd2=fitdist(kamf_new,'wbl');
% %  pd3=fitdist(kao_new,'ev');
% %  pd4=fitdist(kamf_new,'ev');
% 
% % pd5=fitdist(kao_new','gev');
% % pd6=fitdist(kamf_new','gev');
% 
% %  pd7=fitdist(kao_new,'gp');
% %  pd8=fitdist(kamf_new,'gp');
% 
% %f10o(t)=pd5.k;
% %f10mf(t)=pd6.k;
%  end
 end
end
P2_DN128mf3nj30vsmf5nj30U=[h_allo f1o' f2o' f3o' f4o' n_nanskewo'; h_allmf f1mf' f2mf' f3mf' f4mf' n_nanskewmf'];
 %P2_DNresvsmf5nj50U=[f1o' f2o' f3o' f4o' h1o' h2o' h3o' h4o' n_nanskewo' ;f1mf' f2mf' f3mf' f4mf' h1mf' h2mf' h3mf' h4mf' n_nanskewmf' ];
 P2L_D128mf3nj30vsmf5nj30U=[P2_DN128mf3nj30vsmf5nj30U label];
  for k=1:size(P2_DN128mf3nj30vsmf5nj30U,2)
        min_P2_DN128mf3nj30vsmf5nj30U(k)=min(P2_DN128mf3nj30vsmf5nj30U(:,k));
        max_P2_DN128mf3nj30vsmf5nj30U(k)=max(P2_DN128mf3nj30vsmf5nj30U(:,k));
  end
 for j=1:(2*count)
    for k=1:size(P2_DN128mf3nj30vsmf5nj30U,2)
        P2_DN128mf3nj30vsmf5nj30U(j,k)=(2*(P2_DN128mf3nj30vsmf5nj30U(j,k)-min_P2_DN128mf3nj30vsmf5nj30U(k))/(max_P2_DN128mf3nj30vsmf5nj30U(k)-min_P2_DN128mf3nj30vsmf5nj30U(k)))-1;
    end
end

P2_DN128mf3nj30vsmf5nj30U=[P2_DN128mf3nj30vsmf5nj30U label];

save P2_DN128mf3nj30vsmf5nj30U
save P2L_D128mf3nj30vsmf5nj30U
 save min_P2_DN128mf3nj30vsmf5nj30U
 save max_P2_DN128mf3nj30vsmf5nj30U
 