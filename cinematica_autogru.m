clc
clear 
close all

%% CINEMATICA DIRETTA DI POSIZIONE
syms q1 q2 q3 l1 l2 l3 l4 xP yP zP real

q = [q1 q2 q3]'; 
p = [xP yP zP]';

T01 = [cos(q1)  0  sin(q1)  0;
         0      1     0    l1;   
      -sin(q1)  0  cos(q1)  0;  
        0       0     0     1];   
P1 = p == T01(1:3,4);                                                    %#ok<*NASGU> 

T12 = [cos(q2)  -sin(q2)  0  l2*cos(q2);
       sin(q2)   cos(q2)  0  l2*sin(q2);
         0         0      1           0;
         0         0      0           1];
T02 = simplify(T01*T12);
P2 = p == T02(1:3,4);

T23 = [cos(q3)  -sin(q3) 0  l3*cos(q3);
       sin(q3)   cos(q3) 0  l3*sin(q3);
         0         0     1           0;
         0         0     0           1];
T03 = simplify(T01*T12*T23);
P3 = p == T03(1:3,4);

T34 = [ cos(pi/2)  0  sin(pi/2) l4;
            0      1     0       0;
       -sin(pi/2)  0  cos(pi/2)  0;
            0      0     0      1];
T04 = simplify(T01*T12*T23*T34);

Phi = p == T04(1:3,4);

%% posizione della gru

g = 2; % altezza da terra
l1_val = 4;  % [m] lunghezza link 1
l2_val = 3;  % [m] lunghezza link 2
l3_val = 3;  % [m] lunghezza link 3
l4_val = 2;  % [m] lunghezza link 4
q1_val = 0;  % [rad] angolo di rotazione del giunto 1
q2_val = 0;  % [rad] angolo di rotazione del giunto 2
q3_val = -deg2rad(4); % [rad] angolo di rotazione del giunto 3

T01_val = subs(T01, [l1, q1], [l1_val, q1_val]);
T12_val = subs(T12, [l1, l2, q2, q1], [l1_val, l2_val, q2_val, q1_val]);
T23_val = subs(T23, [l2, q2, l3, q3], [l2_val, q2_val, l3_val, q3_val]);
T34_val = subs(T34, [l3, q3, l4], [l3_val, q3_val, l4_val]);
T04_val = simplify(T01_val * T12_val * T23_val*T34_val);

p1_val = T01_val*[0 0 0 1]';
p2_val = T01_val*T12_val*[0 0 0 1]';
p3_val = T01_val*T12_val*T23_val*[0 0 0 1]';
p4_val = T01_val*T12_val*T23_val*T34_val*[0 0 0 1]';

% p1 = T01*[0 0 0 1]';
% p2 = T01*T12*[0 0 0 1]';
% p3 = T01*T12*T23*[0 0 0 1]';
% p4 = T01*T12*T23*T34*[0 0 0 1]';

% P1 = p1(1:3);
% P2 = p2(1:3);
% P3 = p3(1:3);
% P4 = p4(1:3);
% O = [0 0 0]';

P1 = p1_val(1:3);
P2 = p2_val(1:3);
P3 = p3_val(1:3);
P4 = p4_val(1:3);
O = [0 g 0]';  % ho messo g 

dati = [O P1 P2 P3 P4];

plot3(dati(3,:),dati(1,:),dati(2,:),'-o','MarkerFaceColor','r') % abbiamo ruotato gli assi per ottenere una visualizzazione migliore
hold on
grid on
axis equal
xlabel('z [m]')
ylabel('x [m]')
zlabel('y [m]')
% xlim([0 12])
% ylim([0 12])
zlim([0 5])
title('Configurazione iniziale gru')
% legend('giunti')




%% cinematica diretta di velocità

% J = jacobian(T04(1:3,4),q);
% 
% detJ = simplify(det(J)); 
% 
% sing = solve(detJ==0,q2,q3);
