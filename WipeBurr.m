function img_thin_burr = WipeBurr(img_thino)

% 对细化后的结果进行修正/去除毛刺
% 方法：循环删除端点
img_thin = img_thino;
img_thin = (img_thin>0);
num = sum(img_thin(:));
[sx,sy,sz] = size(img_thin);
tmp = zeros(sx+2,sy+2,sz+2);
tmp(2:sx+1, 2:sy+1, 2:sz+1) = img_thin;
img_thin = tmp;

[point(:,1), point(:,2), point(:,3)] = ind2sub(size(img_thin), find(img_thin));

img_thin_burr = (img_thin>0);
while(1)
    img_thin = img_thin_burr;
    s1 = sum(img_thin(:));
    for i = 1:num
        tmp1 = img_thin(point(i,1)-1:point(i,1)+1,point(i,2)-1:point(i,2)+1,point(i,3)-1:point(i,3)+1);
        if(sum(tmp1(:))==1)
            img_thin_burr(point(i,1),point(i,2),point(i,3)) = 0;
        end
        if(sum(tmp1(:))==2)
            tmp2 = img_thin(point(i,1)-2:point(i,1)+2,point(i,2)-2:point(i,2)+2,point(i,3)-2:point(i,3)+2);
            if(sum(tmp2(:))>3)
                    img_thin_burr(point(i,1),point(i,2),point(i,3)) = 0;
            end
        end
    end
    if(s1 == sum(img_thin_burr(:)))
        break;
    end
end
img_thin_burr = img_thin_burr(2:sx+1, 2:sy+1, 2:sz+1);
end