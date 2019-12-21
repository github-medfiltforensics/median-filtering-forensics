function [ skeworemnan_ovblk,skewmfremnan_ovblk,kurtoremnan_ovblk,kurtmfremnan_ovblk,n_ovblk_remnanskew,n_ovblk_remnankurt,n_nanskewo,n_nanskewmf,n_nankurto,n_nankurtmf,chk_skew,chk_kurt ] = Cal_o_n_mf_ovrblk_moments(X,Xmf,win_sz,px_ol)
%function to calculate skewness of single pixel overlap and 2 pixel overlap
chk_skew=0;
chk_kurt=0;
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
    %size for 1 pixel overlapping
    [m,n]=size(Imo_b);
    
    
    [M,N]=size(Immf_b);
   %  tn_blkmf=((M*N)/(win_sz*win_sz));
     if((m~=M)||(n~=N))
         disp('error')
     end
   % meano=zeros(count,((m*n)/64));
   % varo=zeros(count,((m*n)/64));
   % skewo=zeros(count,((m*n)/64));
   % kurto=zeros(count,((m*n)/64));
   % meanmf=zeros(count,((M*N)/64));
   % varmf=zeros(count,((M*N)/64));
   % skewmf=zeros(count,((M*N)/64));
   % kurtmf=zeros(count,((M*N)/64));
   
   
    p=1;%no. of block initialization
    t=1;%index of org image skewness excluding nan blocks
    q=1;%index of mf image skewness excluding nan blocks
    l=1;%index of org image kurtosis excluding nan blocks
    r=1;%index of mf image kurtosis excluding nan blocks
    n_ovblk_remnanskew=0;%no. of blocks remaining after nan skewness block removal
    n_ovblk_remnankurt=0;%no. of blocks remaining after nan kurtosis block removal
   %org image variables
   n_nanskewo=0;
   n_nanskewmf=0;
   n_nankurto=0;
   n_nankurtmf=0;
   %nblk_grtr0=0;
   %nblk_less0=0;
   %n_ovblk_nan=0;
  % sk_hltdn=Imo_b;
  % sk_hltdoremnan=Imo_b;
   
   %mf image variables
   % nblkmf_0=0;
   % nblkmf_grtr0=0;
   % nblkmf_less0=0;
   % n_ovblkmf_nan=0;
   % skmf_hltdn=Immf_b;
   % sk_hltdmfremnan=Immf_b;
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
   
               
   %for 1 pixel overlapping blocks, calculate moments
    for i=1:x:(m-2)
        for j=1:x:(n-2)
           if(p>tn_blk)
               break
           end
           
          %org image moment calculation
            blk_sel=Imo_b(i:i+(win_sz-1),j:j+(win_sz-1));
            %meano_b=mean(blk_sel(:));
            %varo_b=var(blk_sel(:));
            skewo_b=skewness(blk_sel(:));
            kurto_b=kurtosis(blk_sel(:));
            %entrpyo_b=entropy(blk_sel(:));
            %ucidmeano(p)=meano_b;
            %ucidvaro(p)=varo_b;
            ucidskewo(p)=skewo_b;
            ucidkurto(p)=kurto_b;
            %ucidentrpyo(p)=entrpyo_b;
           
           %mf image moment calculation 
           blk_sel1=Immf_b(i:(i+(win_sz-1)),j:(j+(win_sz-1)));
          % meanmf_b=mean(blk_sel1(:));
          % varmf_b=var(blk_sel1(:));
           skewmf_b=skewness(blk_sel1(:));
           kurtmf_b=kurtosis(blk_sel1(:));
          % entrpymf_b=entropy(blk_sel1(:));
          % ucidmeanmf(p)=meanmf_b;
          % ucidvarmf(p)=varmf_b;
           ucidskewmf(p)=skewmf_b;
           ucidkurtmf(p)=kurtmf_b;
          % ucidentrpymf(p)=entrpymf_b;
           
          % pos=[j i (win_sz+2) (win_sz+2)];
            
           % if(ucidskewo(p)==0)
           %     nblk_0=nblk_0+1;
                %sk_hltd=insertShape(sk_hltdn,'rectangle',pos,'color',[255 0 0]);
                %sk_hltdn=sk_hltd;
               % blk_sel0=blk_sel;
           % end
           % if(ucidskewo(p)>0)
            %    nblk_grtr0=nblk_grtr0+1;
                %sk_hltd=insertShape(sk_hltdn,'rectangle',pos,'color',[0 0 255]);
                %sk_hltdn=sk_hltd;
           % end
            % if(ucidskewo(p)<0)
             %   nblk_less0=nblk_less0+1;
                %sk_hltd=insertShape(sk_hltdn,'rectangle',pos,'color',[255 0 255]);
                %sk_hltdn=sk_hltd;
            % end
             % if(ucidskewmf(p)==0)
             %   nblkmf_0=nblkmf_0+1;
                %skmf_hltd=insertShape(skmf_hltdn,'rectangle',pos,'color',[255 0 0]);
                %skmf_hltdn=skmf_hltd;
            % end
           % if(ucidskewmf(p)>0)
           %     nblkmf_grtr0=nblkmf_grtr0+1;
                %skmf_hltd=insertShape(skmf_hltdn,'rectangle',pos,'color',[0 0 255]);
                %skmf_hltdn=skmf_hltd;
           % end
           %  if(ucidskewmf(p)<0)
            %    nblkmf_less0=nblkmf_less0+1;
                %skmf_hltd=insertShape(skmf_hltdn,'rectangle',pos,'color',[255 0 255]);
                %skmf_hltdn=skmf_hltd;
            % end
             
             %removal of blocks having nan skewness in any of mf or org image.
             if(isnan(ucidskewo(p)))
                 n_nanskewo=n_nanskewo+1;
                 %sk_hltd=insertShape(sk_hltdn,'rectangle',pos,'color',[0 255 0]);
                 %sk_hltdn=sk_hltd;
                
                 % blk_selnan=blk_sel;
                 
             else
                 if(~isnan(ucidskewmf(p)))
                skeworemnan_ovblk(t)=ucidskewo(p);
                skewmfremnan_ovblk(q)=ucidskewmf(p);
                %sk_hltd1=insertShape(sk_hltdoremnan,'rectangle',pos,'color',[0 150 150]);
                %sk_hltdoremnan=sk_hltd1;
                %sk_hltd2=insertShape(sk_hltdmfremnan,'rectangle',pos,'color',[0 150 150]);
                %sk_hltdmfremnan=sk_hltd2;
                t=t+1;
                q=q+1;
                n_ovblk_remnanskew=n_ovblk_remnanskew+1;
                 end
             end
             if(isnan(ucidskewmf(p)))
                     n_nanskewmf=n_nanskewmf+1;
                 %    skmf_hltd=insertShape(skmf_hltdn,'rectangle',pos,'color',[0 255 0]);
                %     skmf_hltdn=skmf_hltd;
                     
             end
             if((~isnan(ucidkurto(p)))&&(~isnan(ucidkurtmf(p))))
                 kurtoremnan_ovblk(l)=ucidkurto(p);
                 kurtmfremnan_ovblk(r)=ucidkurtmf(p);
                 l=l+1;
                 r=r+1;
                 n_ovblk_remnankurt=n_ovblk_remnankurt+1;
             end
             if(isnan(ucidkurtmf(p)))
                 n_nankurtmf=n_nankurtmf+1;
             end
             if(isnan(ucidkurto(p)))
                 n_nankurto=n_nankurto+1;
             end
            p=p+1;            
        end
    end
    
    
    
  if (all(isnan(ucidskewo))|| all(isnan(ucidskewmf)))
        for i=1:tn_blk
      skeworemnan_ovblk(i)=1;% '1' representing images with all NaN blocks
      skewmfremnan_ovblk(i)=1;
      end
      n_nanskewo=tn_blk;
      n_nanskewmf=tn_blk;
      n_ovblk_remnanskew=0;
      chk_skew=1;
  end
  
  if (all(isnan(ucidkurto))|| all(isnan(ucidkurtmf)))
        for i=1:tn_blk
      kurtoremnan_ovblk(i)=1;% '1' representing images with all NaN blocks
      kurtmfremnan_ovblk(i)=1;
      end
      n_nankurto=tn_blk;
      n_nankurtmf=tn_blk;
      n_ovblk_remnankurt=0;
      chk_kurt=1;
  end
    
        
  
   
   
     %imshow(uint8(sk_hltdn))
    %figure
    %imshow(uint8(skmf_hltdn))
    %figure
    %imshow(uint8(sk_hltdoremnan))
    %figure
    %imshow(uint8(sk_hltdmfremnan))
  
 
  
 %n_binskew=1+log2(nblk_remnanskew);
 %n_binkurt=1+log2(nblk_remnankurt);

% n_binmf=1+log2(n_blkmf);
%figure
%subplot(1,2,1)
%hist(ucidmeano,n_bin)
%subplot(1,2,2)
%hist(ucidmeanmf,n_bin)

%figure
%subplot(1,2,1)
%hist(ucidvaro,n_bin)
%subplot(1,2,2)
%hist(ucidvarmf,n_bin)

%figure
%subplot(1,3,1)
%[n1,x1]=hist(skeworemnan,n_binskew);

%hist(skeworemnan,n_binskew)
%hold on
%plot(x1,n1,'r')
%title('original image skewness')

%subplot(1,3,2)
%[n2,x2]=hist(skewmfremnan,n_binskew);

%hist(skewmfremnan,n_binskew)
%hold on
%plot(x2,n2,'r')
%title('3x3 mf image skewness')

%subplot(2,2,4)
%plot(x1,n1,'k')
%hold on
%plot(x1,n2,'r')
%legend('org','mf')

%figure
%subplot(1,3,1)
%[n1,x1]=hist(kurtoremnan,n_binkurt);
%hist(kurtoremnan,n_binkurt)
%hold on
%plot(x1,n1,'r')
%title('original image kurtosis')

%subplot(1,3,2)
%[n2,x2]=hist(kurtmfremnan,n_binkurt);
%hist(kurtmfremnan,n_binkurt)
%hold on
%plot(x2,n2,'r')
%title('3x3 mf image kurtosis')

%subplot(1,3,3)
%plot(x1,n1,'k')
%hold on
%plot(x2,n2,'r')
%legend('org','mf')

%figure
%subplot(1,2,1)
%[n1,x1]=hist(ucidentrpyo,n_bin)
%subplot(1,2,2)
%[n2,x2]=hist(ucidentrpymf,n_bin)
%plot(x1,n1,'r')
%hold on
%plot(x2,n2,'g')

%save skeworemnan
%save skewmfremnan



end

%clear all;



