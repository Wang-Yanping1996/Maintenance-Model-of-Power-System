%% 
% �������Լ��
%ϵͳ����ƽ��Լ��
for t = 1: n_T
    C = [C,
        sum(gen_P(:,t)) >= sum(PD(:,t)),
        ];
end