function img_thin_dlt = FinalDelete(img_bin)
% 最后删除没有连接起来的短线

[Line,LineEnd,EndPoint] = PeriodCp(img_bin);
[sx,sy,sz] = size(img_bin);
tmp_img = zeros(sx+2,sy+2,sz+2);
tmp_img(2:sx+1,2:sy+1,2:sz+1) = img_bin;
img_thin_dlt = tmp_img;

L = length(Line);
for i=1:L
    dt1 = LineEnd{i}(1,:);
    dt2 = LineEnd{i}(2,:);
    tmp1 = img_bin(dt1(1)-1:dt1(1)+1, dt1(2)-1:dt1(2)+1,dt1(3)-1:dt1(3)+1);
    tmp2 = img_bin(dt2(1)-1:dt2(1)+1, dt2(2)-1:dt2(2)+1,dt2(3)-1:dt2(3)+1);
    if(sum(tmp1(:))>2 || sum(tmp2(:))>2)
        continue;
    end
    [num,k] = size(Line{i});
    if(num>25)
        continue;
    end
    if(sum(tmp1(:))==2&&sum(tmp2(:))==2)
        for j = 1:num
            img_thin_dlt(Line{i}(j,1)+1,Line{i}(j,2)+1,Line{i}(j,3)+1)=0;
        end
    end
end
img_thin_dlt = img_thin_dlt(2:sx+1,2:sy+1,2:sz+1);
end