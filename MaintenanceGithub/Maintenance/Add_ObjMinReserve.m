%目标函数 最大化最小备用率
MinReserveRate = sdpvar(1,1);
for t = 1: n_T
    C = [C,
        %正常是1-PD/Capacity，但是Capacity是变量，所以修改一下，效果应该差不多
        MinReserveRate <= (sum(u_state(:,t).*gen(:,GEN_PMAX))/baseMVA)/sum(PD(:,t))-1,
        ];
end
%%
%另一种类似等备用率的方法 收敛有问题
ReserveRate = sdpvar(1,n_T);        %每时段备用
AveReserveRate = sdpvar(1,1);       %平均备用
ReserveRateDifAbs = sdpvar(1,n_T);  %每时段备用与平均备用差的绝对值
GenCapacity = sdpvar(1,n_T);        %各时段机组总容量
ReserveObj = 1;
% ReserveObj = 1 + sum(ReserveRateDifAbs(1,:));                     %必须加个常数，要不然松弛解为0，求解会出问题 gap一直100%
C = [C,
    AveReserveRate*n_T == sum(ReserveRate(1,:)),
    ];
for t = 1: n_T
    C = [C,
        GenCapacity(1,t) == sum(u_state(:,t).*gen(:,GEN_PMAX))/baseMVA,
        ReserveRate(1,t) == GenCapacity(1,t)/sum(PD(:,t))-1,
        ReserveRate(1,t) >= 0.1,        %最小备用限制
%         ReserveRateDifAbs(1,t) >= AveReserveRate-ReserveRate(1,t),
%         ReserveRateDifAbs(1,t) >= ReserveRate(1,t)-AveReserveRate,
%         ReserveRateDifAbs(1,t) >= 0,
        ];
    ReserveObj = ReserveObj + (AveReserveRate-ReserveRate(1,t))^2/n_T;
end

%%
% %另一种类似等备用率的方法 收敛有问题
% ReserveRate = sdpvar(1,n_T);        %每时段备用
% % ReserveRateDifAbs = sdpvar(1,n_T);  %每时段备用与平均备用差的绝对值
% GenCapacity = sdpvar(1,n_T);        %各时段机组总容量
% ReserveObj = 1;
% % ReserveObj = 1 + sum(ReserveRateDifAbs(1,:));                     %必须加个常数，要不然松弛解为0，求解会出问题 gap一直100%
% for i = 1: n_T-1
%     for j = i+1: n_T
%         ReserveObj = ReserveObj+abs(ReserveRate(1,i)-ReserveRate(1,j));
%     end
% end
% for t = 1: n_T
%     C = [C,
%         GenCapacity(1,t) == sum(u_state(:,t).*gen(:,GEN_PMAX))/baseMVA,
%         ReserveRate(1,t) == GenCapacity(1,t)/sum(PD(:,t))-1,
%         2>=ReserveRate(1,t) >= 0.1,        %最小备用限制
% %         ReserveRateDifAbs(1,t) >= AveReserveRate-ReserveRate(1,t),
% %         ReserveRateDifAbs(1,t) >= ReserveRate(1,t)-AveReserveRate,
% %         2>=ReserveRateDifAbs(1,t) >= 0,
%         ];
% end





