

%% this is a corrected version %%


% File read   


clc;
clear;
close all;

filename = 'isobox.dat';

fid = fopen(filename,'r');

dims = fread(fid,4,'integer*4','ieee-le');

nx = dims(1);
ny = dims(2);
nz = dims(3);
nvar = dims(4);

nsize = nx*ny*nz;

dummy = fread(fid,nsize,'real*4','ieee-le');
U = reshape(dummy,nx,ny,nz);
dummy = fread(fid,nsize,'real*4','ieee-le');
V = reshape(dummy,nx,ny,nz);
dummy = fread(fid,nsize,'real*4','ieee-le');
W = reshape(dummy,nx,ny,nz);

% Computing velocity components and max,min.   

VEL_X(256) = 0;
VEL_Y(256) = 0;
VEL_Z(256) = 0;


VELOCITY(256) = 0;
r = 128;
n = 128;
 
  for m = 1:256
      
             VELOCITY(m) = (((((U(r,n,m))^2)+((V(r,n,m))^2)+((W(r,n,m))^2)))^(1/2));
             
  end
  


MAX_VELOCITY = max(VELOCITY);
MIN_VELOCITY = min(VELOCITY);

for m = 1:256            
             if MAX_VELOCITY == VELOCITY(m)
                LOCAL_MAX = m;
             else if MIN_VELOCITY == VELOCITY(m)    
                LOCAL_MIN = m;        
                 end
             end
end

MAX_LOCAL = ((2 * pi) / 256) * LOCAL_MAX;
MIN_LOCAL = ((2 * pi) / 256) * LOCAL_MIN;


   
VELOCITY_U(256) = 0;
r = 128;
n = 128;
   
  for m = 1:256
      
             VELOCITY_U(m) = U(r,n,m);
             
  end



MAX_VELOCITY_U = max(VELOCITY_U);
MIN_VELOCITY_U = min(VELOCITY_U);



for m = 1:256            
             if MAX_VELOCITY_U == VELOCITY_U(m)
                LOCAL_MAX_U = m;
             else if MIN_VELOCITY_U == VELOCITY_U(m)    
                LOCAL_MIN_U = m;        
                 end
             end
end

MAX_LOCAL_U = ((2 * pi) / 256) * LOCAL_MAX_U;
MIN_LOCAL_U = ((2 * pi) / 256) * LOCAL_MIN_U;

   


VELOCITY_V(256) = 0;
r = 128;
n = 128;
   
  for m = 1:256
      
             VELOCITY_V(m) = V(r,n,m);
             
  end



MAX_VELOCITY_V = max(VELOCITY_V);
MIN_VELOCITY_V = min(VELOCITY_V);


for m = 1:256            
             if MAX_VELOCITY_V == VELOCITY_V(m)
                LOCAL_MAX_V = m;
             else if MIN_VELOCITY_V == VELOCITY_V(m)    
                LOCAL_MIN_V = m;        
                 end
             end
end

MAX_LOCAL_V = ((2 * pi) / 256) * LOCAL_MAX_V;
MIN_LOCAL_V = ((2 * pi) / 256) * LOCAL_MIN_V;



VELOCITY_W(256) = 0;
r = 128;
n = 128;
   
  for m = 1:256
      
             VELOCITY_W(m) = W(r,n,m);
             
  end
  
   
MAX_VELOCITY_W = max(VELOCITY_W);
MIN_VELOCITY_W = min(VELOCITY_W);

     
for m = 1:256            
             if MAX_VELOCITY_W == VELOCITY_W(m)
                LOCAL_MAX_W = m;
             else if MIN_VELOCITY_W == VELOCITY_W(m)    
                LOCAL_MIN_W = m;        
                 end
             end
end

MAX_LOCAL_W = ((2 * pi) / 256) * LOCAL_MAX_W;
MIN_LOCAL_W = ((2 * pi) / 256) * LOCAL_MIN_W;
   
   
   
sum = 0;
for r = 1:256
    for n = 1:256
        for m = 1:256
            sum = sum + U(r,n,m);
        end
    end
end

   U_MEAN = sum/(nsize);

sum = 0;   
for n = 1:256
    for r = 1:256
        for m = 1:256
            sum = sum + V(r,n,m);
        end
    end
end

   V_MEAN = sum/(nsize);

sum = 0;   
for m = 1:256
    for n = 1:256
        for r = 1:256
            sum = sum + W(r,n,m);
        end
    end
end

   W_MEAN = sum/(nsize);

sum = 0;   
for r = 1:256
    for n = 1:256
        for m = 1:256
            sum = sum + ((U(r,n,m)-U_MEAN)^2);
        end
    end
end


g2(nsize) = 0;

j = 0;

for r = 1:256
   
    for n = 1:256
        
        for m = 1:256
                     
                     j = j + 1;
                     g2(j) = V(r,n,m);
                     
        end
    end
end

p2 = sort(g2);

    
      nsize2 = 128;
      DELTA_V = ((p2(nsize) - p2(1)) / (nsize2));
      hh = p2(1);
      ii = 1;
      OO2(nsize2) = hh;
      KK2(nsize2) = 0;
      
            for i = 1:1:nsize2
                                
                 for ii = ii:1:nsize
                                                    
                    if  (p2(ii) <= (hh+DELTA_V)) && (p2(ii) >= (hh))
                        
                         KK2(i) = KK2(i) + 1;
                        
                    else
                        break
                    end
                    
                 end
                 
             hh = hh + DELTA_V;  
             OO2(i) = hh;

            end
        
            

g3(nsize) = 0;

j = 0;

for r = 1:256
   
    for n = 1:256
        
        for m = 1:256
                     
                     j = j + 1;
                     g3(j) = W(r,n,m);
                     
        end
    end
end

p3 = sort(g3);

    Prob = 0;
    
      nsize2 = 128;
      DELTA_W = ((p3(nsize) - p3(1)) / (nsize2));
      hh = p3(1);
      ii = 1;
      OO3(nsize2) = hh;
      KK3(nsize2) = 0;
      
            for i = 1:1:nsize2
                                
                 for ii = ii:1:nsize
                                                    
                    if  (p3(ii) <= (hh+DELTA_W)) && (p3(ii) >= (hh))
                        
                         KK3(i) = KK3(i) + 1;
                        
                    else
                        break
                    end
                    
                 end
                 
             hh = hh + DELTA_W;  
             OO3(i) = hh;

            end
                         


ttt = 1:1:nsize2;

figure;

plot(OO3,((KK3)/(DELTA_W*nsize)))
hold on;
bar(OO3,((KK3)/(DELTA_W*nsize)),'g')

title('PDF FOR W')
xlabel('Velocity(m/s)')
ylabel('PDF')


sum = 0;
for r = 1:256
    for n = 1:256
        for m = 1:256
            sum = sum + ((U(r,n,m)-U_MEAN)*(U(r,n,m)-U_MEAN));
        end
    end
end

uu = sum / (256*256*256);

S = 'uu';
disp(S);
disp(uu);
   
sum = 0;
for r = 1:256
    for n = 1:256
        for m = 1:256
            sum = sum + ((V(r,n,m)-V_MEAN)*(V(r,n,m)-V_MEAN));
        end
    end
end

vv = sum / (256*256*256);
   
S = 'vv';
disp(S);
disp(vv);
   

sum = 0;
for r = 1:256
    for n = 1:256
        for m = 1:256
            sum = sum + ((W(r,n,m)-W_MEAN)*(W(r,n,m)-W_MEAN));
        end
    end
end

ww = sum / (256*256*256);
   
S = 'ww';
disp(S);
disp(ww);


sum = 0;
for r = 1:256
    for n = 1:256
        for m = 1:256
            sum = sum + ((U(r,n,m)-U_MEAN)*(V(r,n,m)-V_MEAN));
        end
    end
end

uv = sum / (256*256*256);
   
S = 'uv';
disp(S);
disp(uv);

sum = 0;
for r = 1:256
    for n = 1:256
        for m = 1:256
            sum = sum + ((U(r,n,m)-U_MEAN)*(W(r,n,m)-W_MEAN));
        end
    end
end

uw = sum / (256*256*256);
   
S = 'uw';
disp(S);
disp(uw);

sum = 0;
for r = 1:256
    for n = 1:256
        for m = 1:256
            sum = sum + ((V(r,n,m)-V_MEAN)*(W(r,n,m)-W_MEAN));
        end
    end
end

vw = sum / (256*256*256);
   
S = 'vw';
disp(S);
disp(vw);


 % compute correlation tensor
 
scaling = 1;

u_fft=fftn(U)./scaling;
v_fft=fftn(V)./scaling;
w_fft=fftn(W)./scaling;

Rij_x=(u_fft.*conj(u_fft)); 

Rij_y=(v_fft.*conj(v_fft));
Rij_z=(w_fft.*conj(w_fft));

R1=ifftn(Rij_x)/uu./256^3;
R2=ifftn(Rij_y)/vv./256^3;
R3=ifftn(Rij_z)/ww./256^3;

NFFT=size(u_fft,1);
R11 = (reshape(R3(1,1,:),NFFT(1),1)+R2(1,:,1)'+R1(:,1,1))/3;
R11 = R11(1:size(u_fft)/2+1);

R1_22 = (R1(1,:,1)+R3(1,:,1))/2;
R2_22 = (R2(:,1,1)+R3(:,1,1))/2;
R3_22 = (reshape(R1(1,1,:),size(u_fft,1),1)+reshape(R2(1,1,:),size(u_fft,1),1))/2;

R22 = (R1_22'+R2_22+R3_22)/3;
R22 = R22(1:size(u_fft)/2+1);

 
%f1

f1 = R11(1:128);

Lif = 0;
for i = 1:128
   Lif = Lif + (f1(i)*(pi/128));
end

S1 = 'Integral length scale for f';
disp(S1);
disp(Lif);

h = (2*pi)/256;
fz0 = (f1(3)-(2*f1(2))+f1(1))/(h^2);
Lmf = ((-2)/(fz0))^(0.5);

S2 = 'Taylor microscale for f';
disp(S2);
disp(Lmf);

t = 1:1:128;
tt = (2*pi)/256;
figure;
plot((t*tt),f1)
hold on

x1 = [0 Lif Lif];
y1 = [1 1 -0.15];

plot(x1,y1,'--')
hold on

r = 0;
fr = 0;
r = 0:Lmf/20:Lmf+0.02;
fr = 1 - ((r.^2)./(Lmf.^2));
plot(r,fr,'--')
hold off
legend('f','Integral length scale for f','Taylor microscale for f')

title('f(r)')
xlabel('r(m)')
ylabel('f')  


%g1
g1 = R22(1:128);

Lig = 0;
for i = 1:128
   Lig = Lig + (g1(i)*(pi/128));
end

S1 = 'Integral length scale for g';
disp(S1);
disp(Lig);

h = (2*pi)/256;
gz0 = (g1(3)-(2*g1(2))+g1(1))/(h^2);
Lmg = ((-2)/(gz0))^(0.5);

S2 = 'Taylor microscale for g';
disp(S2);
disp(Lmg);

t = 1:1:128;
tt = (2*pi)/256;
figure;
plot((t*tt),g1)
hold on

x1 = [0 Lig Lig];
y1 = [1 1 -0.2];

plot(x1,y1,'--')
hold on

r = 0;
gr = 0;
r = 0:Lmg/20:Lmg+0.03;
gr = 1 - ((r.^2)./(Lmg.^2));
plot(r,gr,'--')

legend('g','Integral length scale for g','Taylor microscale for g')

title('g(r)')
xlabel('r(m)')
ylabel('g')  



for r = 1:256
sum = 0;
    for n = 1:256
        for m = 1:256
            sum = sum + U(r,n,m);
        end
    end
    
U_MEAN_S(r) = sum / (256*256);

end


   
i=0;
for r = 256:-1:129
    i=i+1;
    sum = 0;
    for n = 1:256
        for m = 1:256
            sum = sum + ((U(256,n,m)-U_MEAN_S(256))*(U(r,n,m)-U_MEAN_S(r)));
        end
    end
   m1(i) = sum / (256*256);
end

i=0;
for r =  256:-1:129
    i=i+1;    
    sum = 0;
    for n = 1:256
        for m = 1:256
            sum = sum + ((U(256,n,m)-U_MEAN_S(256))^2);
        end
    end
   m2(i) = sum / (256*256);
 
end

f1 = 0;
f1 = m1./ m2;

for n = 1:256
sum = 0;
    for r = 1:256
        for m = 1:256
            sum = sum + V(r,n,m);
        end
    end
    
V_MEAN_S(n) = sum / (256*256);

end


for n = 1:128

    sum = 0;
    for r = 1:256
        for m = 1:256
            sum = sum + ((V(r,1,m)-V_MEAN_S(1))*(V(r,n,m)-V_MEAN_S(n)));
        end
    end
   m1(n) = sum / (256*256);
end


for n = 1:128
    sum = 0;
    for r = 1:256
        for m = 1:256
            sum = sum + ((V(r,1,m)-V_MEAN_S(1))^2);
        end
    end
   m2(n) = sum / (256*256);
 
end

f2 = m1./ m2;




for m = 1:256
sum = 0;
    for n = 1:256
        for r = 1:256
            sum = sum + W(r,n,m);
        end
    end
    
W_MEAN_S(m) = sum / (256*256);

end


   
i=0;
for m = 256:-1:129
    i=i+1;
    sum = 0;
    for n = 1:256
        for r = 1:256
            sum = sum + ((W(r,n,256)-W_MEAN_S(256))*(W(r,n,m)-W_MEAN_S(m)));
        end
    end
   m1(i) = sum / (256*256);
end

i=0;
for m = 256:-1:129
    i=i+1;
    sum = 0;
    for n = 1:256
        for r = 1:256
            sum = sum + ((W(r,n,256)-W_MEAN_S(256))^2);
        end
    end
   m2(i) = sum / (256*256);
 
end

f3 = m1./ m2;


L=length(f1);
NFFT=2^nextpow2(L+2);
tt=2*pi/255;
sampling_rate=1/tt;   
freq=0.5*sampling_rate*linspace(0,1,NFFT/2);


E=(fft(f1,NFFT)*uu)*4;
E1=(E.*conj(E)).*(2*pi/(255));

f = fliplr(freq);

E11=abs(E1(1:NFFT/2));

figure;
loglog(freq,E11);
hold on

nu = 0.01;
ff=f.*f;
Dissipation=8*nu*pi*pi*(ff.*E11);

plot(f,Dissipation);
hold on

%Enstrophy Evalute

for r = 1:1:128
sum = 0;
for i = 1:1:128
for j = 1:1:128
for k = 1:1:128
    
sum = sum + ((((U(i,j+r,k)-U(r,j,k))-(V(i+r,j,k)-V(r,j,k)))/(tt*r*sampling_rate))^2);


end
end
end

enstrophy(r) = 0.5*sum;

end

plot(f,enstrophy)
hold on


Slop =3000*(((freq).^(-(5/3))));

plot(freq,Slop)

legend('Energy Spectrum','Dissipation','Enstrophy','log(k^-5/3)')

title('Energy Spectrum, Dissipation and Enstrophy')
xlabel('k')
ylabel('Energy')  


figure;
loglog(freq,E11);
hold on
plot(freq,Slop)

legend('Energy Spectrum','log(k^-5/3)')
title('Energy Spectrum')
xlabel('k')
ylabel('Energy')  


figure;
loglog(f,Dissipation);

title('Dissipation')
xlabel('k')
ylabel('Energy')  


figure;
loglog(f,enstrophy);

title('Enstrophy')
xlabel('k')
ylabel('Energy')  

hold on

 
i = 0;
j = 0;

    for i = 1:1:256
        for j = 1:1:256
            
           X(i,j) = tt*i;
           Y(i,j) = tt*j;
            
        end
    end



i = 0;
j = 0;
k = 10;
    for i = 1:1:256
        for j = 1:1:256
           
           UC(i,j) = U(i,j,k);
           VC(i,j) = V(i,j,k);
            
        end
    end

figure;    
contourf(X,Y,UC)
title('Velocity-U(m/s)')
xlabel('X(m)')
ylabel('Y(m)')  

figure;
contourf(X,Y,VC)
title('Velocity-V(m/s)')
xlabel('X(m)')
ylabel('Y(m)')  

figure;
contourf(X,Y,(((UC.^2)+(VC.^2)).^(0.5)))
title('Velocity(m/s)')
xlabel('X(m)')
ylabel('Y(m)')  


figure;
h=slice(U,50,0,0);
hold on;
e=slice(U,150,0,0);
hold on;
g=slice(U,250,0,0);
set(h,'edgecolor','none');
set(e,'edgecolor','none');
set(g,'edgecolor','none');
view(-25,10);
grid on;
colormap hsv;
colorbar;
title('Velocity-U(m/s)')
xlabel('X(m)')
ylabel('Y(m)')  
zlabel('Z(m)')  

figure;
h=slice(V,50,0,0);
hold on;
e=slice(V,150,0,0);
hold on;
g=slice(V,250,0,0);
set(h,'edgecolor','none');
set(e,'edgecolor','none');
set(g,'edgecolor','none');
view(-25,10);
grid on;
colormap hsv;
colorbar;
title('Velocity-V(m/s)')
xlabel('X(m)')
ylabel('Y(m)')  
zlabel('Z(m)')  

figure;
h=slice((((V.^2)+(U.^2)).^(1/2)),50,0,0);
hold on;
e=slice((((V.^2)+(U.^2)).^(1/2)),150,0,0);
hold on;
g=slice((((V.^2)+(U.^2)).^(1/2)),250,0,0);
set(h,'edgecolor','none');
set(e,'edgecolor','none');
set(g,'edgecolor','none');
view(-25,10);
grid on;
colormap hsv;
colorbar;
title('Velocity(m/s)')
xlabel('X(m)')
ylabel('Y(m)')  
zlabel('Z(m)') 

figure;
h=slice((((V.^2)+(U.^2)).^(1/2)),1,1,1);
hold on;
n=slice((((V.^2)+(U.^2)).^(1/2)),256,256,256);
hold on;
g=slice((((V.^2)+(U.^2)).^(1/2)),256,1,1);
hold on;
e=slice((((V.^2)+(U.^2)).^(1/2)),1,256,1);
hold on;
o=slice((((V.^2)+(U.^2)).^(1/2)),1,1,256);
set(h,'edgecolor','none');
set(n,'edgecolor','none');
set(e,'edgecolor','none');
set(g,'edgecolor','none');
set(o,'edgecolor','none');
view(-25,10);
grid on;
colormap hsv;
colorbar;
title('Velocity(m/s)')
xlabel('X(m)')
ylabel('Y(m)')  
zlabel('Z(m)')  

%Q

i=0;
j=0;
k=0;

for i = 1:1:256  
for j = 1:1:256
for k = 1:1:256

   if (i~=256)&&(j~=256)&&(k~=256)   
    
   Q(i,j,k) = (-0.5*(U(i+1,j,k)-U(i,j,k)+(V(r,j+1,k)-V(i,j,k))...
   +(W(i,j,k+1)-W(i,j,k)))./tt);

   else if (i==256)&&(j~=256)&&(k~=256)   

   Q(i,j,k) = (-0.5*(U(i,j,k)-U(i-1,j,k)+(V(r,j+1,k)-V(i,j,k))...
   +(W(i,j,k+1)-W(i,j,k)))./tt);        
        
   else if (j==256)&&(i~=256)&&(k~=256)   

   Q(i,j,k) = (-0.5*(U(i+1,j,k)-U(i,j,k)+(V(r,j,k)-V(i,j-1,k))...
   +(W(i,j,k+1)-W(i,j,k)))./tt);              
        
   else if (k==256)&&(i~=256)&&(j~=256)   
        
   Q(i,j,k) = (-0.5*(U(i+1,j,k)-U(i,j,k)+(V(r,j+1,k)-V(i,j,k))...
   +(W(i,j,k)-W(i,j,k-1)))./tt); 

   else if (i==256)&&(j==256)&&(k~=256)   
        
   Q(i,j,k) = (-0.5*(U(i,j,k)-U(i-1,j,k)+(V(r,j,k)-V(i,j-1,k))...
   +(W(i,j,k+1)-W(i,j,k)))./tt); 

   else if (i==256)&&(j~=256)&&(k==256)   
        
   Q(i,j,k) = (-0.5*(U(i,j,k)-U(i-1,j,k)+(V(r,j+1,k)-V(i,j,k))...
   +(W(i,j,k)-W(i,j,k-1)))./tt); 

   else if (i~=256)&&(j==256)&&(k==256)   
        
   Q(i,j,k) = (-0.5*(U(i+1,j,k)-U(i,j,k)+(V(r,j,k)-V(i,j-1,k))...
   +(W(i,j,k)-W(i,j,k-1)))./tt); 

   else if (i==256)&&(j==256)&&(k==256)   
        
   Q(i,j,k) = (-0.5*(U(i,j,k)-U(i-1,j,k)+(V(r,j,k)-V(i,j-1,k))...
   +(W(i,j,k)-W(i,j,k-1)))./tt); 

   end
   end
   end        
   end
   end
   end
   end
   end
end
end
end

Q = abs(Q);

i = 0;
j = 0;
k = 10;
    for i = 1:1:256
        for j = 1:1:256
           
           QC(i,j) = Q(i,j,k);
            
        end
    end

figure;    
contourf(X,Y,QC)
title('Q Criterion')
xlabel('X(m)')
ylabel('Y(m)')  

figure;
h=slice(Q,50,0,0);
hold on;
e=slice(Q,150,0,0);
hold on;
g=slice(Q,250,0,0);
set(h,'edgecolor','none');
set(e,'edgecolor','none');
set(g,'edgecolor','none');
view(-25,10);
grid on;
colormap hsv;
colorbar;
title('Q Criterion')
xlabel('X(m)')
ylabel('Y(m)')  
zlabel('Z(m)')  

figure;
h=slice(Q,1,1,1);
hold on;
n=slice(Q,256,256,256);
hold on;
g=slice(Q,256,1,1);
hold on;
e=slice(Q,1,256,1);
hold on;
o=slice(Q,1,1,256);
set(h,'edgecolor','none');
set(n,'edgecolor','none');
set(e,'edgecolor','none');
set(g,'edgecolor','none');
set(o,'edgecolor','none');
view(-25,10);
grid on;
colormap hsv;
colorbar;
title('Q Criterion')
xlabel('X(m)')
ylabel('Y(m)')  
zlabel('Z(m)')  

fclose(fid);