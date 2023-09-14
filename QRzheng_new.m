g1=rand(3,2);
g2=rand(2,5,4);
g3=rand(4,6);
G1=g1;G2=g2;G3=g3;

a1=size(g1);
a2=size(g2);
a3=size(g3);
% b1=size(a1);
% b2=size(a2);
% b3=size(a3);
n1=a1(1);n2=a2(2);n3=a3(2);r1=a1(2);r2=a2(3);

    
% g1核正交 w1=(g1*H1)'=>w1=H1'*reshape(G1,[n1*r1,1]),G3已完成正交化
[G3,R3]=qr(G3',0);
H2=reshape(G2,[r1*n2,r2])*R3'; 
G3=G3';
H2=reshape(H2,[r1,n2,r2]);
H2=reshape(H2,[r1,n2*r2]);
[Q2,R2]=qr(H2',0);
G1=G1*R2';
Q2=Q2'; %转置还原
G2=reshape(Q2,[r1,n2,r2]);
H1=Q2*kron(G3,eye(n2));
H1=kron(H1,eye(n1));
w1=H1'*reshape(G1,[n1*r1,1]);


% g2核正交 ,因G3未变，遂直接使用上面正交结果，w2=H2*reshape(G2,[r1*n2*r2,1])
[Q1,R1]=qr(G1,0);
G2=R1*reshape(G2,[r1,n2*r2]);
G1=Q1;
H2=kron(eye(n2),G1);
H2=kron(G3',H2); 
G2=reshape(G2,[r1,n2,r2]);
w2=H2*reshape(G2,[r1*n2*r2,1]);

% g3核正交 ，因G1核未变，遂使用上面正交结果w3=H3*reshape(G3,[n3*r2,1])
[Q2,R2]=qr(reshape(G2,[r1*n2,r2]),0);
G3=R2*G3;
G2=reshape(Q2,[r1,n2,r2]);
T3=kron(eye(n2),G1)*Q2;
H3=kron(eye(n3),T3);
w3=H3*reshape(G3,[n3*r2,1]);




