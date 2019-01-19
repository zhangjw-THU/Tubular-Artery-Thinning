function [Line,LineEnd,EndPoint] = PeriodCp(img_thin)
% 改进的追踪算法
% img_no_Y：把细化后的图去除掉所有的分叉点
% 因此，它只有线点和端点
% Line:左右的线段
% LineEnd：每一个线段的端点。
% EndPoint：所有的端点
Bp = bwmorph3(img_thin,'branchpoints');
img_no_Y = img_thin - Bp;
img_no_Y = (img_no_Y>0);
[sx,sy,sz] = size(img_no_Y);
tmp_imgnoY = zeros(sx+2,sy+2,sz+2);
tmp_imgnoY(2:sx+1,2:sy+1,2:sz+1) = img_no_Y;
img_no_Y = tmp_imgnoY;

img_thin_tmp = img_no_Y;
mask = img_no_Y.*0;
num = sum(img_no_Y(:));%所有端点和线点的数
% [Bp,Ep,Lp] = BifucationAndEndPoint(img_no_Y);
Ep = bwmorph3(img_no_Y,'endpoints');
[point(:,1), point(:,2), point(:,3)] = ind2sub(size(Ep), find(Ep));

numEp = sum(Ep(:));%端点数，一定是偶数
numL = numEp/2; %线段数
Line = cell(numL,1);%每一个线段存入一个cell
LineEnd = cell(numL,1);
EndPoint = zeros(numEp,3);

for i = 1:numL
    for j = 1:numEp
        if(point(j,1)~=0)
            Start = point(j,:);%一个线段的开始
            break;
        end
    end
    
    Pin = Start;
    Line{i}(1,:) = Pin-1;
    mask(Pin(1),Pin(2),Pin(3))=1;
    
    tmp1 = img_no_Y(Pin(1)-1:Pin(1)+1 ,Pin(2)-1:Pin(2)+1 ,Pin(3)-1:Pin(3)+1);
    [xx,yy,zz] = ind2sub(size(tmp1), find(tmp1));
    
    mvxx = sum(xx(:))-2;
    mvyy = sum(yy(:))-2;
    mvzz = sum(zz(:))-2;
    
    Pin(1) = mvxx+Pin(1)-2;
    Pin(2) = mvyy+Pin(2)-2;
    Pin(3) = mvzz+Pin(3)-2;
    
    k=1;
    while(1)
        k = k+1;
        Line{i}(k,:) = Pin-1;
        mask(Pin(1),Pin(2),Pin(3))=1;
        tmp1 = img_no_Y(Pin(1)-1:Pin(1)+1 ,Pin(2)-1:Pin(2)+1 ,Pin(3)-1:Pin(3)+1);
        [xx,yy,zz] = ind2sub(size(tmp1), find(tmp1));
        L = length(xx);
        for j = 1:L
            mx = xx(j)+Pin(1)-2;
            my = yy(j)+Pin(2)-2;
            mz = zz(j)+Pin(3)-2;
            if(mask(mx,my,mz)==0)
                Pin = [mx,my,mz];
                break;
            end
        end
        if(L==2)
            img_thin_tmp = img_thin_tmp.*(1-mask);
            Ep = bwmorph3(img_thin_tmp,'endpoints');
            sum(Ep(:))
            clear point;
            [point(:,1), point(:,2), point(:,3)] = ind2sub(size(Ep), find(Ep));
            break;
        end  
    end
    LineEnd{i}(1,:) =Start-1;
    LineEnd{i}(2,:) = Pin-1;
    EndPoint(2*i-1,:) = Start-1;
    EndPoint(2*i,:) = Pin-1;
end
end