%%
% �������Լ��
% ��������
for t = 1: n_T
    if (t > 1)
    C = [C,
        %���Լ������2006������
        %A Computationally Efficient Mixed-Integer Linear Formulation for the Thermal Unit Commitment Problem
        %д�ģ���֪��Pmax*(1-u)������ʲô��
        %�������ƺ��������� (ramp-up & startup)    (18)
        gen_P_upper(:,t) <= gen_P(:,t-1) + RU.*u_state(:,t-1) + ...
                                   SU.*(u_state(:,t)-u_state(:,t-1)) + ...
                                   (gen(:, GEN_PMAX)/baseMVA).*(1-u_state(:,t)),
%         �������� (ramp-down)       (20)
        gen_P(:,t-1) - gen_P(:,t) <= RD.*u_state(:,t) + ...
                                     SD.*(u_state(:,t-1)-u_state(:,t)) + ...
                                     (gen(:, GEN_PMAX)/baseMVA).*(1-u_state(:,t-1)),
        ];
    end
    if (t < n_T)
        C = [C,
            %�ػ����� (shutdown)    (19)
            gen_P_upper(:,t) <= (gen(:, GEN_PMAX)/baseMVA).*u_state(:,t+1) + ...
                                       SD.*(u_state(:,t)-u_state(:,t+1)),
                                       ];
    end
end
