function [B1,B2,num] = MyHitMisKn(M,DirS)
% 在细化函数中调用，获得“击中与否”的两个核
num = sum(sum(sum((M==2))))*4;
if(num==64)
    num = 16;
    B1 = cell(num,1);
    B2 = cell(num,1);
    
    mask0 = (M==0);
    mask1 = (M==1);
    mask2 = (M==2);
    mask3 = (M==-1);
    find2 = find(mask2);
    for i=1:num
        B1{i} = mask1;
        B1{i}(find2(ceil(i)))=1;
        
        B2{i} = mask0;
        B2{i}(find2(ceil(i)))=0;

    end
elseif(num~=0)
    B1 = cell(num,1);
    B2 = cell(num,1);
    
    mask0 = (M==0);
    mask1 = (M==1);
    mask2 = (M==2);
    mask3 = (M==-1);
    find2 = find(mask2);
    
    for i=1:4:num
        B1{i} = mask1;
        %B1{i}(find2(ceil(i)))=1;
        B1{i}(find2(ceil(i/4)))=1;
        
        B2{i} = mask0;
        %B2{i}(find2(ceil(i)))=0;
        B2{i}(find2(ceil(i/4)))=0;
        
        B1{i+1} = MyRot(B1{i},DirS);
        B2{i+1} = MyRot(B2{i},DirS);
        
        B1{i+2} = MyRot(B1{i+1},DirS);
        B2{i+2} = MyRot(B2{i+1},DirS);
        
        B1{i+3} = MyRot(B1{i+2},DirS);
        B2{i+3} = MyRot(B2{i+2},DirS);
    end
else
    B1 = cell(4,1);
    B2 = cell(4,1);
    num=4;
    mask0 = (M==0);
    mask1 = (M==1);
    mask2 = (M==2);
    mask3 = (M==-1);
    B1{1} = mask1;
    B2{1} = mask0;
    
    B1{2} = MyRot(B1{1},DirS);
    B2{2} = MyRot(B2{1},DirS);
    
    B1{3} = MyRot(B1{2},DirS);
    B2{3} = MyRot(B2{2},DirS);
    
    B1{4} = MyRot(B1{3},DirS);
    B2{4} = MyRot(B2{3},DirS);
end
end

function Kout = MyRot90(Kin,Dirin)
if(Dirin=='U'||Dirin=='D')
    Kout = rot90(Kin);
elseif(Dirin=='W'||Dirin=='E')
    Kout(:,:,1) = Kin(:,1,:);
    Kout(:,:,2) = Kin(:,2,:);
    Kout(:,:,3) = Kin(:,3,:);
else
    Kout(:,:,1) = Kin(1,:,:);
    Kout(:,:,2) = Kin(2,:,:);
    Kout(:,:,3) = Kin(3,:,:);
end
end