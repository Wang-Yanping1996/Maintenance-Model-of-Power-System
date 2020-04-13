%%
%��·����
%����Լ��
for i = 1: n_MaintBranch
    for t = 1: n_T
        if (t<MaintBranch(i,MAINTBR_StartPeriod)||t>MaintBranch(i,MAINTBR_EndPeriod))
            C = [C,
                MaintBranchState(i,t) == 1,
                ];
        end
    end
end
%�ܼ���ʱ��
for i = 1: n_MaintBranch
    C = [C,
        sum(MaintBranchState(i,:)) == n_T-MaintBranch(i,MAINTBR_DURATION),
        ];
end

%����ʱ������
for  t = 1: n_T
    for i = 1: n_MaintBranch
        temp = MaintBranch(i,MAINTBR_NAME);
        if (branch(i, RATE_A) ~= 0)     %rateAΪ0����Ϊ����Ҫ��Ӱ�ȫԼ��
            C = [C,
                -k_safe*branch(temp, RATE_A)*MaintBranchState(i,t)/baseMVA <= PF_D(temp,t) <= k_safe*branch(temp, RATE_A)*MaintBranchState(i,t)/baseMVA
                ];
        end
    end
end
%����crewԼ��
for t = 1: n_T
    C = [C,
        n_MaintBranch-sum(MaintBranchState(:,t))<=crew(t,CREW_BRN),                                         %ͬʱ����֧·��
        sum(branch(MaintBranch(:,MAINTBR_NAME),RATE_A).*(1-MaintBranchState(:,t)))<=crew(t,CREW_BRC),  %ͬʱ����֧·����
        ];
end

% %����������
% for i = 1: n_MaintBranch
%     C = [C,
%         MaintBranch(i,MAINTBR_DURATION)-sum(MaintBranchState(i,[1: MaintBranch(i,MAINTBR_DURATION)])) >= MaintBranch(i,MAINTBR_DURATION).*(1-MaintBranchState(i,1)),
%         ];
%     for t = 2: n_T-MaintBranch(i,MAINTBR_DURATION)+1
%         C = [C,
%             MaintBranch(i,MAINTBR_DURATION)-sum(MaintBranchState(i,[t: t+MaintBranch(i,MAINTBR_DURATION)-1])) >= MaintBranch(i,MAINTBR_DURATION).*(MaintBranchState(i,t-1)-MaintBranchState(i,t)),
%             ];
%     end
% end

%%
%���Ƕ�μ���
MaintBranchStartFlag = binvar(n_MaintBranch,n_T,'full');       %��ʱ��t֧·i��ʼ����
MaintBranchEndFlag = binvar(n_MaintBranch,n_T,'full');         %��ʱ��t֧·iֹͣ����
for i = 1: n_MaintBranch
    C = [C,
        MaintBranchStartFlag(i,1)-MaintBranchEndFlag(i,1) == 1-MaintBranchState(i,1),
        MaintBranchStartFlag(i,1)+MaintBranchEndFlag(i,1)<=1,
        sum(MaintBranchStartFlag(i,:)) <= MaintBranch(i,MAINTBR_MaxPartialMaintTimes),  %���޴���Լ��
        ];
    for t = 2: n_T
        C = [C,
            MaintBranchStartFlag(i,t)-MaintBranchEndFlag(i,t) == MaintBranchState(i,t-1)-MaintBranchState(i,t),
            MaintBranchStartFlag(i,t)+MaintBranchEndFlag(i,t)<=1,
            ];
    end
end
%����������
for i = 1: n_MaintBranch
%     temp = MaintBranch(i,MAINTBR_NAME);
    C = [C,
        MaintBranch(i,MAINTBR_MinPartialMaintDuration)-sum(MaintBranchState(i,[1: MaintBranch(i,MAINTBR_MinPartialMaintDuration)])) >= MaintBranch(i,MAINTBR_MinPartialMaintDuration).*(1-MaintBranchState(i,1)),
        ];
    for t = 2: n_T-MaintBranch(i,MAINTBR_MinPartialMaintDuration)+1
        C = [C,
            MaintBranch(i,MAINTBR_MinPartialMaintDuration)-sum(MaintBranchState(i,[t: t+MaintBranch(i,MAINTBR_MinPartialMaintDuration)-1])) >= MaintBranch(i,MAINTBR_MinPartialMaintDuration).*(MaintBranchState(i,t-1)-MaintBranchState(i,t)),
            ];
    end
end
%��С���޼��
for i = 1: n_MaintBranch
%     temp = MaintBranch(i,MAINTBR_NAME);
    for t = 2: n_T-MaintBranch(i,MAINTBR_MinMaintInterval)+1
        C = [C,
            sum(MaintBranchState(i,[t: t+MaintBranch(i,MAINTBR_MinMaintInterval)-1])) >= MaintBranch(i,MAINTBR_MinMaintInterval).*(MaintBranchState(i,t)-MaintBranchState(i,t-1)),
            ];
    end
end