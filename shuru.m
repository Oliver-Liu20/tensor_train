% 标签
% 飞机（ airlane ）1、汽车（ automobile ）2、鸟类（ bird ）3、猫（ cat ）4、鹿（ deer ）5、狗（dog ）6、蛙类（ frog ）7、马（ horse ）8、船（ ship ）9和卡车（ truck ）10
a1=3;
a2=8;
y=zeros(10000,1);
x=zeros(32,32,3,10000);    
num=1;
for j=1:5%读取训练集数据
    %读入第j个batch的数据
    load(['./cifar-10-batches-mat/data_batch_' num2str(j) '.mat'])
    for i=1:size(data,1)%循环转化并写入文件
        p=data(i,:);
        label=labels(i);
        
        if label==a1
            y(num)=1;
            fig=zeros(32,32,3);
            fig(:,:,1)=reshape(p(1:1024),32,32)';
            fig(:,:,2)=reshape(p(1025:2048),32,32)';
            fig(:,:,3)=reshape(p(2049:end),32,32)';
            x(:,:,:,num)=fig/255;
            num=num+1;
        elseif label==a2
            y(num)=-1;
            fig=zeros(32,32,3);
            fig(:,:,1)=reshape(p(1:1024),32,32)';
            fig(:,:,2)=reshape(p(1025:2048),32,32)';
            fig(:,:,3)=reshape(p(2049:end),32,32)';
            x(:,:,:,num)=fig/255;
            num=num+1;
        end
    end
end