function g = FillHole(f)
% ��ն�
marker = ~f;
marker(2:end-1,2:end-1) = 0;
g = imreconstruct(marker, ~f);
g = ~g;
end
