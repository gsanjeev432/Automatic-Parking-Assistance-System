clc
close all
clearvars

%% Declare global variables
global wl;
global ww;
global D;
global L;
global WSeta; 
wl=7;
ww=2;
    A=15;
    L=20;
    D=5;
    F=8;
    B=L+D+F;

    %% Rectangle Coordinates for Parked car 1
    
    Parked_Car1x1=0;
    Parked_Car1y1=-6;
    Parked_Car1x2=0;
    Parked_Car1y2=22;
    Parked_Car1x3=15;
    Parked_Car1y3=22;
    Parked_Car1x4=15;
    Parked_Car1y4=-6;

    %% Rectangle Coordinates for Parked car 2
    
    Parked_Car2x1=0;
    Parked_Car2y1=70;
    Parked_Car2x2=0;
    Parked_Car2y2=100;
    Parked_Car2x3=15;
    Parked_Car2y3= 100;
    Parked_Car2x4=15;
    Parked_Car2y4=70;
    
    %%  Tuning Parameters
    
    WSeta=45; 
    WSeta=(WSeta/180)*pi; % degree to radians
    S=3;
    xi=Parked_Car2x4+S;
    yi=Parked_Car2y4-9;
    f1e=38;


    %% Simulation Setup
    
    axis([-60 100 -20 100],'equal');
    t=0:0.01:pi;
    seta=2*t;
    Xc=xi-(L/tan(WSeta));
    Yc=yi+D;
    
    
    Rbl=sqrt(D^2+(L/tan(WSeta))^2);
    phi=atan(D/(L/tan(WSeta)));

%% Initialize start scenario

            i=1;
            x=Xc+Rbl*cos(seta(i)+phi);
            y=Yc-Rbl*sin(seta(i)+phi);
            patch([Parked_Car2x1 Parked_Car2x2 Parked_Car2x3 Parked_Car2x4],[Parked_Car2y1 Parked_Car2y2 Parked_Car2y3 Parked_Car2y4],[1 0 0]);
            patch([Parked_Car1x1 Parked_Car1x2 Parked_Car1x3 Parked_Car1x4],[Parked_Car1y1 Parked_Car1y2 Parked_Car1y3 Parked_Car1y4],[0 0 1]);
            Turn1(x,y,A,B,seta(i));
            pause(4);


%% Car Parking Simulation Scenario

    for i=2:f1e
            x=Xc+Rbl*cos(seta(i)+phi);
            y=Yc-Rbl*sin(seta(i)+phi);
            cla;
            patch([Parked_Car2x1 Parked_Car2x2 Parked_Car2x3 Parked_Car2x4],[Parked_Car2y1 Parked_Car2y2 Parked_Car2y3 Parked_Car2y4],[1 0 0]);
            patch([Parked_Car1x1 Parked_Car1x2 Parked_Car1x3 Parked_Car1x4],[Parked_Car1y1 Parked_Car1y2 Parked_Car1y3 Parked_Car1y4],[0 0 1]);
            Turn1(x,y,A,B,seta(i));
            pause(.05);
    end




     xi=x+A*cos(seta(f1e));
     yi=y-A*sin(seta(f1e));
    Xc=xi+Rbl*cos(seta(f1e));
    Yc=yi-Rbl*sin(seta(f1e));
    pause(1);


    
    for i=f1e:-1:1
            x=Xc-Rbl*cos(seta(i));
            y=Yc+Rbl*sin(seta(i));
            cla;
            patch([Parked_Car2x1 Parked_Car2x2 Parked_Car2x3 Parked_Car2x4],[Parked_Car2y1 Parked_Car2y2 Parked_Car2y3 Parked_Car2y4],[1 0 0]);
            patch([Parked_Car1x1 Parked_Car1x2 Parked_Car1x3 Parked_Car1x4],[Parked_Car1y1 Parked_Car1y2 Parked_Car1y3 Parked_Car1y4],[0 0 1]);
            [xa1, xb1, xb2, xa2, ya1, yb1, yb2, ya2]=Turn2(x,y,A,B,seta(i));
            pause(.05);
    end

    
 pause(1);
 for i=1:13
 ya1=ya1+.5;
 yb1=yb1+.5;
 ya2=ya2+.5;
 yb2=yb2+.5;
 cla;
 patch([Parked_Car2x1 Parked_Car2x2 Parked_Car2x3 Parked_Car2x4],[Parked_Car2y1 Parked_Car2y2 Parked_Car2y3 Parked_Car2y4],[1 0 0]);
 patch([Parked_Car1x1 Parked_Car1x2 Parked_Car1x3 Parked_Car1x4],[Parked_Car1y1 Parked_Car1y2 Parked_Car1y3 Parked_Car1y4],[0 0 1]);           
 patch([xa1 xb1 xb2 xa2],[ya1 yb1 yb2 ya2],[0 1 0]);
 ya11=ya1+(D-wl/2);
 yb11=ya11+wl;
 ya21=ya2+(D-wl/2);
 yb21=ya21+wl;
 xa11=xa2+(ww/2);
 xb11=xa2+(ww/2);
 xa21=xa2-(ww/2);
 xb21=xa2-(ww/2);
 patch([xa11 xb11 xb21 xa21],[ya11 yb11 yb21 ya21],[0 0 0]);
 xa22=xa1-(ww/2);
 xb22=xa1-(ww/2);
 xa12=xa1+(ww/2);
 xb12=xa1+(ww/2);
 patch([xa12 xb12 xb22 xa22],[ya11 yb11 yb21 ya21],[0 0 0]);
 ya13=ya11+L;
 yb13=yb11+L;
 patch([xa11 xb11 xb21 xa21],[ya13 yb13 yb13 ya13],[0 0 0]);
 patch([xa12 xb12 xb22 xa22],[ya13 yb13 yb13 ya13],[0 0 0]);
 
 pause(.02);
 end
    