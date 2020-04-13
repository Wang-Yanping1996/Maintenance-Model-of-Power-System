%Ŀ�꺯�� �����С������
MinReserveRate = sdpvar(1,1);
for t = 1: n_T
    C = [C,
        %������1-PD/Capacity������Capacity�Ǳ����������޸�һ�£�Ч��Ӧ�ò��
        MinReserveRate <= (sum(u_state(:,t).*gen(:,GEN_PMAX))/baseMVA)/sum(PD(:,t))-1,
        ];
end
%%
%��һ�����Ƶȱ����ʵķ��� ����������
ReserveRate = sdpvar(1,n_T);        %ÿʱ�α���
AveReserveRate = sdpvar(1,1);       %ƽ������
ReserveRateDifAbs = sdpvar(1,n_T);  %ÿʱ�α�����ƽ�����ò�ľ���ֵ
GenCapacity = sdpvar(1,n_T);        %��ʱ�λ���������
ReserveObj = 1;
% ReserveObj = 1 + sum(ReserveRateDifAbs(1,:));                     %����Ӹ�������Ҫ��Ȼ�ɳڽ�Ϊ0����������� gapһֱ100%
C = [C,
    AveReserveRate*n_T == sum(ReserveRate(1,:)),
    ];
for t = 1: n_T
    C = [C,
        GenCapacity(1,t) == sum(u_state(:,t).*gen(:,GEN_PMAX))/baseMVA,
        ReserveRate(1,t) == GenCapacity(1,t)/sum(PD(:,t))-1,
        ReserveRate(1,t) >= 0.1,        %��С��������
%         ReserveRateDifAbs(1,t) >= AveReserveRate-ReserveRate(1,t),
%         ReserveRateDifAbs(1,t) >= ReserveRate(1,t)-AveReserveRate,
%         ReserveRateDifAbs(1,t) >= 0,
        ];
    ReserveObj = ReserveObj + (AveReserveRate-ReserveRate(1,t))^2/n_T;
end

%%
% %��һ�����Ƶȱ����ʵķ��� ����������
% ReserveRate = sdpvar(1,n_T);        %ÿʱ�α���
% % ReserveRateDifAbs = sdpvar(1,n_T);  %ÿʱ�α�����ƽ�����ò�ľ���ֵ
% GenCapacity = sdpvar(1,n_T);        %��ʱ�λ���������
% ReserveObj = 1;
% % ReserveObj = 1 + sum(ReserveRateDifAbs(1,:));                     %����Ӹ�������Ҫ��Ȼ�ɳڽ�Ϊ0����������� gapһֱ100%
% for i = 1: n_T-1
%     for j = i+1: n_T
%         ReserveObj = ReserveObj+abs(ReserveRate(1,i)-ReserveRate(1,j));
%     end
% end
% for t = 1: n_T
%     C = [C,
%         GenCapacity(1,t) == sum(u_state(:,t).*gen(:,GEN_PMAX))/baseMVA,
%         ReserveRate(1,t) == GenCapacity(1,t)/sum(PD(:,t))-1,
%         2>=ReserveRate(1,t) >= 0.1,        %��С��������
% %         ReserveRateDifAbs(1,t) >= AveReserveRate-ReserveRate(1,t),
% %         ReserveRateDifAbs(1,t) >= ReserveRate(1,t)-AveReserveRate,
% %         2>=ReserveRateDifAbs(1,t) >= 0,
%         ];
% end





