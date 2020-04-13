%%
%�������
MaintGenStartFlag = binvar(n_MaintGen,n_T,'full');       %��ʱ��t����i��ʼ����
MaintGenEndFlag = binvar(n_MaintGen,n_T,'full');         %��ʱ��t����iֹͣ����
%����Լ��
for i = 1: n_MaintGen
    for t = 1: n_T
        if (t<MaintGen(i,MAINTGEN_StartPeriod)||t>MaintGen(i,MAINTGEN_EndPeriod))
            C = [C,
                MaintGenState(i,t) == 1,
                ];
        end
    end
end
%�ܼ���ʱ��
for i = 1: n_MaintGen
    C = [C,
        sum(MaintGenState(i,:)) == n_T-MaintGen(i,MAINTGEN_DURATION),
        ];
end
%����������
for i = 1: n_MaintGen
    C = [C,
        MaintGen(i,MAINTGEN_DURATION)-sum(MaintGenState(i,[1: MaintGen(i,MAINTGEN_DURATION)])) >= MaintGen(i,MAINTGEN_DURATION).*(1-MaintGenState(i,1)),
        MaintGenStartFlag(i,1)-MaintGenEndFlag(i,1) == 1-MaintGenState(i,1),     %��ͣ��־��״̬֮���ϵ
        MaintGenStartFlag(i,1)+MaintGenEndFlag(i,1)<=1,
        ];
    for t = 2: n_T-MaintGen(i,MAINTGEN_DURATION)+1
        C = [C,
            MaintGen(i,MAINTGEN_DURATION)-sum(MaintGenState(i,[t: t+MaintGen(i,MAINTGEN_DURATION)-1])) >= MaintGen(i,MAINTGEN_DURATION).*(MaintGenState(i,t-1)-MaintGenState(i,t)),
            MaintGenStartFlag(i,t)-MaintGenEndFlag(i,t) == MaintGenState(i,t-1)-MaintGenState(i,t),     %��ͣ��־��״̬֮���ϵ
            MaintGenStartFlag(i,t)+MaintGenEndFlag(i,t)<=1,
            ];
    end
    for t = n_T-MaintGen(i,MAINTGEN_DURATION)+2: n_T
        C = [C,
            MaintGenStartFlag(i,t)-MaintGenEndFlag(i,t) == MaintGenState(i,t-1)-MaintGenState(i,t),     %��ͣ��־��״̬֮���ϵ
            MaintGenStartFlag(i,t)+MaintGenEndFlag(i,t)<=1,
            ];
    end
end
%����ʱ������
for  t = 1: n_T
    for i = 1: n_MaintGen
        temp = MaintGen(i,MAINTGEN_NAME);
            C = [C,
                MaintGenState(i,t).*gen(temp, GEN_PMAX)/baseMVA  >= gen_P(temp,t),
                MaintGenState(i,t).*gen(temp, GEN_PMAX)/baseMVA  >= gen_P_upper(temp,t),
                ];
    end
end
%����crewyueshu
for t = 1: n_T
    C = [C,
        n_MaintGen-sum(MaintGenState(:,t))<=crew(t,CREW_GENN),                                   %ͬʱ���޻�����
        sum(gen(MaintGen(:,MAINTGEN_NAME),GEN_PMAX).*(1-MaintGenState(:,t)))<=crew(t,CREW_GENC),    %ͬʱ���޻�������
        ];
end





