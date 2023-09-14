w=rand(32,32,3);
b=0;
% a1=3;
% a2=8;
cor=test(w,0,3,8)

function cor=test(w,b,a1,a2)
% w为训练后的系数，b为训练后的常系数，a1,a2为选定的训练种类
% 飞机（ airlane ）1、汽车（ automobile ）2、鸟类（ bird ）3、猫（ cat ）4、鹿（ deer ）5、狗（dog ）6
% 、蛙类（ frog ）7、马（ horse ）8、船（ ship ）9和卡车（ truck ）10
    load(['./cifar-10-batches-mat/test_batch.mat'])
    yt=zeros(2100,1);
    xt=zeros(32,32,3,2100);  
    num=1;
    num_t=0;
    
    for i=1:size(data,1)%循环转化并写入文件
        p=data(i,:);
        label=labels(i);

        if label==a1||label==a2
            if label==a1
                yt(num)=1;
            else
                yt(num)=-1;
            end
            fig=zeros(32,32,3);
            fig(:,:,1)=reshape(p(1:1024),32,32)';
            fig(:,:,2)=reshape(p(1025:2048),32,32)';
            fig(:,:,3)=reshape(p(2049:end),32,32)';
            xt(:,:,:,num)=fig/255;
            tmp=yt(num)*(ttt(tensor(w),tensor(xt(:,:,:,num)),[1:3])+b);
            if tmp>=0 
                num_t=num_t+1;
            end
            num=num+1;
%         elseif label==a2
%             yt(num)=-1;
%             fig=zeros(32,32,3);
%             fig(:,:,1)=reshape(p(1:1024),32,32)';
%             fig(:,:,2)=reshape(p(1025:2048),32,32)';
%             fig(:,:,3)=reshape(p(2049:end),32,32)';
%             xt(:,:,:,num)=fig/255;
%             tmp=yt(num)*(ttt(tensor(w),tensor(xt(:,:,:,num)),[1:3])+b);
%             if tmp>0 
%                 num_t=num_t+1;
%             end
%             num=num+1;
        end
    end
    cor=num_t/num;
end