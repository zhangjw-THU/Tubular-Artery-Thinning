#�ż���
#��61
#2016011528
#2018/12/1

�ű�˵����
              BifucationAndEndPoint.m�����ϸ�����ͼ��ķֲ�㡢�˵㡢�ߵ�
              ConnectionPL.m������ : �㡪����
              ConnectionPP.m�����ӣ��㡪����
              coronary_refine.m��  This function processes each probability map of coronary arteries 
                                                 under 'rpath'. The processing steps include but not limited to thresholding,
                                                 filling holes, thinning, detecting bifurcation or end points,
                                                 reconnecting disconnected branches, removing isolated branches, and 
                                                 obtains a coronary artery tree finally.
               coronary_show.m��This function loads existing coronary artery tree 'coro_tree', and plot 
                                               it in different color according to the ids of branches. Before sorting,
                                               the order of points in each branch is unknown, thus a scatter plot is needed.
               DeleteBurr.m��ɾ����������
               FillHole.m����ն�
               FinalDelete.m�����ɾ��û�����������Ķ���
               mha_read_header.m��Function for reading the header of a Insight Meta-Image (.mha,.mhd) file
               mha_read_volume.m��Function for reading the volume of a Insight Meta-Image (.mha, .mhd) file
               mha_write.m��save
               MyHitMisKn.m����ϸ�������е��ã���á�������񡱵�������
               MyRot.m����ת����
               PeriodCp.m���Ľ���׷���㷨
               WipeBurr.m����ϸ����Ľ����������/ȥ��ë��
               
�ļ�˵����
              2016011528_�ż���_�ۺ���ҵ_2.pdf��report
              MHAfile��mha�ļ���
                             �ر�ģ�
                                        ����ͼ��ʹ���Լ�ʵ�ֵ�ϸ��������ϸ�����
                                        img_thin_054.mat ��Ӧʵ���� Line_55_My.mat
                                        img_thin_066.mat ��Ӧʵ���� Line_66_My.mat
                                       
                            

              
               
              
              