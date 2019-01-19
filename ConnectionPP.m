function img_thin_cnt = ConnectionPP(img_bin)%,Line,EndPoint,LineEnd)
% 连接：点——点
% img_thin：细化后的图
% Line：分段后的线段（cell)
% EndPoint：所有的端点：包括把交叉点去掉的三个线段
% LineEnd：每一个线段的端点

[Line,LineEnd,EndPoint] = PeriodCp(img_bin);
img_thin_cnt = img_bin;

L = length(LineEnd);


for i = 1:L
    Judge=1;
    minDis = 100000;
    JudgeJ = 1;
    
    EndP1 = LineEnd{i}(1,:);
    EndP2 = LineEnd{i}(2,:);
    
    tmp1 = img_thin_cnt(EndP1(1)-1:EndP1(1)+1, EndP1(2)-1:EndP1(2)+1, EndP1(3)-1:EndP1(3)+1);
    tmp2 = img_thin_cnt(EndP2(1)-1:EndP2(1)+1, EndP2(2)-1:EndP2(2)+1, EndP2(3)-1:EndP2(3)+1);
    
    if((sum(tmp1(:))>2)||(sum(tmp2(:))>2))
        continue;
    end
    
    for j=1:2*L
        D1 = Dis(EndP1,EndPoint(j,:));
        if(D1==0)
            continue;
        end
        D2 = Dis(EndP2,EndPoint(j,:));
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
        LCnt2 = EndPoint(JudgeJ,:);
    end
    if(Judge == 2)
        LCnt1 = EndP2;
        LCnt2 = EndPoint(JudgeJ,:);
    end
    Dx = abs(LCnt1(1) - LCnt2(1));
    Dy = abs(LCnt1(2) - LCnt2(2));
    Dz = abs(LCnt1(3) - LCnt2(3));
    Dmax = max(max(Dx,Dy),Dz);%三个维度的最大值
    if(Dmax>45)
        continue;
    end
    for k = 1:Dmax
        slop = double(k)/Dmax;
        x = round(LCnt1(1) + slop*(LCnt2(1)-LCnt1(1)));
        y = round(LCnt1(2) + slop*(LCnt2(2)-LCnt1(2)));
        z = round(LCnt1(3) + slop*(LCnt2(3)-LCnt2(3)));
        img_thin_cnt(x,y,z) = 1;
    end
end
end

% %% 函数

function D = Dis(P1,P2)
dx = abs(P1(1) - P2(1));
dy = abs(P1(2) - P2(2));
dz = abs(P1(3) - P2(3));

D = dx+dy+dz;
%D = sqrt(dx*dx + dy*dy + dz*dz);
end