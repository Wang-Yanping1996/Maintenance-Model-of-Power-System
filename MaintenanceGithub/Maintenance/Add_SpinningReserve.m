%%
% �������Լ��
%��ת����Լ��
for t = 1: n_T
    C = [C,
        sum(gen_P_upper(:,t))+sum(Pmax_Shui)+sum(TeInput(:,t))-sum(Spinning(:,t))-sum(PD(:,t))>=0,  %����sum(PmaxShui)�ƺ�û��Ҫ
%         sum(PD(:,t))-sum(gen_P_lower(:,t))-sum(Pmin_Shui)-sum(TeInput(:,t)) >=0,                    %���û����
        ];
end
