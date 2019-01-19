function [Bp,Ep,Lp] = BifucationAndEndPoint(img_thin)
% 检测细化后的图像的分叉点、端点、线点
% Bp:detecting bifucation
% Ep:end point
% Lp: Line point
% Bp/EP和内置函数的结果一样

[sx,sy,sz] = size(img_thin);
tmp_img = zeros(sx+2,sy+2,sz+2);
tmp_img(2:sx+1,2:sy+1,2:sz+1) = img_thin;
img_thin = tmp_img;
img_thin = (img_thin>0);

Ep = img_thin.*0;
Bp = img_thin.*0;
Lp = img_thin.*0;
num = sum(img_thin(:));
[point(:,1), point(:,2), point(:,3)] = ind2sub(size(img_thin), find(img_thin));

for p=1:num
    i = point(p,1);
    j = point(p,2);
    k = point(p,3);
    tmp = img_thin(i-1:i+1,j-1:j+1,k-1:k+1);
    Ep(i,j,k) = (img_thin(i,j,k)==1)&&(sum(tmp(:))==2);
    Lp(i,j,k) = (img_thin(i,j,k)==1)&&(sum(tmp(:))==3);
    Bp(i,j,k) = (img_thin(i,j,k)==1)&&(sum(tmp(:))>=4);
end
Bp = (Bp>0);
Ep = (Ep>0);
Lp = (Lp>0);
Bp = Bp(2:sz+1,2:sy+1,2:sz+1);
Ep = Ep(2:sz+1,2:sy+1,2:sz+1);
Lp = Lp(2:sz+1,2:sy+1,2:sz+1);
end



