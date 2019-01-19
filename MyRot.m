function Kout = MyRot(Kin,Dirin)
% Ğı×ªº¯Êı
% ÑØ²»Í¬µÄÖáË³Ê±ÕëĞı×ª90¡ã
% U/D£ºÑØZÖá
% W/E£ºÑØYÖá
% N/S£ºÑØXÖá

if(Dirin=='U'||Dirin=='D')
    Kout = rot90(Kin);
elseif(Dirin=='W'||Dirin=='E')
    Kout(1,1,1) = Kin(1,1,3);
    Kout(2,1,1) = Kin(1,1,2);
    Kout(3,1,1) = Kin(1,1,1);
    Kout(1,2,1) = Kin(1,2,3);
    Kout(2,2,1) = Kin(1,2,2);
    Kout(3,2,1) = Kin(1,2,1);
    Kout(1,3,1) = Kin(1,3,3);
    Kout(2,3,1) = Kin(1,3,2);
    Kout(3,3,1) = Kin(1,3,1);
    
    Kout(1,1,2) = Kin(2,1,3);
    Kout(2,1,2) = Kin(2,1,2);
    Kout(3,1,2) = Kin(2,1,1);
    Kout(1,2,2) = Kin(2,2,3);
    Kout(2,2,2) = Kin(2,2,2);
    Kout(3,2,2) = Kin(2,2,1);
    Kout(1,3,2) = Kin(2,3,3);
    Kout(2,3,2) = Kin(2,3,2);
    Kout(3,3,2) = Kin(2,3,1);
    
    Kout(1,1,3) = Kin(3,1,3);
    Kout(2,1,3) = Kin(3,1,2);
    Kout(3,1,3) = Kin(3,1,1);
    Kout(1,2,3) = Kin(3,2,3);
    Kout(2,2,3) = Kin(3,2,2);
    Kout(3,2,3) = Kin(3,2,1);
    Kout(1,3,3) = Kin(3,3,3);
    Kout(2,3,3) = Kin(3,3,2);
    Kout(3,3,3) = Kin(3,3,1);
else
    Kout(1,1,1) = Kin(1,3,1);
    Kout(2,1,1) = Kin(2,3,1);
    Kout(3,1,1) = Kin(3,3,1);
    Kout(1,2,1) = Kin(1,3,2);
    Kout(2,2,1) = Kin(2,3,2);
    Kout(3,2,1) = Kin(3,3,2);
    Kout(1,3,1) = Kin(1,3,3);
    Kout(2,3,1) = Kin(2,3,3);
    Kout(3,3,1) = Kin(3,3,3);
    
    Kout(1,1,2) = Kin(1,2,1);
    Kout(2,1,2) = Kin(2,2,1);
    Kout(3,1,2) = Kin(3,2,1);
    Kout(1,2,2) = Kin(1,2,2);
    Kout(2,2,2) = Kin(2,2,2);
    Kout(3,2,2) = Kin(3,2,2);
    Kout(1,3,2) = Kin(1,2,3);
    Kout(2,3,2) = Kin(2,2,3);
    Kout(3,3,2) = Kin(3,2,3);
    
    Kout(1,1,3) = Kin(1,1,1);
    Kout(2,1,3) = Kin(2,1,1);
    Kout(3,1,3) = Kin(3,1,1);
    Kout(1,2,3) = Kin(1,1,2);
    Kout(2,2,3) = Kin(2,1,2);
    Kout(3,2,3) = Kin(3,1,2);
    Kout(1,3,3) = Kin(1,1,3);
    Kout(2,3,3) = Kin(2,1,3);
    Kout(3,3,3) = Kin(3,1,3);

end
end