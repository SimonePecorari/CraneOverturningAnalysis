
function p = DK3R1P(q,l1,l2,l3,l4)                                          %funzione della cinematica diretta associata al meccanismo

                                                                            % componenti del vettore 'q'
q1 = q(1);
q2 = q(2);
q3 = q(3);

                                                                            % coordinate del punto 'P'
xP = cos(q1)*(l3*cos(q2 + q3) + l4*cos(q2 + q3) + l2*cos(q2));
yP = l1 + l3*sin(q2 + q3) + l4*sin(q2 + q3) + l2*sin(q2);
zP = -sin(q1)*(l3*cos(q2 + q3) + l4*cos(q2 + q3) + l2*cos(q2));

p = [xP yP zP]';

end



