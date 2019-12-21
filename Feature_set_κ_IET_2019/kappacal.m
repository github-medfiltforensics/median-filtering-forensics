function [ kao_n,kao_new,kamf_n,kamf_new,nblkkao,nblkkamf,n_nansko,n_nanskmf,chk_ka ] = kappacal(X,Xmf,win_sz,px_ol)
%chk_skew=0;
%chk_kurt=0;
chk_ka=0;
    p=1;%no. of block initialization
    t=1;%index of org image skewness excluding nan blocks
    q=1;%index of mf image skewness excluding nan blocks
    l=1;%index of org image kurtosis excluding nan blocks
    r=1;%index of mf image kurtosis excluding nan blocks
    y=1;%index of org image kurtosis excluding nan blocks
    z=1;%index of mf image kurtosis excluding nan blocks
    nblksk=0;%no. of blocks remaining after nan skewness block removal
    nblkku=0;%no. of blocks remaining after nan kurtosis block removal
    nblkkao=0;
    nblkkamf=0;
   %org image variables
   n_nansko=0;
   n_nanskmf=0;
   n_nankuo=0;
   n_nankumf=0;
   n_nankao=0;
   n_nankamf=0;
Imo_b=X;
Immf_b=Xmf;
[mo,no]=size(Imo_b);%original size of images before zero padding
    [Mo,No]=size(Immf_b);
 %for 1 pixel overlapping, no. of rows and columns are odd   
    if(mod(mo,2)==0)
        z1=zeros(1,no);
        Imo_b=cat(1,Imo_b,z1);
    end
    
    [m,n]=size(Imo_b);
    if(mod(n,2)==0)
        z2=zeros(m,1);
        Imo_b=cat(2,Imo_b,z2);
    end
    
     if(mod(Mo,2)==0)
        zmf1=zeros(1,No);
        Immf_b=cat(1,Immf_b,zmf1);
     end
     
    [M,N]=size(Immf_b);
    if(mod(N,2)==0)
        zmf2=zeros(M,1);
        Immf_b=cat(2,Immf_b,zmf2);
    end
[m,n]=size(Imo_b);
[M,N]=size(Immf_b);
if((m~=M)||(n~=N))
         disp('error')
end
    
%      fun1=@(x) skewness(x(:));
%      fun2=@(x) kurtosis(x(:));
%      sko = nlfilter(Imo_b,[3 3],fun1);
%      sko=sko(2:end-1,2:end-1);
%      sko=sko(:);
%      skmf = nlfilter(Immf_b,[3 3],fun1);
%      skmf=skmf(2:end-1,2:end-1);
%      skmf=skmf(:);
%      kuo = nlfilter(Imo_b,[3 3],fun2);
%      kuo=kuo(2:end-1,2:end-1);
%      kuo=kuo(:);
%      kumf = nlfilter(Immf_b,[3 3],fun2);
%      kumf=kumf(2:end-1,2:end-1);
%      kumf=kumf(:);
if (px_ol==1)
       x=win_sz-1;
elseif (px_ol==2)
       x=win_sz-2;
       m=mo;
       n=no;
end
   
tn_blk=0;
for i=1:x:m
  for j=1:x:n
      tn_blk=tn_blk+1;
  end
end
for i=1:x:(m-2)
     for j=1:x:(n-2)
        if(p>tn_blk)
            break
        end
           
          %org image moment calculation
            blk_sel=Imo_b(i:i+(win_sz-1),j:j+(win_sz-1));
            sko(p)=skewness(blk_sel(:));
            kuo(p)=kurtosis(blk_sel(:));
            
            
           %mf image moment calculation 
           blk_sel1=Immf_b(i:(i+(win_sz-1)),j:(j+(win_sz-1)));
           skmf(p)=skewness(blk_sel1(:));
           kumf(p)=kurtosis(blk_sel1(:));
           
           p=p+1;
     end
end
p=1;
   for p=1:length(sko)
     if(isnan(sko(p)))
                 n_nansko=n_nansko+1;
                 %sk_hltd=insertShape(sk_hltdn,'rectangle',pos,'color',[0 255 0]);
                 %sk_hltdn=sk_hltd;
                
                 % blk_selnan=blk_sel;
                 
             else
                 if(~isnan(skmf(p)))
                sko_n(t)=sko(p);
                skmf_n(q)=skmf(p);
                %sk_hltd1=insertShape(sk_hltdoremnan,'rectangle',pos,'color',[0 150 150]);
                %sk_hltdoremnan=sk_hltd1;
                %sk_hltd2=insertShape(sk_hltdmfremnan,'rectangle',pos,'color',[0 150 150]);
                %sk_hltdmfremnan=sk_hltd2;
                t=t+1;
                q=q+1;
                nblksk=nblksk+1;
                 end
     end
             if(isnan(skmf(p)))
                     n_nanskmf=n_nanskmf+1;
                 %    skmf_hltd=insertShape(skmf_hltdn,'rectangle',pos,'color',[0 255 0]);
                %     skmf_hltdn=skmf_hltd;
             end     
  
  end
     for p=1:length(kuo)
             if((~isnan(kuo(p)))&&(~isnan(kumf(p))))
                 kuo_n(l)=kuo(p);
                 kumf_n(r)=kumf(p);
                 l=l+1;
                 r=r+1;
                 nblkku=nblkku+1;
             end
             if(isnan(kumf(p)))
                 n_nankumf=n_nankumf+1;
             end
             if(isnan(kuo(p)))
                 n_nankuo=n_nankuo+1;
             end
       
     end
    
  
%   if ((all(isnan(kuo)))|| all(isnan(kumf)))
%         for i=1:length(kuo)
%       kuo_n(i)=1;% '1' representing images with all NaN blocks
%       kumf_n(i)=1;
%         end
%      for i=1:length(kuo)
%       kao_n(i)=1;% '1' representing images with all NaN blocks
%       kamf_n(i)=1;
%      end
%       n_nankao=length(kao);
%       n_nankamf=length(kao);
%       n_nankuo=length(kuo);
%       n_nankumf=length(kumf);
%       nblkka=0;
%       nblkku=0;
%       chk_ku=1;
%   end
  if ((all(isnan(sko)))|| (all(isnan(skmf))))
%         for i=1:length(sko)
%       sko_n(i)=0;% '1' representing images with all NaN blocks
%       skmf_n(i)=0;
%         end
         for i=1:length(sko)
       kao(i)=0;% '0' representing images with all NaN blocks
       kamf(i)=0;
       kao(i)=0;% '0' representing images with all NaN blocks
       kamf(i)=0;
       kao_n(i)=0;
       kamf_n(i)=0;
       kamf_new(i)=0;
       kao_new(i)=0;
         end
      
      n_nansko=length(sko);
      n_nanskmf=length(sko);
%       nblkkao=0;
%       nblkkamf=0;
      chk_ka=1;
  else
   
  kao=((sko_n.^2).*((kuo_n+3).^2))./(4.*(4.*kuo_n-3.*(sko_n.^2)).*(2.*kuo_n-3.*(sko_n.^2)-6));
  kamf=((skmf_n.^2).*((kumf_n+3).^2))./(4.*(4.*kumf_n-3.*(skmf_n.^2)).*(2.*kumf_n-3.*(skmf_n.^2)-6));
 
%   for i=1:length(kao)
%       if(kao>-0.334 & kao<-0.17)
%           display(kao(i))
%           display(sko_n(i))
%           display(kuo_n(i))
%       end
%   end

   
  
  for i=1:length(kao)
  if(isnan(kao(i)))
      n_nankao=n_nankao+1;
  else
      if(~isnan(kamf(i)))
          kao_n(y)=kao(i);
          kamf_n(z)=kamf(i);
          y=y+1;
          z=z+1;
      end
  end
  if(isnan(kamf(i)))
      n_nankamf=n_nankamf+1;
  end
  end
  
  
  y=1;
  z=1;
  for i=1:length(kao_n)
      if(kao_n(i)>-2 && kao_n(i)<1)
          kao_new(y)=kao_n(i);
          y=y+1;
      end
      
  %end
  
      if(kamf_n(i)>-2 && kamf_n(i)<1)
          kamf_new(z)=kamf_n(i);
          z=z+1;
      end
  end
  end
 nblkkao=length(kao_new);
 nblkkamf=length(kamf_new);
 
 

%  for i=1:length(kao_n)
%       if(kao_n(i)>(0.01*max(kao_n)))
%           kao_new(y)=kao_n(i);
%           y=y+1;
%           nblkkao=nblkkao+1;
%       end
%       if(kamf_n(i)>(0.01*max(kamf_n)))
%           kamf_new(z)=kamf_n(i);
%           z=z+1;
%           nblkkamf=nblkkamf+1;
%       end
%   end
      
  

end

