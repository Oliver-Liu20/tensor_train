%定义参数
% r1,r2为TT分解的秩约束
% delta为增广项罚参数
% r1=
% r2=
% delta=
% g1=tensor(rand(3,2));
% g2=tensor(rand(2,5,4));
% g3=tensor(rand(4,6));
[Hx,Gx]=QRzheng(g2,g1,g3)

function [Hx,Gx]=QRzheng(G1,G2,G3)
    %a为核的各维度信息，b为核的维数
    a1=size(G1);
    a2=size(G2);
    a3=size(G3);
    b1=size(a1);
    b2=size(a2);
    b3=size(a3);
    if b1(2)==2
        if b2(2)==2 %g3,g1,g2
            r1=a2(2); r2=a3(3);n1=a2(1);n2=a3(2);n3=a1(2);
            G11=ttm(G3,G2.data,1);
            H1=reshape(G11.data,[n1*n2,r2]);
            L1=eye(n3);
            H2=kron(L1,H1);
            [H3,R]=qr(H2,0);
            Hx=tensor(H3);
            Gx=R*double(reshape(G1,[r2*n3,1]));
            Gx=tensor(Gx);
        elseif b2(2)==3 %g1,g2,g3
            r1=a2(1); r2=a2(3);n1=a1(1);n2=a2(2);n3=a3(2);
            G11=ttm(G2,G3.data',3);
            H1=reshape(G11.data,[n2*n3,r1]);
            L1=eye(n1);
            H2=kron(L1,H1);
            [H3,R]=qr(H2,0);
            Hx=tensor(H3);
            Gx=R*double(reshape(G1,[r1*n1,1]));
            Gx=tensor(Gx);
        end
    elseif b1(2)==3%g2,g1,g3
        r1=a1(1); r2=a1(3);n1=a2(1);n2=a1(2);n3=a3(2);
        [q3,R3]=qr(G3.data',0);
        q3=q3';
        R3=R3';
        %ttm好像只能计算左乘矩阵(张量乘矩阵)，右乘矩阵需要先转置为左乘再计
        %算....这里张量的转置等于它本身，相当于没用
        g1=ttm(G1',R3,3)';
        [q2,R2]=qr(G2.data,0);
        g1=ttm(g1,R2,1);
        L=eye(n2);
        H1=kron(L,q2);
        H2=kron(q3',H1); 
        G11=reshape(g1,[r1*n2*r2,1]);
        [H3,R]=qr(H2,0);
        Hx=tensor(H3);
        Gx=R*double(G11);
        Gx=tensor(Gx);
    end
end
        




