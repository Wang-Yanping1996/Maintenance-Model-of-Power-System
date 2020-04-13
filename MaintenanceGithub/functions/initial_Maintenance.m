%%
%一些常数 （似乎写成全局变量好一些，因为在其他函数里会用到）
%Bus type
PQ=1; PV=2; REF=3; NONE=4; 
%Bus
BUS_I=1; BUS_TYPE=2; BUS_PD=3; BUS_QD=4; BUS_GS=5; BUS_BS=6; 
BUS_AREA=7; BUS_VM=8; BUS_VA=9; BUS_baseKV=10; BUS_zone=11; BUS_Vmax=12; BUS_Vmin=13;
%Gen
GEN_BUS=1; GEN_PG=2; GEN_QG=3; GEN_QMAX=4; GEN_QMIN=5; GEN_VG=6; GEN_MBASE=7; GEN_STATUS=8; 
GEN_PMAX=9; GEN_PMIN=10; GEN_MINUP=11; GEN_MINDOWN=12; GEN_INITUP=13; GEN_INITDOWN=14; GEN_RU=15; GEN_RD=16; 
%Branch
F_BUS=1; T_BUS=2; BR_R=3; BR_X=4; BR_B=5; RATE_A=6; RATE_B=7; RATE_C=8;% standard notation (in input)
BR_RATIO=9; BR_ANGLE=10; BR_STATUS=11; BR_angmin=12; BR_angmax=13;% standard notation (in input)

%Gencost
GENCOST_TYPE=1; GENCOST_START=2; GENCOST_DOWN=3; GENCOST_N=4; GENCOST_C2=5; GENCOST_C1=6; GENCOST_C0=7;
%MaintGen
MAINTGEN_INDEX=1;MAINTGEN_NAME=2;MAINTGEN_ID=3;MAINTGEN_StartPeriod=4;MAINTGEN_EndPeriod=5;
MAINTGEN_STATUS=6;MAINTGEN_SIGN=7;MAINTGEN_DURATION=8;MAINTGEN_COST=9;
MAINTGEN_InitialStart=10;MAINTGEN_InitialEnd=11;MAINTGEN_COSTF=12;
%MaintBranch
MAINTBR_INDEX=1;MAINTBR_NAME=2;MAINTBR_FBUS=3;MAINTBR_TBUS=4;MAINTBR_ID=5;
MAINTBR_StartPeriod=6;MAINTBR_EndPeriod=7;MAINTBR_STATUS=8;MAINTBR_SIGN=9;MAINTBR_DURATION=10;
MAINTBR_COST=11; MAINTBR_OutageRate=12; MAINTBR_OutageDuration=13; 
MAINTBR_MaxPartialMaintTimes=14; MAINTBR_MinPartialMaintDuration=15; MAINTBR_MinMaintInterval=16;
MAINTBR_InitialStart=17;MAINTBR_InitialEnd=18;MAINTBR_COSTF=19;
%crew
CREW_GENN=1;CREW_GENC=2;CREW_BRN=3;CREW_BRC=4;

%%
[~,casename,ext] = fileparts(casename);
if (strcmp(ext,'.xls')||strcmp(ext,'.xlsx'))
    initial_Maintenance_excel;
elseif (strcmp(ext,'.m'))
    %matpower格式的ramp和minuptime这些数据似乎没改
    initial_Maintenance_matpower;
else
    error('文件扩展名错误');
end
%%
%数组长度
n_bus = size(bus,1);
n_branch = size(branch,1);
n_gen = size(gen,1);
n_T = size(PeriodLoad, 2);
n_MaintGen = size(MaintGen,1);
n_MaintBranch = size(MaintBranch,1);
%%
%其他处理
%负荷数据，按照IEEE数据中各节点负荷的比例分配
PD = bus(:, BUS_PD)/baseMVA;
% 24小时的负荷数据
P_factor = PD/sum(PD);
%P_sum = sum(PD)*mpc.percent;
P_sum = PeriodLoad;
PD = P_factor*P_sum;
%%
%机组发电曲线 二次函数线性化
%均匀分成n_L段
P_interval = zeros(n_gen, n_L+1);
for i = 1: n_gen
    if (gen(i,GEN_PMAX)==gen(i,GEN_PMIN))
        P_interval(i, :) = 0;
    else
        P_interval(i, :) = gen(i, GEN_PMIN): (gen(i, GEN_PMAX)-gen(i, GEN_PMIN))/n_L: gen(i, GEN_PMAX);
    end
end
%出力最小值
A_gen = gencost(:, GENCOST_C2).*gen(:,GEN_PMIN).^2 + gencost(:, GENCOST_C1).*gen(:,GEN_PMIN) + gencost(:, GENCOST_C0);
%各段斜率
Fij = zeros(n_gen, n_L);
for i = 1: n_gen
    for l = 1: n_L
        Fij(i, l) = ((gencost(i, GENCOST_C2).*P_interval(i,l+1).^2 + gencost(i, GENCOST_C1).*P_interval(i,l+1) + gencost(i, GENCOST_C0)) - ...
                     (gencost(i, GENCOST_C2).*P_interval(i,l).^2 + gencost(i, GENCOST_C1).*P_interval(i,l) + gencost(i, GENCOST_C0)))/(P_interval(i,l+1)-P_interval(i,l));
    end
end