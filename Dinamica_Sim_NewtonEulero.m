clear
clc
close all

% PARAMETRI INERZIALI  E GEOMETRICI DEL SISTEMA
syms m1 m2 m3 m4 real  % massa delle aste in [kg]
syms m5 real % massa da sollevare in [kg]
syms m_c real %massa del camion in [kg]

syms I1_ [3 3] real % matrice inerzia 3x3 
syms I2_ [3 3] real
syms I3_ [3 3] real
syms I4_ [3 3] real

syms l1 l2 l3 l4 real % lunghezze delle aste in [m]
syms l_c real % altezza del camion in [m]
syms l5 real % lunghezza del corpo da sollevare, che è stato trattato come asta


% PARAMETRI DEI GIUNTI
syms q1 q2 q3 q5 q_c real % angoli d'inclinazione tra i corpi in [rad]
syms q1d q2d q3d q5d q_cd real % velocità angolari (riferite al sistema locale dei corpi) in [rad/s]
syms q1dd q2dd q3dd q5dd q_cdd real % accelerazioni angolari (riferite al sistema locale dei corpi) in [rad/s^2]

% VETTORI POSIZIONE, VELOCITA' E ACCELERAZIONE
q = [q1 q2 q3 q5 q_c]';
qd = [q1d q2d q3d q5d q_cd]';
qdd = [q1dd q2dd q3dd q5dd q_cdd]';

% COMPONENTI DELLE REAZIONI VINCOLARI TRA CORPO i E CORPO i+1 in [N]
syms f0cx f0cy f0cz fc1x fc1y fc1z f12x f12y f12z f23x f23y f23z f34x f34y f34z f45x f45y f45z real

syms g real % accelerazione di gravità in [m/s^2]

% VETTORI DELLE REAZIONI VINCOLARI
f0c = [f0cx f0cy f0cz]';
fc1 = [fc1x fc1y fc1z]';
f12 = [f12x f12y f12z]';
f23 = [f23x f23y f23z]';
f34 = [f34x f34y f34z]';
f45 = [f45x f45y f45z]';

g_v =[0 -g 0]'; % vettore accelerazioni di gravità

% COMPONENTI DELLE COPPIE AI GIUNTI IN [Nm]
syms tau0x tau0y tau0z tau1x tau1y tau1z tau2x tau2y tau2z tau3x tau3y tau3z tau4x tau4y tau4z tau5x tau5y tau5z real

% VETTORI DELLE COPPIE AI GIUNTI
Tau0 = [tau0x tau0y tau0z]';
Tau1 = [tau1x tau1y tau1z]';
Tau2 = [tau2x tau2y tau2z]';
Tau3 = [tau3x tau3y tau3z]';
Tau4 = [tau4x tau4y tau4z]';
Tau5 = [tau5x tau5y tau5z]';

% CINEMATICA
% camion
Pg_c = [0 l_c/2 0]'; % posizione del baricentro del camion
P_c = [0 l_c 0]'; % posizione finale del camion
vg_c = jacobian(Pg_c,q)*qd; % velocità lineare del camion

% link 1
Pg1 = [0 l_c 0]' + [0 l1/2 0]'; % posizione del baricentro del link 1
P1 = [0 l_c+l1 0]'; % posizione finale del link 1
vg1 = jacobian(Pg1,q)*qd; % velocità lineare del link 1

R01 = [cos(q1)  0  sin(q1); % matrice di rotazione relativa al link 1
         0      1        0;
      -sin(q1)  0  cos(q1)];

R01d = R01*0;

for cont=1:numel(R01)
    R01d(cont) = jacobian(R01(cont),q)*qd;
end
S1 = simplify(R01d*R01'); % matrice delle velocità angolari 
w1 = [-S1(2,3) S1(1,3) -S1(1,2)]'; % vettore velocità angolare del link 1 
w1d = jacobian(w1,q)*qd + jacobian(w1,qd)*qdd; % vettore accelerazione angolare del link 1 

% link 2
Pg2 =[0 l_c+l1 0]'+l2/2*[cos(q1+q2) sin(q2) -(cos(q2)*sin(q1))]'; % posizione del baricentro del link 2
P2 = [l2*cos(q1+q2) l_c+l1+l2*sin(q2) -l2*cos(q2)*sin(q1)]'; % posizione finale del link 2
vg2 = jacobian(Pg2,q)*qd; % velocità lineare del link 2

R12 = [cos(q2) -sin(q2) 0; % matrice di rotazione del link 2 rispetto al link 1
       sin(q2)  cos(q2) 0;
           0        0   1];
R02 = R01*R12; % matrice di rotazione del link 2 rispetto al sistema di riferimento globale, ottenuta per composizione

R02d = R02*0;

for cont=1:numel(R02)
    R02d(cont) = jacobian(R02(cont),q)*qd;
end
S2 = simplify(R02d*R02'); % matrice delle velocità angolari 
w2 = [-S2(2,3) S2(1,3) -S2(1,2)]'; % vettore velocità angolare del link 2
w2d = jacobian(w2,q)*qd + jacobian(w2,qd)*qdd;  % vettore accelerazione angolare del link 2

% link 3
Pg3 =[0 l_c+l1 0]'+l2*[cos(q1+q2) sin(q2) -(cos(q2)*sin(q1))]'+l3/2*[cos(q2+q3)*cos(q1) sin(q2+q3) -cos(q2+q3)*sin(q1)]'; % posizione del baricentro del link 3
P3 = [cos(q1)*(l3*cos(q2+q3)+l2*cos(q2)) l_c+l1+l3*sin(q2+q3)+l2*sin(q2) -sin(q1)*(l3*cos(q2+q3)+l2*cos(q2))]'; % posizione finale del link 3
vg3 = jacobian(Pg3,q)*qd; % velocità lineare del link 3

R23 = [cos(q3) -sin(q3) 0; % matrice di rotazione del link 3 rispetto al link 2
       sin(q3)  cos(q3) 0;
             0        0 1];

R03 = R01*R12*R23; % matrice di rotazione del link 3 rispetto al sistema di riferimento globale, ottenuta per composizione

R03d = R03*0;

for cont=1:numel(R03)
    R03d(cont) = jacobian(R03(cont),q)*qd;
end
S3 = simplify(R03d*R03');
w3 = [-S3(2,3) S3(1,3) -S3(1,2)]';
w3d = jacobian(w3,q)*qd + jacobian(w3,qd)*qdd;

% link 4
Pg4 = R01*[0 l_c+l1 0]'+l2*[cos(q1+q2) sin(q2) -(cos(q2)*sin(q1))]'+l3*[cos(q2+q3)*cos(q1) sin(q2+q3) -cos(q2+q3)*sin(q1)]'+l4/2*[cos(q2+q3)*cos(q1) sin(q2+q3) -cos(q2+q3)*sin(q1)]'; % posizione del baricentro del link 4
P4 =[cos(q1)*(l3*cos(q2+q3)+l4*cos(q2+q3)+l2*cos(q2)) l_c+l1+l3*sin(q2+q3)+l4*sin(q2+q3)+l2*sin(q2) -sin(q1)*(l3*cos(q2+q3)+l4*cos(q2+q3)+l2*cos(q2))]'; % posizione finale del link 4 
vg4 = jacobian(Pg4,q)*qd; % velocità lineare del link 4

R03 = R01*R12*R23; %il link 4 è collegato al link 3 mediante una prismatica, quindi la matrice di rotazione del link 4 coincide con quella del link 3

R03d = R03*0;

for cont=1:numel(R03)
    R03d(cont) = jacobian(R03(cont),q)*qd;
end
S4 = simplify(R03d*R03');
w4 = [-S4(2,3) S4(1,3) -S4(1,2)]';
w4d = jacobian(w4,q)*qd + jacobian(w4,qd)*qdd;

% massa da sollevare (link 5)
Pg5 = R01*[0 l_c+l1 0]'+l2*[cos(q1+q2) sin(q2) -(cos(q2)*sin(q1))]'+l3*[cos(q2+q3)*cos(q1) sin(q2+q3) -cos(q2+q3)*sin(q1)]'+l4*[cos(q2+q3)*cos(q1) sin(q2+q3) -cos(q2+q3)*sin(q1)]' + l5/2*[cos(q2+q3)*cos(q1)*cos(q5) sin(q2+q3+q5) -cos(q2+q3+q5)*sin(q1)]'; % posizione del baricentro del link 5
P5 =[cos(q1)*(l3*cos(q2+q3)+l4*cos(q2+q3)+l2*cos(q2)+l5*cos(q2+q3+q5)) l_c+l1+l3*sin(q2+q3)+l4*sin(q2+q3)+l2*sin(q2)+l5*sin(q2+q3+q5) -sin(q1)*(l3*cos(q2+q3)+l4*cos(q2+q3)+l2*cos(q2)+l5*cos(q2+q3+q5))]';  % posizione finale del link 5
vg5 = jacobian(Pg5,q)*qd; % velocità lineare del link 5

% non vengono calcolate velocità ed accelerazione angolare del link 5 in
% quanto considerato come un corpo che viene sollevato dal link 4 senza ruotare

% derivata del jacobiano e accelerazioni lineari
J1=jacobian(Pg1,q);
for a=1:3
    for b=1:5
        J1d(a,b) = jacobian(J1(a,b),q)*qd;
    end    
end    

J2=jacobian(Pg2,q);
for a=1:3
    for b=1:5
        J2d(a,b) = jacobian(J2(a,b),q)*qd;
    end    
end 

J3=jacobian(Pg3,q);
for a=1:3
    for b=1:5
        J3d(a,b) = jacobian(J3(a,b),q)*qd;
    end    
end 

J4=jacobian(Pg4,q);
for a=1:3
    for b=1:5
        J4d(a,b) = jacobian(J4(a,b),q)*qd;
    end    
end 

J5=jacobian(Pg5,q);
for a=1:3
    for b=1:5
        J5d(a,b) = jacobian(J5(a,b),q)*qd;
    end    
end 

% accelerazioni lineari
ag_c = [0 0 0]';  % il camion è fermo a terra 
ag1 = J1d*qd + J1*qdd; 
ag2 = J2d*qd + J2*qdd;
ag3 = J3d*qd + J3*qdd;
ag4 = J4d*qd + J4*qdd;
ag5 = J5d*qd + J5*qdd;

% 1° EQUAZIONE DELLA DINAMICA -> EQ. DELLE FORZE

eqF_c = f0c - fc1 + m_c*g_v - m_c*ag_c;
eqF_1 = fc1 - f12 + m1*g_v -m1*ag1;
eqF_2 = f12 - f23 + m2*g_v -m2*ag2;
eqF_3 = f23 - f34 + m3*g_v -m3*ag3;
eqF_4 = f34 - f45 + m4*g_v -m4*ag4;
eqF_5 = f45 - 0 + m5*g_v -m5*ag5;

% momento d'inerzia nel sistema di riferimento globale
I1 = simplify(R01*I1_*R01'); 
I2 = simplify(R02*I2_*R02');
I3 = simplify(R03*I3_*R03');
I4 = simplify(R03*I4_*R03');


% 2° EQUAZIONE DELLA DINAMICA -> EQ. DEI MOMENTI

eqM_c = Tau0 - Tau1 - cross([Pg_c],[f0c]) + cross([Pg_c],[-fc1]);
eqM_1 = Tau1 - Tau2 - cross([Pg1-P_c],[fc1]) + cross([P1-Pg1],[-f12]) - I1*w1d - cross([w1],[I1*w1]);
eqM_2 = Tau2 - Tau3 - cross([Pg2-P1],[f12]) + cross([P2-Pg2],[-f23]) - I2*w2d - cross([w2],[I2*w2]);
eqM_3 = Tau3 - Tau4 - cross([Pg3-P2],[f23]) + cross([P3-Pg3],[-f34]) - I3*w3d - cross([w3],[I3*w3]);
eqM_4 = Tau4 - Tau5 - cross([Pg4-P3],[f34]) + cross([P4-Pg4],[-f45]) - I4*w4d - cross([w4],[I4*w4]);
eqM_5 = Tau5 - cross([Pg5-P4],[f45]);   

sol = solve(eqF_c(1),eqF_c(2),eqF_c(3),eqF_1(1),eqF_1(2),eqF_1(3),eqF_2(1),eqF_2(2),eqF_2(3),eqF_3(1),eqF_3(2),eqF_3(3),eqF_4(1),eqF_4(2),eqF_4(3),eqF_5(1),eqF_5(2),eqF_5(3),eqM_c(1),eqM_c(2),eqM_c(3),eqM_1(1),eqM_1(2),eqM_1(3),eqM_2(1),eqM_2(2),eqM_2(3),eqM_3(1),eqM_3(2),eqM_3(3),eqM_4(1),eqM_4(2),eqM_4(3),eqM_5(1),eqM_5(2),eqM_5(3),f0cx,f0cy,f0cz,fc1x,fc1y,fc1z,f12x,f12y,f12z,f23x,f23y,f23z,f34x,f34y,f34z,f45x,f45y,f45z,tau0x,tau0y,tau0z,tau1x,tau1y,tau1z,tau2x,tau2y,tau2z,tau3x,tau3y,tau3z,tau4x,tau4y,tau4z,tau5x,tau5y,tau5z);

% calcolo delle componenti delle reazioni vincolari
f0cx = simplify(sol.f0cx);
f0cy = simplify(sol.f0cy);
f0cz = simplify(sol.f0cz);
fc1x = simplify(sol.fc1x);
fc1y = simplify(sol.fc1y);
fc1z = simplify(sol.fc1z);
f12x = simplify(sol.f12x);
f12y = simplify(sol.f12y);
f12z = simplify(sol.f12z);
f23x = simplify(sol.f23x);
f23y = simplify(sol.f23y);
f23z = simplify(sol.f23z);
f34x = simplify(sol.f34x);
f34y = simplify(sol.f34y);
f34z = simplify(sol.f34z);
f45x = simplify(sol.f45x);
f45y = simplify(sol.f45y);
f45z = simplify(sol.f45z);


% calcolo delle componenti delle coppie dei giunti
tau0x = simplify(sol.tau0x);
tau0y = simplify(sol.tau0y);
tau0z = simplify(sol.tau0z);
tau1x = simplify(sol.tau1x);
tau1y = simplify(sol.tau1y);
tau1z = simplify(sol.tau1z);
tau2x = simplify(sol.tau2x);
tau2y = simplify(sol.tau2y);
tau2z = simplify(sol.tau2z);
tau3x = simplify(sol.tau3x);
tau3y = simplify(sol.tau3y);
tau3z = simplify(sol.tau3z);
tau4x = simplify(sol.tau4x);
tau4y = simplify(sol.tau4y);
tau4z = simplify(sol.tau4z);
tau5x = simplify(sol.tau5x);
tau5y = simplify(sol.tau5y);
tau5z = simplify(sol.tau5z);


