clc
clear
close all

% dati geometrici
g = 2; % [m] altezza dal suolo
l1 = 2; % [m]
l2 = 3; % [m]
l3 = 3; % [m]
l4 = 2; % [m]

passi = 60;
ti = 0;
tf = 5;
T1 = linspace(ti,tf,passi);

p5 = [6/((tf^2 - 2*tf*ti + ti^2)*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)),...
     -(15*(tf + ti))/((tf - ti)*(tf^4 - 4*tf^3*ti + 6*tf^2*ti^2 - 4*tf*ti^3 + ti^4)), ...
      (10*(tf^2 + 4*tf*ti + ti^2))/((tf^2 - 2*tf*ti + ti^2)*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)), ...
     -(30*ti*(tf^2 + ti*tf))/((tf - ti)^2*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)), ...
      (30*tf^2*ti^2)/((tf - ti)^3*(tf^2 - 2*tf*ti + ti^2)), ...
     -(10*tf^2*ti^3 - 5*tf*ti^4 + ti^5)/((tf - ti)^3*(tf^2 - 2*tf*ti + ti^2))];

a5 = polyval(p5,T1);  %valutazione del polinomio p5 in funzione del tempo T
a = a5;

%% 1° SPAZIO DEI GIUNTI

% angoli iniziali in [rad]
q1_i = 0; 
q2_i = -deg2rad(12);
q3_i = -deg2rad(12);

% angoli finali in [rad]
q1_f = 0;
q2_f = 0;
q3_f = -deg2rad(4);

Qi = [q1_i q2_i q3_i]';
Qf = [q1_f q2_f q3_f]';
Q = a.*(Qf-Qi)+Qi;

for cont=1:passi

    Pv = DK3R1P(Q(:,cont),l1,l2,l3,l4);

    P1 = [0 l1 0]';
    P2 = [l2*cos(Q(1,cont))*cos(Q(2,cont)), l1 + l2*sin(Q(2,cont)), -l2*cos(Q(2,cont))*sin(Q(1,cont))]';
    P3 = [cos(Q(1,cont))*(l3*cos(Q(2,cont) + Q(3,cont)) + l2*cos(Q(2,cont))), l1 + l3*sin(Q(2,cont) + Q(3,cont)) + l2*sin(Q(2,cont)), -sin(Q(1,cont))*(l3*cos(Q(2,cont) + Q(3,cont)) + l2*cos(Q(2,cont)))]';

    G = [P1 P2 P3];

    O = [0 g 0]';

    robot = [O G Pv];

    plot3(robot(3,:),robot(1,:),robot(2,:),'-o','color','b');
    hold on
    axis equal
    grid on
    xlabel('z')
%     xlim([-6 6])
%     ylim([-2 11])
%     zlim([-6 6])
    ylabel('x')
    zlabel('y')
    title('Spazio dei giunti')
end

%% 2° SPAZIO DEI GIUNTI
passi = 200;
ti = 0;
tf = 5;
T2 = linspace(ti,tf,passi);

p5 = [6/((tf^2 - 2*tf*ti + ti^2)*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)),...
     -(15*(tf + ti))/((tf - ti)*(tf^4 - 4*tf^3*ti + 6*tf^2*ti^2 - 4*tf*ti^3 + ti^4)), ...
      (10*(tf^2 + 4*tf*ti + ti^2))/((tf^2 - 2*tf*ti + ti^2)*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)), ...
     -(30*ti*(tf^2 + ti*tf))/((tf - ti)^2*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)), ...
      (30*tf^2*ti^2)/((tf - ti)^3*(tf^2 - 2*tf*ti + ti^2)), ...
     -(10*tf^2*ti^3 - 5*tf*ti^4 + ti^5)/((tf - ti)^3*(tf^2 - 2*tf*ti + ti^2))];

a5 = polyval(p5,T2);  %valutazione del polinomio p5 in funzione del tempo T
a = a5;

% angoli iniziali in [rad]
q1_2_i = 0;
q2_2_i = 0;
q3_2_i = -deg2rad(4);

% angoli finali in [rad]
q1_2_f = pi;
q2_2_f = 0;
q3_2_f = -deg2rad(4);

Q2i = [q1_2_i q2_2_i q3_2_i]';
Q2f = [q1_2_f q2_2_f q3_2_f]';
Q2 = a.*(Q2f-Q2i)+Q2i;

for cont=1:passi

    Pv_2 = DK3R1P(Q2(:,cont),l1,l2,l3,l4);

    P1_2 = [0 l1 0]';
    P2_2 = [l2*cos(Q2(1,cont))*cos(Q2(2,cont)), l1 + l2*sin(Q2(2,cont)), -l2*cos(Q2(2,cont))*sin(Q2(1,cont))]';
    P3_2 = [cos(Q2(1,cont))*(l3*cos(Q2(2,cont) + Q2(3,cont)) + l2*cos(Q2(2,cont))), l1 + l3*sin(Q2(2,cont) + Q2(3,cont)) + l2*sin(Q2(2,cont)), -sin(Q2(1,cont))*(l3*cos(Q2(2,cont) + Q2(3,cont)) + l2*cos(Q2(2,cont)))]';

    G_2 = [P1_2 P2_2 P3_2];

    O = [0 g 0]';

    robot2 = [O G_2 Pv_2];

    plot3(robot2(3,:), robot2(1,:),robot2(2,:),'-o','color','r');
    hold on
    axis equal
    grid on
    xlabel('z')
%     xlim([-10 10])
%     ylim([-2 11])
%     zlim([-6 6])
    ylabel('x')
    zlabel('y')
    title('Spazio dei giunti')
end


% %% 3° SPAZIO DEI GIUNTI
% 
% % angoli iniziali in [rad]
% q1_3_i = pi/2;
% q2_3_i = 0;
% q3_3_i = -deg2rad(4);
% 
% % angoli finali in [rad]
% q1_3_f = pi;
% q2_3_f = 0;
% q3_3_f = -deg2rad(4);
% 
% Q3i = [q1_3_i q2_3_i q3_3_i]';
% Q3f = [q1_3_f q2_3_f q3_3_f]';
% Q3 = a.*(Q3f-Q3i)+Q3i;
% 
% for cont=1:passi
% 
%     Pv_3 = DK3R1P(Q3(:,cont),l1,l2,l3,l4);
% 
%     P1_3 = [0 l1 0]';
%     P2_3 = [l2*cos(Q3(1,cont))*cos(Q3(2,cont)), l1 + l2*sin(Q3(2,cont)), -l2*cos(Q3(2,cont))*sin(Q3(1,cont))]';
%     P3_3 = [cos(Q3(1,cont))*(l3*cos(Q3(2,cont) + Q3(3,cont)) + l2*cos(Q3(2,cont))), l1 + l3*sin(Q3(2,cont) + Q3(3,cont)) + l2*sin(Q3(2,cont)), -sin(Q3(1,cont))*(l3*cos(Q3(2,cont) + Q3(3,cont)) + l2*cos(Q3(2,cont)))]';
% 
%     G_3 = [P1_3 P2_3 P3_3];
% 
%     O = [0 g 0]';
% 
%     robot3 = [O G_3 Pv_3];
% 
%     plot3(robot3(3,:),robot3(1,:),robot3(2,:),'-o','color','r');
%     hold on
%     axis equal
%     grid on
%     xlabel('z')
% %     xlim([-10 10])
% %     ylim([-2 11])
% %     zlim([-6 6])
%     ylabel('x')
%     zlabel('y')
%     title('Spazio dei giunti')
% end
% 

