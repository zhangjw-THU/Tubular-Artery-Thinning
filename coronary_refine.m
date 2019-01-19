function [] = coronary_refine( rpath )
% This function processes each probability map of coronary arteries under
% 'rpath'. The processing steps include but not limited to thresholding,
% filling holes, thinning, detecting bifurcation or end points,
% reconnecting disconnected branches, removing isolated branches, and
% obtains a coronary artery tree finally.
% ���ú�������rpath���¹�״������ÿ������ͼ���������������������ֵ�������ס�ϸ�����ֲ��˵��⡢�������ӶϿ��ķ�֧���Ƴ������ķ�֧�����յõ���״����������
% Examples:
%   coronary_refine('path_of_parent_directory_containg_volumes')

% create output directory�����������ļ��Ĵ洢Ŀ¼
wpath = fullfile(rpath, 'coronary');
if ~exist(wpath, 'dir'), mkdir(wpath); end

% processing each volume under rpath
img_list = dir(fullfile(rpath, '*.mha'));
for ii = 1:length(img_list)
    
    %% read mha volume
    img_path = fullfile(rpath, img_list(ii).name);%����ļ���
    [img_prop, img_info] = mha_read_volume(img_path);
    
    %% thresholdingCoro:��ֵ��
    img_bin = img_prop >= (0.5*intmax('uint16'));
    % check the binary image obtained by considering it as a volume data,
    % and you can also store the binary volume into a single file (.mha file)
%     volumeViewer(img_bin); %��ʾ
%     w_info = img_info; % header information of volume to be written
%     w_info.DataType = 'uchar'; % change the data type to uchar (uint8)
%     mha_write(img_bin, w_info, 'path');
    
    %% filling holes���
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
    
    %% thinning��ϸ��
    % your code here ...
    %
    % plot the centerline of coronary artery by considering it as a set of
    % points, e.g. denote 'img_thin' as the result of thinning step
    Bw_thin = bwskel(img_bin);%�Լ���Ƶ�ϸ��������ȡ
    %Bw_thin = Thining(img_bin);
    %Bw_thin = img_thin_066;%��ȡ�õ����ݣ�Ҫ��������ȵ���ȡ��
    figure(1)
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(Bw_thin), find(Bw_thin));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    
    %% detecting bifucation and end points:���ֲ�Ͷ˵�
    % your code here ...
    % ������BifucationAndEndPoint.m,����ĺ����������ˣ��˴�����ִ��
    % Bp:���ϵĵ㣻Ep:�˵㣻Lp:���ϵĵ�
    [Bp,Ep,Lp] = BifucationAndEndPoint(Bw_thin);
    %% reconnecting disconnected branches & removing isolate points or branches
    %�������ӶϿ��ķ�֧&�Ƴ������ĵ���֧
    % your code here ...
    % ������DeleteBurr:ɾ��һЩ����
    img_thin_dlt = DeleteBurr(Bw_thin);
    
    figure(2),
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(img_thin_dlt), find(img_thin_dlt));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    
    %������WipeBurr.m:ɾ��һЩë�̺�һЩ�����ĵ�
    img_thin_burr = WipeBurr(img_thin_dlt);
    
    figure(3),
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(img_thin_burr), find(img_thin_burr));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    
    %������Connection.m:��ȥ��ë�̺��ͼ�������ӣ�����һЩ�϶̵Ķ���
    
    img_thin_cnt = ConnectionPL(img_thin_burr);
    
    figure(4)
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(img_thin_cnt), find(img_thin_cnt));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    
    %������FinalDelete.m��һЩ�ϳ����ߣ�֮ǰû��ɾ������������������߽�Զ��������������������ɾ����
    img_thin_dlt_final = FinalDelete(img_thin_cnt);
    %img_thin_dlt_final = img_thin_cnt;
    figure(5)
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(img_thin_dlt_final), find(img_thin_dlt_final));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    %% obtain coronary artery tree (by tracking or other methods)
    %��ȡ��״������(ͨ�����ٻ���������)
    % your code here ...
    %
    % plot the complete coronary artery tree in different color according
    % to the ids of branches, e.g. denote 'coro_tree', a cell array, as the
    % coronary artery tree obtained, and each element is a coordinate array
    % of a single branch
    %���ݷ�֧��id���ò�ͬ����ɫ���������Ĺ�״�����������磬�õ��Ĺ�״������Ϊϸ�����С�coro_tree����ÿ��Ԫ��Ϊ������֧����������
    
    % ����PeriodCp.m�������
    %���У�Line:�߶Σ�LineEnd:�߶ζ��㣻EndPoint:���ж˵�
    [Line,LineEnd,EndPoint] = PeriodCp(img_thin_dlt_final);
    
    coronary_show(Line)
    %�����ǽ����ж˵�ͷֲ��Ҳ��ʾ�����յ�ͼ�ϣ��Ժ�����ʽ
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
