%%
%��������
% ֧·����Լ��
for t = 1: n_T
    C = [C,
        PF_D(:, t) == Bf*Va(:, t) + Pfinj,
        ];
end
%%
% �ڵ㹦��ƽ��Լ��(������ʽ)
GenIncMatrix = zeros(n_bus,n_gen);
for i=1:n_gen
    GenIncMatrix(gen(i,GEN_BUS),i)=1;
end
for t = 1: n_T
    C = [C,
        GenIncMatrix*gen_P(:,t)-PD(:,t) ==  Bbus*Va(:,t)+Pbusinj,
        ];
end

%%
% % �ڵ㹦��ƽ��Լ��
% % ��������⣬gen_Pֻ��n_gen
% for t = 1: n_T
%     for i = 1: n_bus
%         [temp1, temp2] = find(gen(:,1)==i);
%         if (temp1)
%             C = [C,
% %                 gen_P(temp2,t) == PD(i,t) + ...
% %                               sum(PF_D(branch(:, F_BUS) == i,t)) - ...
% %                               sum(PF_D(branch(:, T_BUS) == i,t)) + ...
% %                               bus(i, BUS_GS)/baseMVA,
%                 gen_P(temp1,t)-PD(i,t) == Bbus(i,:)*Va(:,t)+Pbusinj(i,:),
%                 ];
%         else
%             C = [C,
% %                 0 == PD(i,t) + ...
% %                               sum(PF_D(branch(:, F_BUS) == i,t)) - ...
% %                               sum(PF_D(branch(:, T_BUS) == i,t)) + ...
% %                               bus(i, BUS_GS)/baseMVA,
%                 0-PD(i,t) == Bbus(i,:)*Va(:,t)+Pbusinj(i,:),
%                 ];
%         end
%     end
% end