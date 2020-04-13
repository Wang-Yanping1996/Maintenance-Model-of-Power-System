%%
%机组检修
MaintGenStartFlag = binvar(n_MaintGen,n_T,'full');       %在时刻t机组i开始检修
MaintGenEndFlag = binvar(n_MaintGen,n_T,'full');         %在时刻t机组i停止检修
%窗口约束
for i = 1: n_MaintGen
    for t = 1: n_T
        if (t<MaintGen(i,MAINTGEN_StartPeriod)||t>MaintGen(i,MAINTGEN_EndPeriod))
            C = [C,
                MaintGenState(i,t) == 1,
                ];
        end
    end
end
%总检修时间
for i = 1: n_MaintGen
    C = [C,
        sum(MaintGenState(i,:)) == n_T-MaintGen(i,MAINTGEN_DURATION),
        ];
end
%检修连续性
for i = 1: n_MaintGen
    C = [C,
        MaintGen(i,MAINTGEN_DURATION)-sum(MaintGenState(i,[1: MaintGen(i,MAINTGEN_DURATION)])) >= MaintGen(i,MAINTGEN_DURATION).*(1-MaintGenState(i,1)),
        MaintGenStartFlag(i,1)-MaintGenEndFlag(i,1) == 1-MaintGenState(i,1),     %启停标志与状态之间关系
        MaintGenStartFlag(i,1)+MaintGenEndFlag(i,1)<=1,
        ];
    for t = 2: n_T-MaintGen(i,MAINTGEN_DURATION)+1
        C = [C,
            MaintGen(i,MAINTGEN_DURATION)-sum(MaintGenState(i,[t: t+MaintGen(i,MAINTGEN_DURATION)-1])) >= MaintGen(i,MAINTGEN_DURATION).*(MaintGenState(i,t-1)-MaintGenState(i,t)),
            MaintGenStartFlag(i,t)-MaintGenEndFlag(i,t) == MaintGenState(i,t-1)-MaintGenState(i,t),     %启停标志与状态之间关系
            MaintGenStartFlag(i,t)+MaintGenEndFlag(i,t)<=1,
            ];
    end
    for t = n_T-MaintGen(i,MAINTGEN_DURATION)+2: n_T
        C = [C,
            MaintGenStartFlag(i,t)-MaintGenEndFlag(i,t) == MaintGenState(i,t-1)-MaintGenState(i,t),     %启停标志与状态之间关系
            MaintGenStartFlag(i,t)+MaintGenEndFlag(i,t)<=1,
            ];
    end
end
%检修时不出力
for  t = 1: n_T
    for i = 1: n_MaintGen
        temp = MaintGen(i,MAINTGEN_NAME);
            C = [C,
                MaintGenState(i,t).*gen(temp, GEN_PMAX)/baseMVA  >= gen_P(temp,t),
                MaintGenState(i,t).*gen(temp, GEN_PMAX)/baseMVA  >= gen_P_upper(temp,t),
                ];
    end
end
%纵向crewyueshu
for t = 1: n_T
    C = [C,
        n_MaintGen-sum(MaintGenState(:,t))<=crew(t,CREW_GENN),                                   %同时检修机组数
        sum(gen(MaintGen(:,MAINTGEN_NAME),GEN_PMAX).*(1-MaintGenState(:,t)))<=crew(t,CREW_GENC),    %同时检修机组容量
        ];
end





