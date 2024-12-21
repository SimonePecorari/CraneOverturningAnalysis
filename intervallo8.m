clc
clear
close all

% DATI PROGETTUALI
m1 = 100;   % massa del link 1 in [kg]
m2 = 80;    % massa del link 2 in [kg]
m3 = 80;    % massa del link 3 in [kg]
m4 = 40;    % massa del link 4 in [kg]
m5 = 900;   % massa da sollevare ammissibile per le condizioni imposte nella statica in [kg]
m_c = 7580; % massa del camion + massa operatore (7500 + 80) in [kg]

l1 = 2;     % lunghezza del link 1 in [m]
l2 = 3;     % lunghezza del link 2 in [m]
l3 = 3;     % lunghezza del link 3 in [m]
l4 = 2;     % lunghezza del link 4 in [m]    
l5 = 0.8;   % lunghezza della massa da sollevare in [m]
l_c = 2;    % altezza camion in [m]

% componenti delle matrici d'inerzia
Iyy1 = (1/12) * m1 * l1^2;
Izz2 = (1/12) * m2 * l2^2;
I1_2_2 = Iyy1;
I1_1_2 = 0;
I1_3_2 = 0;
I2_1_1 = 0;
I2_1_2 = 0;
I2_1_3 = 0;
I2_2_1 = 0;
I2_2_3 = 0;
I2_3_1 = 0;
I2_2_2 = 0;
I2_3_2 = 0;
I2_3_3 = Izz2;
Izz3 = (1/12) * m3 * l3^2;
I3_1_1 = 0;
I3_1_2 = 0;
I3_1_3 = 0;
I3_2_1 = 0;
I3_2_3 = 0;
I3_3_1 = 0;
I3_2_2 = 0;
I3_3_2 = 0;
I3_3_3 = Izz3;
Izz4 = (1/12) * m4 * l4^2;
I4_1_1 = 0;
I4_1_2 = 0;
I4_1_3 = 0;
I4_2_1 = 0;
I4_2_3 = 0;
I4_3_1 = 0;
I4_2_2 = 0;
I4_3_2 = 0;
I4_3_3 = Izz4;
g = 9.81; % accelerazione di gravità in [m/s^2]

passi = 100;
ti = 26;   % tempo iniziale
tf = 31; % tempo finale
T = linspace(ti,tf,passi);

p5 = [6/((tf^2 - 2*tf*ti + ti^2)*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)),...
     -(15*(tf + ti))/((tf - ti)*(tf^4 - 4*tf^3*ti + 6*tf^2*ti^2 - 4*tf*ti^3 + ti^4)), ...
      (10*(tf^2 + 4*tf*ti + ti^2))/((tf^2 - 2*tf*ti + ti^2)*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)), ...
     -(30*ti*(tf^2 + ti*tf))/((tf - ti)^2*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)), ...
      (30*tf^2*ti^2)/((tf - ti)^3*(tf^2 - 2*tf*ti + ti^2)), ...
     -(10*tf^2*ti^3 - 5*tf*ti^4 + ti^5)/((tf - ti)^3*(tf^2 - 2*tf*ti + ti^2))];

a5 = polyval(p5,T); %valutazione del polinomio p5 in funzione del tempo T

a = a5;

q_c = 0;   % angolo d'inclinazione del telaio
q_cd = 0;  % velocità angolare del telaio
q_cdd = 0; % accelerazione angolare del telaio

%% INTERVALLO 8

% angoli iniziali
q1_i = pi;
q2_i = 0;
q3_i = -deg2rad(4);
q5_i = -pi/2;

% angoli finali
q1_f = 3*pi/2; 
q2_f = 0;
q3_f = -deg2rad(4);
q5_f = -pi/2;

% vettori angoli iniziali e finali
Qi = [q1_i q2_i q3_i q5_i q_c]';
Qf = [q1_f q2_f q3_f q5_f q_c]';

q = a.*(Qf-Qi)+Qi;
qd = [[0 0 0 0 0]' diff(q')'./diff(T)];
qdd = [[0 0 0 0 0]' diff(qd')'./diff(T)];

for cont=1:passi
    
    Tau = coppie(m2,m3,m4,m5,l1,l2,l3,l4,l5,l_c,g,q(1,cont),q(2,cont),q(3,cont),q(4,cont),qd(1,cont),qd(2,cont),qd(3,cont),qd(4,cont),qdd(1,cont),qdd(2,cont),qdd(3,cont),qdd(4,cont),I1_1_2,I1_2_2,I1_3_2,I2_1_1,I2_1_2,I2_1_3,I2_2_1,I2_2_3,I2_3_1,I2_2_2,I2_3_2,I2_3_3,I3_1_1,I3_1_2,I3_1_3,I3_2_1,I3_2_2,I3_2_3,I3_3_1,I3_3_2,I3_3_3,I4_1_1,I4_1_2,I4_1_3,I4_2_1,I4_2_2,I4_2_3,I4_3_1,I4_3_2,I4_3_3);

    Tau0 = Tau(1:3,1);
    Tau1 = Tau(1:3,2);
    Tau2 = Tau(1:3,3);
    Tau3 = Tau(1:3,4);
    Tau4 = Tau(1:3,5);
    Tau5 = Tau(1:3,6);

    F_vincolari = Forze(m1,m2,m3,m4,m5,m_c,l2,l3,l4,l5,g,q(1,cont),q(2,cont),q(3,cont),q(4,cont),qd(1,cont),qd(2,cont),qd(3,cont),qd(4,cont),qdd(1,cont),qdd(2,cont),qdd(3,cont),qdd(4,cont));

    f0c = F_vincolari(1:3,1);
    fc1 = F_vincolari(1:3,2);
    f12 = F_vincolari(1:3,3);
    f23 = F_vincolari(1:3,4);
    f34 = F_vincolari(1:3,5);
    f45 = F_vincolari(1:3,6);

end