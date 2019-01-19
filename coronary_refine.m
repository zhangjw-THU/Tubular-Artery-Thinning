function [] = coronary_refine( rpath )
% This function processes each probability map of coronary arteries under
% 'rpath'. The processing steps include but not limited to thresholding,
% filling holes, thinning, detecting bifurcation or end points,
% reconnecting disconnected branches, removing isolated branches, and
% obtains a coronary artery tree finally.
% （该函数处理“rpath”下冠状动脉的每个概率图。处理步骤包括但不限于阈值化、填充孔、细化、分叉或端点检测、重新连接断开的分支、移除孤立的分支，最终得到冠状动脉树。）
% Examples:
%   coronary_refine('path_of_parent_directory_containg_volumes')

% create output directory：创建生成文件的存储目录
wpath = fullfile(rpath, 'coronary');
if ~exist(wpath, 'dir'), mkdir(wpath); end

% processing each volume under rpath
img_list = dir(fullfile(rpath, '*.mha'));
for ii = 1:length(img_list)
    
    %% read mha volume
    img_path = fullfile(rpath, img_list(ii).name);%获得文件名
    [img_prop, img_info] = mha_read_volume(img_path);
    
    %% thresholdingCoro:二值化
    img_bin = img_prop >= (0.5*intmax('uint16'));
    % check the binary image obtained by considering it as a volume data,
    % and you can also store the binary volume into a single file (.mha file)
%     volumeViewer(img_bin); %显示
%     w_info = img_info; % header information of volume to be written
%     w_info.DataType = 'uchar'; % change the data type to uchar (uint8)
%     mha_write(img_bin, w_info, 'path');
    
    %% filling holes：填补
    % your code here ...
    [xs, ys, zs] = size(img_bin);
    for i=1:xs
        img_bin(i,:,:) = FillHole(squeeze(img_bin(i,:,:)));
    end
    for i=1:ys
        img_bin(:,i,:) = FillHole(squeeze(img_bin(:,i,:)));
    end
    for i=1:zs
        img_bin(:,:,i) = FillHole(squeeze(img_bin(:,:,i)));
    end
    
    %% thinning：细化
    % your code here ...
    %
    % plot the centerline of coronary artery by considering it as a set of
    % points, e.g. denote 'img_thin' as the result of thinning step
    Bw_thin = bwskel(img_bin);%自己设计的细化函数提取
    %Bw_thin = Thining(img_bin);
    %Bw_thin = img_thin_066;%提取好的数据，要用这个，先的提取好
    figure(1)
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(Bw_thin), find(Bw_thin));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    
    %% detecting bifucation and end points:检测分岔和端点
    % your code here ...
    % 函数：BifucationAndEndPoint.m,下面的函数简介调用了，此处无需执行
    % Bp:线上的点；Ep:端点；Lp:线上的点
    [Bp,Ep,Lp] = BifucationAndEndPoint(Bw_thin);
    %% reconnecting disconnected branches & removing isolate points or branches
    %重新连接断开的分支&移除孤立的点或分支
    % your code here ...
    % 函数：DeleteBurr:删除一些短线
    img_thin_dlt = DeleteBurr(Bw_thin);
    
    figure(2),
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(img_thin_dlt), find(img_thin_dlt));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    
    %函数：WipeBurr.m:删除一些毛刺和一些孤立的点
    img_thin_burr = WipeBurr(img_thin_dlt);
    
    figure(3),
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(img_thin_burr), find(img_thin_burr));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    
    %函数：Connection.m:对去除毛刺后的图进行连接，连接一些较短的断线
    
    img_thin_cnt = ConnectionPL(img_thin_burr);
    
    figure(4)
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(img_thin_cnt), find(img_thin_cnt));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    
    %函数：FinalDelete.m：一些较长的线，之前没有删除，但是其距离主干线较远，不能连接起来，现在删除。
    img_thin_dlt_final = FinalDelete(img_thin_cnt);
    %img_thin_dlt_final = img_thin_cnt;
    figure(5)
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(img_thin_dlt_final), find(img_thin_dlt_final));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    %% obtain coronary artery tree (by tracking or other methods)
    %获取冠状动脉树(通过跟踪或其他方法)
    % your code here ...
    %
    % plot the complete coronary artery tree in different color according
    % to the ids of branches, e.g. denote 'coro_tree', a cell array, as the
    % coronary artery tree obtained, and each element is a coordinate array
    % of a single branch
    %根据分支的id，用不同的颜色绘制完整的冠状动脉树，例如，得到的冠状动脉树为细胞阵列“coro_tree”，每个元素为单个分支的坐标阵列
    
    % 函数PeriodCp.m：获得树
    %其中：Line:线段；LineEnd:线段读点；EndPoint:所有端点
    [Line,LineEnd,EndPoint] = PeriodCp(img_thin_dlt_final);
    
    coronary_show(Line)
    %下面是将所有端点和分叉点也显示在最终的图上，以红点的形式
    [Bp,Ep,Lp] = BifucationAndEndPoint(img_thin_dlt_final);
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(Bp), find(Bp));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(Ep), find(Ep));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
   % coronary_show(coro_tree);
    
    %% save the tree obtained into a mat file (.mat)
%     coro_tree{1} = rand(10, 3); % for example, branch 1
%     coro_tree{2} = rand(12, 3); % for example, branch 2 ...
    tree_name = split(img_list(ii).name, '.');
    tree_name = [tree_name{1}, '.mat'];
    tree_path = fullfile(wpath, tree_name);
    save(tree_path, 'Line');
end

end
