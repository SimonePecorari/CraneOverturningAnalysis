function J = J3R1P(q,l2,l3,l4) % funzione del Jacobiano associata al meccanismo

q1 = q(1);
q2 = q(2);
q3 = q(3);



J = [-sin(q1)*(l3*cos(q2 + q3) + l4*cos(q2 + q3) + l2*cos(q2)), -cos(q1)*(l3*sin(q2 + q3) + l4*sin(q2 + q3) + l2*sin(q2)), -cos(q1)*(l3*sin(q2 + q3) + l4*sin(q2 + q3));
                                                             0,            l3*cos(q2 + q3) + l4*cos(q2 + q3) + l2*cos(q2),            l3*cos(q2 + q3) + l4*cos(q2 + q3);
     -cos(q1)*(l3*cos(q2 + q3) + l4*cos(q2 + q3) + l2*cos(q2)),  sin(q1)*(l3*sin(q2 + q3) + l4*sin(q2 + q3) + l2*sin(q2)),  sin(q1)*(l3*sin(q2 + q3) + l4*sin(q2 + q3))];

end