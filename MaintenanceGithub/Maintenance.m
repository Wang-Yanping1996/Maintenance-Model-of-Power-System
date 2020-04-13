clc;
clear;
close all;
clear all class;

addpath('./example');
addpath('./functions');
addpath('./Maintenance');

%%
% 读入
% casename = input('Please enter case name : ', 's');
casename = 'ReMS_118bus_168.xls';
% casename = 'case_RTS_GMLC.m';

k_safe = 1;         %安全系数，用于留一定的裕度，针对潮流安全约束
n_L = 1;              %机组出力二次函数分段数
% 初始化文件
initial_Maintenance;

%%
%导纳矩阵计算
% [Ybus, Yf, Yt] = makeYbus(baseMVA, bus, M_branch);   % build admitance matrix
[Bbus, Bf, Pbusinj, Pfinj] = makeBdc(baseMVA, bus, branch);       %直流潮流
%%
% 创建决策变量
%%
%待检修机组状态 1为正常，0为检修中
MaintGenState = binvar(n_MaintGen,n_T,'full');
%待检修线路状态 1为正常，0为检修中
MaintBranchState = binvar(n_MaintBranch,n_T,'full');

% 火电发电机出力 
gen_P = sdpvar(n_gen, n_T,'full');
gen_P_upper = sdpvar(n_gen, n_T,'full');

% 火电机组状态
u_state = binvar(n_gen, n_T,'full');    

% 电力系统各支路功率
PF_D  = sdpvar(n_branch, n_T,'full');
% 电力系统各节点相角
Va = sdpvar(n_bus,n_T,'full');

C = [];     %约束
% C = sdpvar(C)>=0;
SCUC_value = 0;

%%
%添加约束
%%
%火电机组开机费用
% Add_Huodian_Startup;
%%
%功率平衡
% Add_PowerBalance;
Add_PowerFlow;
%%
%爬坡约束
% Add_Ramp;
%%
%最小启停时间限制
% Add_MinUpDownTime;
%%
%火电机组出力
Add_Huodian_UnitOutput;
%%
%安全约束
Add_SecurityConstraints;
%%
%机组检修约束
if (n_MaintGen>0)
    Add_MaintenanceGen;
end
%%
%线路检修约束
if (n_MaintBranch>0)
    Add_MaintenanceBranch;
end
%%
%最大备用率
Add_ObjMinReserve;
%%
%检修费用
Add_ObjMaintenanceCost;
%%     
%配置 
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
%求解        
% MixObj = 1e5*ReserveObj+TotalMaintCost;       %多目标加权
% result = optimize(C);                         %可行解
% result = optimize(C, ReserveObj, ops);          %最小方差（计算时间长）
% result = optimize(C, -MinReserveRate, ops);   %最大化最小备用
result = optimize(C, TotalMaintCost, ops);    %最小费用

if result.problem == 0 % problem =0 代表求解成功   
else
    error('求解出错');
end  
% plot([1: n_T], [sum(value(gen_P(:,:)))]);
plot([1: n_T], [value(gen_P(:,:))]);            %发电机出力曲线
%%
%一些值的获取
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
%针对发电机上界为0的情况修正u_state
u_state(isnan(u_state)) = 0;

%检验
% MPC = mpc;
% MPC.gen(:, GEN_PG) = gen_P(: ,1)*baseMVA;
% MPC.bus(:, BUS_PD) = PD(:, 1)*baseMVA;
% test_result = rundcpf(MPC);
%%
%画备用率
plot(1:n_T, ReserveRate);
% ReseveRate = zeros(1,n_T);
% for t = 1: n_T
%     ReseveRate(1,t) = 1-sum(PD(:,t))/(sum(u_state(:,t).*gen(:,GEN_PMAX))/baseMVA);
% end
% plot(1:n_T,ReseveRate);

