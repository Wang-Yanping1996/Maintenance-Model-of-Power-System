%������
clc;
clear;
close all;
clear all class;

addpath('../example');
addpath('../functions');

%%
% ����
% casename = input('Please enter case name : ', 's');
% casename = 'ReMS_118bus_168.xls';
casename = 'case_RTS_GMLC.m';

k_safe = 1;         %��ȫϵ����������һ����ԣ�ȣ���Գ�����ȫԼ��
n_L = 1;              %����������κ����ֶ���
% ��ʼ���ļ�
initial_Maintenance;
% n_T = 6;
%%
%���ɾ������
% [Ybus, Yf, Yt] = makeYbus(baseMVA, bus, M_branch);   % build admitance matrix
[Bbus, Bf, Pbusinj, Pfinj] = makeBdc(baseMVA, bus, branch);       %ֱ������
%%
% �������߱���
%%
%�����޻���״̬ 1Ϊ������0Ϊ������
MaintGenState = binvar(n_MaintGen,n_T);
%��������·״̬ 1Ϊ������0Ϊ������
MaintBranchState = binvar(n_MaintBranch,n_T);

% ��緢������� 
gen_P = sdpvar(n_gen, n_T);
gen_P_upper = sdpvar(n_gen, n_T);

% ������״̬
u_state = binvar(n_gen, n_T);    

% ����ϵͳ��֧·����
PF_D  = sdpvar(n_branch, n_T);
% ����ϵͳ���ڵ����
Va = sdpvar(n_bus,n_T);

C = [];     %Լ��
% C = sdpvar(C)>=0;
SCUC_value = 0;

%%
%���Լ��
%%
%����ƽ��
% Add_PowerBalance;
Add_PowerFlow;
%%
%���������
Add_Huodian_UnitOutput;
%%
%�������
Add_ObjMinReserve;
%%     
%���� 
ops = sdpsettings('solver','gurobi','verbose',2,'usex0',0);      
ops.gurobi.MIPGap = 1e-6;
ops.cplex.mip.tolerances.mipgap = 1e-6;
ops.cplex.mip.strategy.branch = -1;
%%
%���        
% result = optimize(C);
result = optimize(C, ReserveObj, ops);
if result.problem == 0 % problem =0 �������ɹ�   
else
    error('������');
end  
plot([1: n_T], [sum(value(gen_P(:,:)))]);
plot([1: n_T], [value(gen_P(:,:))]);
%%
%һЩֵ�Ļ�ȡ
gen_P = value(gen_P(:,:));
gen_P_upper = value(gen_P_upper);
PF_D = value(PF_D);
u_state = value(u_state(:,:));
% gen_P_nl = value(gen_P_nl);
Va = value(Va);
% MaintBranchState = value(MaintBranchState);
% MaintGenState = value(MaintGenState);
MinReserveRate = value(MinReserveRate);
% MaintGenCost = value(MaintGenCost);
% MaintBranchCost = value(MaintBranchCost);
% TotalMaintCost = value(TotalMaintCost);
ReserveObj = value(ReserveObj);
ReserveRate = value(ReserveRate);
AveReserveRate = value(AveReserveRate);
ReserveRateDifAbs = value(ReserveRateDifAbs);
if (n_MaintGen>0)
    MaintGenStartFlag = value(MaintGenStartFlag);
    MaintGenEndFlag = value(MaintGenEndFlag);
end
if (n_MaintBranch>0)
    MaintBranchStartFlag = value(MaintBranchStartFlag);
    MaintBranchEndFlag = value(MaintBranchEndFlag);
end
% obj_value = value(SCUC_value);
%��Է�����Ͻ�Ϊ0���������u_state
u_state(isnan(u_state)) = 0;

%����
% MPC = mpc;
% MPC.gen(:, GEN_PG) = gen_P(: ,1)*baseMVA;
% MPC.bus(:, BUS_PD) = PD(:, 1)*baseMVA;
% test_result = rundcpf(MPC);
%%
%��������
ReseveRate = zeros(1,n_T);
for t = 1: n_T
    ReseveRate(1,t) = 1-sum(PD(:,t))/(sum(u_state(:,t).*gen(:,GEN_PMAX))/baseMVA);
end
plot(1:n_T,ReseveRate);



% %n_gen is the number of generators and n_T is the time period under study
% n_gen = 3; n_T = 3;
% UnitState = binvar(n_gen, n_T);
% GenOutput = sdpvar(n_gen, n_T);
% Load = [0.8,1.5,2.1];
% Capacity = [1 2 3];
% C = [];
% for t = 1: n_T
%       C = [C, UnitState(1,t)*Capacity(1)>= GenOutput(1,t),UnitState(2,t)*Capacity(2)>= GenOutput(2,t),UnitState(3,t)*Capacity(3)>= GenOutput(3,t)];    
%       C = [C, GenOutput(1,t) + GenOutput(2,t) + GenOutput(3,t) >= Load(t)];
% end
% AverageReserve = sdpvar(1,1);
% Reserve = sdpvar(1, n_T);
% C = [C, AverageReserve*n_T == Reserve(1,1) + Reserve(1,2) + Reserve(1,3)];
% for t = 1: n_T
%       C = [C, Reserve(1,t) == (UnitState(1,t)*Capacity(1) + UnitState(2,t)*Capacity(2) +UnitState(3,t)*Capacity(3) - Load(t))/Load(t) ];
% end
% Obj = 0;
% for t = 1: n_T
%       Obj = Obj + (Reserve(1,t)-AverageReserve)^2/n_T; 
% end
% result = optimize(C, Obj);