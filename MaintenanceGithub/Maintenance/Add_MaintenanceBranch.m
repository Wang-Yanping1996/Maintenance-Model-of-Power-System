%%
%线路检修
%窗口约束
for i = 1: n_MaintBranch
    for t = 1: n_T
        if (t<MaintBranch(i,MAINTBR_StartPeriod)||t>MaintBranch(i,MAINTBR_EndPeriod))
            C = [C,
                MaintBranchState(i,t) == 1,
                ];
        end
    end
end
%总检修时间
for i = 1: n_MaintBranch
    C = [C,
        sum(MaintBranchState(i,:)) == n_T-MaintBranch(i,MAINTBR_DURATION),
        ];
end

%检修时不出力
for  t = 1: n_T
    for i = 1: n_MaintBranch
        temp = MaintBranch(i,MAINTBR_NAME);
        if (branch(i, RATE_A) ~= 0)     %rateA为0则认为不需要添加安全约束
            C = [C,
                -k_safe*branch(temp, RATE_A)*MaintBranchState(i,t)/baseMVA <= PF_D(temp,t) <= k_safe*branch(temp, RATE_A)*MaintBranchState(i,t)/baseMVA
                ];
        end
    end
end
%纵向crew约束
for t = 1: n_T
    C = [C,
        n_MaintBranch-sum(MaintBranchState(:,t))<=crew(t,CREW_BRN),                                         %同时检修支路数
        sum(branch(MaintBranch(:,MAINTBR_NAME),RATE_A).*(1-MaintBranchState(:,t)))<=crew(t,CREW_BRC),  %同时检修支路容量
        ];
end

% %检修连续性
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
%考虑多次检修
MaintBranchStartFlag = binvar(n_MaintBranch,n_T,'full');       %在时刻t支路i开始检修
MaintBranchEndFlag = binvar(n_MaintBranch,n_T,'full');         %在时刻t支路i停止检修
for i = 1: n_MaintBranch
    C = [C,
        MaintBranchStartFlag(i,1)-MaintBranchEndFlag(i,1) == 1-MaintBranchState(i,1),
        MaintBranchStartFlag(i,1)+MaintBranchEndFlag(i,1)<=1,
        sum(MaintBranchStartFlag(i,:)) <= MaintBranch(i,MAINTBR_MaxPartialMaintTimes),  %检修次数约束
        ];
    for t = 2: n_T
        C = [C,
            MaintBranchStartFlag(i,t)-MaintBranchEndFlag(i,t) == MaintBranchState(i,t-1)-MaintBranchState(i,t),
            MaintBranchStartFlag(i,t)+MaintBranchEndFlag(i,t)<=1,
            ];
    end
end
%检修连续性
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
%最小检修间隔
for i = 1: n_MaintBranch
%     temp = MaintBranch(i,MAINTBR_NAME);
    for t = 2: n_T-MaintBranch(i,MAINTBR_MinMaintInterval)+1
        C = [C,
            sum(MaintBranchState(i,[t: t+MaintBranch(i,MAINTBR_MinMaintInterval)-1])) >= MaintBranch(i,MAINTBR_MinMaintInterval).*(MaintBranchState(i,t)-MaintBranchState(i,t-1)),
            ];
    end
end