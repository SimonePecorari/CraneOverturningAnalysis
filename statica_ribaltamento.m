clear
clc
close all

m1 = 100;    % massa del link 1 in [kg]
m2 = 80;     % massa del link 2 in [kg]
m3 = 80;     % massa del link 3 in [kg]
m4 = 40;     % massa del link 4 in [kg]
m_c = 7500;  % massa del camion in [kg]
m_oper = 80; % massa dell'operatore in [kg]

l1 = 2;  % lunghezza dell'asta 1 in [m]
l2 = 3;  % lunghezza dell'asta 2 in [m]
l3 = 3;  % lunghezza dell'asta 3 in [m]
l4 = 2;  % lunghezza dell'asta 4 in [m]

d_ruota_c = 0.975; % distanza tra baricentro del camion in [m] e centro della ruota nel piano xy 
d_cm_r = 2.35; % distanza tra baricentro del camion in [m] e centro della ruota posteriore nel piano yz
d_op_r = d_cm_r + 1.775; % distanza tra operatore in [m] e centro ruota posteriore nel piano yz
                         % 1.775 = 2.75-0.975        
                                 % 2.75 = distanza tra baricentro e inizio del camion

d_cm_ra = 1.15; % distanza in [m] tra baricentro  e centro ruota anteriore nel piano yz 
d_op_ra = 0.625; % distanza in [m] tra operatore  e centro ruota anteriore nel piano yz

q2 = 0; % angolo di inclinazione dell'asta 2 in [rad]
q3 = -deg2rad(4); % angolo di inclinazione dell'asta 3 in [rad]

g = 9.81; % accelerazione di gravità in [m/s^2]

%% PRIMA CONFIGURAZIONE q1=0

m=0; % massa del peso da sollevare inizializzata in [kg]
while m < 4000

    M = m_oper*g*(d_ruota_c/2) + m_c*d_ruota_c*g + m1*g*d_ruota_c - m2*g*(l2/2*cos(q2)-d_ruota_c) - m3*g*(l2*cos(q2)+l3/2*cos(q3)-d_ruota_c) - m4*g*(l2*cos(q2)+l3*cos(q3)+l4/2*cos(q3)-d_ruota_c) - m*g*(l2*cos(q2)+l3*cos(q3)+l4*cos(q3)-d_ruota_c);

    if M<0
        disp(M)
        disp('il camion si ribalta')
        break
    end
    m = m + 10;
end

%% SECONDA CONFIGURAZIONE q1=pi

m=0; % massa del peso da sollevare inizializzata in [kg]
while m < 4000

    M = m_oper*g*(d_ruota_c+d_ruota_c/2) + m_c*d_ruota_c*g + m1*g*d_ruota_c - m2*g*(l2/2*cos(q2)-d_ruota_c) - m3*g*(l2*cos(q2)+l3/2*cos(q3)-d_ruota_c) - m4*g*(l2*cos(q2)+l3*cos(q3)+l4/2*cos(q3)-d_ruota_c) - m*g*(l2*cos(q2)+l3*cos(q3)+l4*cos(q3)-d_ruota_c);

    if M<0
        disp(M)
        disp('il camion si ribalta')
        break
    end
    m = m + 10;
end

%% TERZA CONFIGURAZIONE q1=pi/2

m=0; % massa del peso da sollevare inizializzata in [kg]
while m < 4000

    M = m_oper*g*(d_op_r) + m_c*g*d_cm_r + m1*g*d_cm_r + m2*g*(d_cm_r-l2/2*cos(q2)) - m3*g*(l2*cos(q2)+l3/2*cos(q3)-d_cm_r) - m4*g*(l2*cos(q2)+l3*cos(q3)+l4/2*cos(q3)-d_cm_r) - m*g*(l2*cos(q2)+l3*cos(q3)+l4*cos(q3)-d_cm_r);

    if M<0
        disp(M)
        disp('il camion si ribalta')
        break
    end
    m = m + 10;
end

%% QUARTA CONFIGURAZIONE q1=3/2pi

m=0; % massa del peso da sollevare inizializzata in [kg]
while m < 4000

    M = -m_oper*g*(d_op_ra) + m_c*g*d_cm_ra + m1*g*d_cm_ra + m2*g*(d_cm_ra-l2/2*cos(q2)) + m3*g*(d_cm_ra-l2*cos(q2)-l3/2*cos(q3)) + m4*g*(d_cm_ra-l2*cos(q2)-l3*cos(q3)-l4/2*cos(q3)) + m*g*(d_cm_ra-l2*cos(q2)-l3*cos(q3)-l4*cos(q3));

    if M<0
        disp(M)
        disp('il camion si ribalta')
        break
    end
    m = m + 10;
end

