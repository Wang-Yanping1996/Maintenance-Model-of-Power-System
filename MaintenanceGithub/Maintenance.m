clc;
clear;
close all;
clear all class;

addpath('./example');
addpath('./functions');
addpath('./Maintenance');

%%
% ����
% casename = input('Please enter case name : ', 's');
casename = 'ReMS_118bus_168.xls';
% casename = 'case_RTS_GMLC.m';

k_safe = 1;         %��ȫϵ����������һ����ԣ�ȣ���Գ�����ȫԼ��
n_L = 1;              %����������κ����ֶ���
% ��ʼ���ļ�
initial_Maintenance;

%%
%���ɾ������
% [Ybus, Yf, Yt] = makeYbus(baseMVA, bus, M_branch);   % build admitance matrix
[Bbus, Bf, Pbusinj, Pfinj] = makeBdc(baseMVA, bus, branch);       %ֱ������
%%
% �������߱���
%%
%�����޻���״̬ 1Ϊ������0Ϊ������
MaintGenState = binvar(n_MaintGen,n_T,'full');
%��������·״̬ 1Ϊ������0Ϊ������
MaintBranchState = binvar(n_MaintBranch,n_T,'full');

% ��緢������� 
gen_P = sdpvar(n_gen, n_T,'full');
gen_P_upper = sdpvar(n_gen, n_T,'full');

% ������״̬
u_state = binvar(n_gen, n_T,'full');    

% ����ϵͳ��֧·����
PF_D  = sdpvar(n_branch, n_T,'full');
% ����ϵͳ���ڵ����
Va = sdpvar(n_bus,n_T,'full');

C = [];     %Լ��
% C = sdpvar(C)>=0;
SCUC_value = 0;

%%
%���Լ��
%%
%�����鿪������
% Add_Huodian_Startup;
%%
%����ƽ��
% Add_PowerBalance;
Add_PowerFlow;
%%
%����Լ��
% Add_Ramp;
%%
%��С��ͣʱ������
% Add_MinUpDownTime;
%%
%���������
Add_Huodian_UnitOutput;
%%
%��ȫԼ��
Add_SecurityConstraints;
%%
%�������Լ��
if (n_MaintGen>0)
    Add_MaintenanceGen;
end
%%
%��·����Լ��
if (n_MaintBranch>0)
    Add_MaintenanceBranch;
end
%%
%�������
Add_ObjMinReserve;
%%
%���޷���
Add_ObjMaintenanceCost;
%%     
%���� 
ops = sdpsettings('solver','gurobi','verbose',2,'usex0',0);      
ops.gurobi.MIPGap = 1e-6;
ops.cplex.mip.tolerances.mipgap = 1e-6;
% ops.cplex.mip.cuts.covers = 3;
% ops.cplex.mip.cuts.flowcovers = 2;
% ops.cplex.mip.cuts.pathcut = 2;
% ops.cplex.mip.cuts.mircut = 2;
% ops.cplex.mip.cuts.disjunctive = 3;
% ops.cplex.mip.cuts.implied = 2;
% ops.cplex.mip.cuts.liftproj = 3;
%%
%���        
% MixObj = 1e5*ReserveObj+TotalMaintCost;       %��Ŀ���Ȩ
% result = optimize(C);                         %���н�
% result = optimize(C, ReserveObj, ops);          %��С�������ʱ�䳤��
% result = optimize(C, -MinReserveRate, ops);   %�����С����
result = optimize(C, TotalMaintCost, ops);    %��С����

if result.problem == 0 % problem =0 �������ɹ�   
else
    error('������');
end  
% plot([1: n_T], [sum(value(gen_P(:,:)))]);
plot([1: n_T], [value(gen_P(:,:))]);            %�������������
%%
%һЩֵ�Ļ�ȡ
gen_P = value(gen_P(:,:));
gen_P_upper = value(gen_P_upper);
PF_D = value(PF_D);
u_state = value(u_state(:,:));
% gen_P_nl = value(gen_P_nl);
Va = value(Va);
MaintBranchState = value(MaintBranchState);
MaintGenState = value(MaintGenState);
MinReserveRate = value(MinReserveRate);
MaintGenCost = value(MaintGenCost);
MaintBranchCost = value(MaintBranchCost);
TotalMaintCost = value(TotalMaintCost);
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
plot(1:n_T, ReserveRate);
% ReseveRate = zeros(1,n_T);
% for t = 1: n_T
%     ReseveRate(1,t) = 1-sum(PD(:,t))/(sum(u_state(:,t).*gen(:,GEN_PMAX))/baseMVA);
% end
% plot(1:n_T,ReseveRate);

