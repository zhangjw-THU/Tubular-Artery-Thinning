#张嘉玮
#自61
#2016011528
#2018/12/1

脚本说明：
              BifucationAndEndPoint.m：检测细化后的图像的分叉点、端点、线点
              ConnectionPL.m：连接 : 点——线
              ConnectionPP.m：连接：点——点
              coronary_refine.m：  This function processes each probability map of coronary arteries 
                                                 under 'rpath'. The processing steps include but not limited to thresholding,
                                                 filling holes, thinning, detecting bifurcation or end points,
                                                 reconnecting disconnected branches, removing isolated branches, and 
                                                 obtains a coronary artery tree finally.
               coronary_show.m：This function loads existing coronary artery tree 'coro_tree', and plot 
                                               it in different color according to the ids of branches. Before sorting,
                                               the order of points in each branch is unknown, thus a scatter plot is needed.
               DeleteBurr.m：删除孤立短线
               FillHole.m：填补空洞
               FinalDelete.m：最后删除没有连接起来的短线
               mha_read_header.m：Function for reading the header of a Insight Meta-Image (.mha,.mhd) file
               mha_read_volume.m：Function for reading the volume of a Insight Meta-Image (.mha, .mhd) file
               mha_write.m：save
               MyHitMisKn.m：在细化函数中调用，获得“击中与否”的两个核
               MyRot.m：旋转函数
               PeriodCp.m：改进的追踪算法
               WipeBurr.m：对细化后的结果进行修正/去除毛刺
               
文件说明：
              2016011528_张嘉玮_综合作业_2.pdf：report
              MHAfile：mha文件夹
                             特别的：
                                        两个图像使用自己实现的细化函数的细化结果
                                        img_thin_054.mat 对应实验结果 Line_55_My.mat
                                        img_thin_066.mat 对应实验结果 Line_66_My.mat
                                       
                            

              
               
              
              