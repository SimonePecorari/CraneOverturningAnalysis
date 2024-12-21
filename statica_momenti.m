clear
clc
close all

% PARAMETRI INERZIALI  E GEOMETRICI DEL SISTEMA
syms m1 m2 m3 m4 real % massa delle aste in [kg]
syms m5 real % massa da sollevare in [kg]
syms m_c real % massa del camion in [kg]

syms q2 q3 real % angoli di inclinazione delle aste 2 e 3 in [rad]
syms I1_ [3 3] real % matrice inerzia 3x3 
syms I2_ [3 3] real
syms I3_ [3 3] real
syms I4_ [3 3] real

syms l1 l2 l3 l4 real % lunghezze delle aste in [m]
syms l5 real % lunghezza del corpo da sollevare, che è stato trattato come asta


% DATI CAMION
syms d_ruota_c real % distanza tra baricentro del camion e centro della ruota in [m]
syms m_oper real % massa dell'operatore in [kg]
% d_ruota_c = 0.975;

syms g real % accelerazione di gravità in [m/s^2]


% FORMULA EQUILIBRIO MOMENTI

eq_M = m_oper*g*(d_ruota_c/2) + m_c*d_ruota_c*g + m1*g*d_ruota_c - m2*g*(l2/2*cos(q2)-d_ruota_c) - m3*g*(l2*cos(q2)+l3/2*cos(q3)-d_ruota_c) - m4*g*(l2*cos(q2)+l3*cos(q3)+l4/2*cos(q3)-d_ruota_c) - m*g*(l2*cos(q2)+l3*cos(q3)+l4*cos(q3)-d_ruota_c);

% sol = solve(eq_M,m5);
% m5 = simplify(sol);

