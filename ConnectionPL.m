function img_thin_cntPL = ConnectionPL(img_bin)%,Line,EndPoint,LineEnd)
% 连接:点——线
% img_thin：细化后的图
% Line：分段后的线段（cell)
% EndPoint：所有的端点：包括把交叉点去掉的三个线段
% LineEnd：每一个线段的端点

%所有费零点找出来
[point(:,1), point(:,2), point(:,3)] = ind2sub(size(img_bin), find(img_bin));
Labelmask = bwlabeln(img_bin,26);
numP = sum(img_bin(:));
[Line,LineEnd,EndPoint] = PeriodCp(img_bin);
img_thin_cntPL = img_bin;

L = length(LineEnd);


for i = 1:L
    Judge=1;
    minDis = 100000;
    JudgeJ = 1;
    
    EndP1 = LineEnd{i}(1,:);
    EndP2 = LineEnd{i}(2,:);
    
    tmp1 = img_thin_cntPL(EndP1(1)-1:EndP1(1)+1, EndP1(2)-1:EndP1(2)+1, EndP1(3)-1:EndP1(3)+1);
    tmp2 = img_thin_cntPL(EndP2(1)-1:EndP2(1)+1, EndP2(2)-1:EndP2(2)+1, EndP2(3)-1:EndP2(3)+1);
    
    if((sum(tmp1(:))>2)&&(sum(tmp2(:))>2))
        continue;
    end
    
    for j=1:numP
        
        if(Labelmask(point(j,1),point(j,2),point(j,3))==Labelmask(EndP1(1),EndP1(2),EndP1(3)))
            continue;
        end
        D1 = Dis(EndP1,point(j,:));
        if(D1==0)
            continue;
        end
        D2 = Dis(EndP2,point(j,:));
        if(D2==0)
            continue
        end
        minDis = min(min(D1,D2),minDis);
        if(minDis == D1)
            Judge = 1;
            JudgeJ = j;
        end
        if(minDis == D2)
            Judge = 2;
            JudgeJ = j;
        end
    end
    if(Judge == 1)
        LCnt1 = EndP1;
        LCnt2 = point(JudgeJ,:);
    end
    if(Judge == 2)
        LCnt1 = EndP2;
        LCnt2 = point(JudgeJ,:);
    end
    Dx = abs(LCnt1(1) - LCnt2(1));
    Dy = abs(LCnt1(2) - LCnt2(2));
    Dz = abs(LCnt1(3) - LCnt2(3));
    Dmax = max(max(Dx,Dy),Dz);%三个维度的最大值
    if(Dmax>20)
        continue;
    end
    for k = 0:Dmax
        slop = double(k)/Dmax;
        x = round(LCnt1(1) + slop*(LCnt2(1)-LCnt1(1)));
        y = round(LCnt1(2) + slop*(LCnt2(2)-LCnt1(2)));
        z = round(LCnt1(3) + slop*(LCnt2(3)-LCnt2(3)));
        img_thin_cntPL(x,y,z) = 1;
    end
end
end

% %% 函数

function D = Dis(P1,P2)

dx = abs(P1(1) - P2(1));
dy = abs(P1(2) - P2(2));
dz = abs(P1(3) - P2(3));
%D = dx+dy+dz;

D = sqrt(dx*dx + dy*dy + dz*dz);
end