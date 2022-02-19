clc
clear all
close all

% Inputs Power Received for testing 
in = [2,3,4,5,6];
%[-84.625872518802620, -89.441270787708290,-1.181866565728189e+02,-1.295369357851364e+02,-1.390539434441358e+02];

% Givens
freq = 2.4*power(10,9);           %frequency in Hz
lamda = (3*10.^8)/freq;           %lamda of given frequency
PT_dBm = 20;                      %power in dBm
PT_watt = (10.^(PT_dBm/10))/1000; %power in watt
path_loss = 3;                    %path loss factor
PAF = 3;                          %Partition Attenuation Factor
GT = 1;                           %Grx and Gtx are unity gains.
GR = 1;

% Black blocks (access points)
AP1 = [8,15.5625];
AP2 = [17.5,4];
AP3 = [30,15.5625];
AP4 = [43.5,4];
AP5 = [52,15.5625];
% x,y,Len,Width
Walls = [14,8,22,8; 40,8,48,8; 6,0,6,15; 14,0,14,15; 22,0,22,15; 28,0,28,15; 34,0,34,15;
        40,0,40,15; 48,0,48,15; 56,0,56,15; 0,0,0,15; 0,0,64,0; 64,0,64,15;0,15,0,20;
        2,15,2,20; 6,16.5,6,20; 11,16.5,11,20; 16,16.5,16,20; 21,16.5,21,20; 26,16.5,26,20;
        31,16.5,31,20; 36,16.5,36,20; 41,16.5,41,20; 46,16.5,46,20; 51,16.5,51,20; 0,20,56,20; 
        56,16.5,56,20];

% Coordinates to draw the walls as lines
x_walls = [Walls(:,1) Walls(:,3)];
y_walls = [Walls(:,2) Walls(:,4)];

% Comparison point
for i = 0.5:0.5:64     % 64 is upper bound of x
    for j = 0.5:0.5:20 % 20 is upper bound of y
        a = [i,j];
        int_AP1 = 0;
        int_AP2 = 0;
        int_AP3 = 0;
        int_AP4 = 0;
        int_AP5 = 0;

        %loop on walls to get number of intersections with every AP
        for k = 1:length(Walls)
            % X_Cord"of user", Y_Cord"of user", X_Cord"of AP",
            % Y_Cord"AP",First wall "3ala shakl 7rf 'L' "
       
            AP1_tmp = intersects(a(1),a(2),AP1(1),AP1(2),Walls(k,1),Walls(k,2),Walls(k,3),Walls(k,4));
            AP2_tmp = intersects(a(1),a(2),AP2(1),AP2(2),Walls(k,1),Walls(k,2),Walls(k,3),Walls(k,4));
            AP3_tmp = intersects(a(1),a(2),AP3(1),AP3(2),Walls(k,1),Walls(k,2),Walls(k,3),Walls(k,4));
            AP4_tmp = intersects(a(1),a(2),AP4(1),AP4(2),Walls(k,1),Walls(k,2),Walls(k,3),Walls(k,4));
            AP5_tmp = intersects(a(1),a(2),AP5(1),AP5(2),Walls(k,1),Walls(k,2),Walls(k,3),Walls(k,4));
            if(AP1_tmp)
                int_AP1 = int_AP1 + 1;
            end
            if(AP2_tmp)
                int_AP2 = int_AP2 + 1;
            end
            if(AP3_tmp)
                int_AP3 = int_AP3 + 1;
            end
            if(AP4_tmp)
                int_AP4 = int_AP4 + 1;
            end
            if(AP5_tmp)
                int_AP5 = int_AP5 + 1;
            end
        end
        
        m = i+i;
        n = j+j;

        % number of wall intersections between points and every AP
        % Matrix containing the number of intersections of every user
        int_AP1_mat(m,n,1) = int_AP1;
        int_AP2_mat(m,n,1) = int_AP2;
        int_AP3_mat(m,n,1) = int_AP3;
        int_AP4_mat(m,n,1) = int_AP4;
        int_AP5_mat(m,n,1) = int_AP5;
        
        % distance between points and every AP TO Calculate the "power"
        % Takes 2 points and Calculate distance between them 
        dist_AP1(m,n,1) = norm(a-AP1);
        dist_AP2(m,n,1) = norm(a-AP2);
        dist_AP3(m,n,1) = norm(a-AP3);
        dist_AP4(m,n,1) = norm(a-AP4);
        dist_AP5(m,n,1) = norm(a-AP5);
        
        d=1;
        % Power received from AP1 to each point in Free Space
        Power_rcvd_AP1_in_free_space_watt = (PT_watt*GT*GR*(lamda.^2))/((4*pi*(dist_AP1(m,n,1)).^2));
        PR_AP1(m,n,1) = 10.^(Power_rcvd_AP1_in_free_space_watt/10)-(10*path_loss*log(dist_AP1(m,n,1)/d))-(PAF*int_AP1_mat(m,n,1));
        % Margin of error between input and AP1
        Error_AP1(m,n,1) = abs(PR_AP1(m,n,1) - in(1));
        
        % Power received from AP2 to each point in Free Space
        Power_rcvd_AP2_in_free_space_watt = (PT_watt*GT*GR*(lamda.^2))/((4*pi*(dist_AP2(m,n,1)).^2));
        PR_AP2(m,n,1) = 10.^(Power_rcvd_AP2_in_free_space_watt/10)-(10*path_loss*log(dist_AP2(m,n,1)/d))-(PAF*int_AP2_mat(m,n,1));
        % Margin of error between input and AP2
        Error_AP2(m,n,1) = abs(PR_AP2(m,n,1) - in(2));
        
        % Power received from AP3 to each point in Free Space
        Power_rcvd_AP3_in_free_space_watt = (PT_watt*GT*GR*(lamda.^2))/((4*pi*(dist_AP3(m,n,1)).^2));
        PR_AP3(m,n,1) = 10.^(Power_rcvd_AP3_in_free_space_watt/10)-(10*path_loss*log(dist_AP3(m,n,1)/d))-(PAF*int_AP3_mat(m,n,1));
        % Margin of error between input and AP3
        Error_AP3(m,n,1) = abs(PR_AP3(m,n,1) - in(3));
        
        % Power received from AP4 to each point in Free Space
        Power_rcvd_AP4_in_free_space_watt = (PT_watt*GT*GR*(lamda.^2))/((4*pi*(dist_AP4(m,n,1)).^2));
        PR_AP4(m,n,1) = 10.^(Power_rcvd_AP4_in_free_space_watt/10)-(10*path_loss*log(dist_AP4(m,n,1)/d))-(PAF*int_AP4_mat(m,n,1));
        % Margin of error between input and AP4
        Error_AP4(m,n,1) = abs(PR_AP4(m,n,1) - in(4));
        
        % Power received from AP5 to each point in Free Space
        Power_rcvd_AP5_in_free_space_watt = (PT_watt*GT*GR*(lamda.^2))/((4*pi*(dist_AP5(m,n,1)).^2));
        PR_AP5(m,n,1) = 10.^(Power_rcvd_AP5_in_free_space_watt/10)-(10*path_loss*log(dist_AP5(m,n,1)/d))-(PAF*int_AP5_mat(m,n,1));
        % Margin of error between input and AP5
        Error_AP5(m,n,1) = abs(PR_AP5(m,n,1) - in(5));
                
        % Calculates total error between point and APs
        Total_error(m,n,1) =  Error_AP1(m,n,1)+Error_AP2(m,n,1)+Error_AP3(m,n,1)+Error_AP4(m,n,1)+Error_AP5(m,n,1);
    end
end

% Sum of power rcvd due to each AP
PR_APs = PR_AP1+PR_AP2+PR_AP3+PR_AP4+PR_AP5;

Min_error_APs = min(min(Total_error));
[x_res,y_res] = find(Total_error==Min_error_APs);

x_res = x_res/2;
y_res = y_res/2;

disp('x = ');
disp(x_res);
disp('y = ');
disp(y_res);

% Plotting of graphs
hold on
plot([x_res AP1(1)],[y_res AP1(2)]);
plot([x_res AP2(1)],[y_res AP2(2)]);
plot([x_res AP3(1)],[y_res AP3(2)]);
plot([x_res AP4(1)],[y_res AP4(2)]);
plot([x_res AP5(1)],[y_res AP5(2)]);

plot(x_walls',y_walls');
plot(x_res, y_res, '-o');
plot(AP1(1), AP1(2), '*-');
plot(AP2(1), AP2(2), '*-');
plot(AP3(1), AP3(2), '*-');
plot(AP4(1), AP4(2), '*-');
plot(AP5(1), AP5(2), '*-');

hold off

figure()

subplot(3,2,1);
contourf(PR_AP1');
title('AP1');

subplot(3,2,2);
contourf(PR_AP2');
title('AP2');

subplot(3,2,3);
contourf(PR_AP3');
title('AP3');

subplot(3,2,4);
contourf(PR_AP4');
title('AP4');

subplot(3,2,5);
contourf(PR_AP5');
title('AP5');

subplot(3,2,6);
contourf(PR_APs');
title('All APs');