%%
%��Щ�������Լ��Ҳ����д��һ���ű������ ����
%������������� ���κ����ֶ����Ի�
gen_P_nl = sdpvar(n_gen, n_L, n_T);
for i = 1: n_gen
        for t = 1: n_T
            C = [C,
                gen_P(i,t) == sum(gen_P_nl(i,:,t))+gen(i,GEN_PMIN)*u_state(i,t)/baseMVA,
                ];
            for l = 1: n_L
                C = [C,
                    0 <= gen_P_nl(i,l,t) <= (gen(i, GEN_PMAX)-gen(i, GEN_PMIN))/n_L/baseMVA,
                    ];
            end
        end
end

%%
%������ɱ�������������2�κ���  ������Ҫ��д
% ���κ�����ʽ�����������������Ȼ����׶Լ���Ѿ�ȥ���ˣ������Ŀ�꺯��Ҳ�ֶ����Ի�������������MILP���������ȷʵ��һЩ
% opf_value = sum(gencost(:, GENCOST_C2)'*(gen_P(gen(:, GEN_BUS),:)*baseMVA).^2) + ...
%             sum(gencost(:, GENCOST_C1)'* gen_P(gen(:, GEN_BUS),:)*baseMVA) + ...
%             sum(gencost(:, GENCOST_C0)'*u_state(gen(:, GEN_BUS),:)) + ...
%             sum(sum(cost_up));
% Ŀ�꺯���ֶ����Ի�
for i = 1: n_gen
        for t = 1: n_T
            SCUC_value = SCUC_value + A_gen(i)*u_state(i,t);
            for l = 1: n_L
                if (~isnan(Fij(i,l)))
                    SCUC_value = SCUC_value + Fij(i,l)*gen_P_nl(i,l,t)*baseMVA;
                end
            end
        end
end



