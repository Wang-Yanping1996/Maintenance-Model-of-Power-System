%%
%bus表
excel_bus = xlsread(casename, 'Bus');
excel_bus(:,[1:2]) = [];
n_bus = size(excel_bus,1);
%load表
excel_load = xlsread(casename, 'Load');
excel_load(:,[1:2]) = [];
%生成matpower bus表
bus = zeros(n_bus,13);
bus(:,BUS_I) = excel_bus(:,1);
bus(:,BUS_TYPE) = excel_bus(:,2);
bus(bus(:,BUS_TYPE)==0,BUS_TYPE) = 1;
for i = 1: size(excel_load,1)
    bus(excel_load(i,2),BUS_PD) = excel_load(i,4);
    bus(excel_load(i,2),BUS_QD) = excel_load(i,5);
end
bus(:,BUS_GS) = excel_bus(:,6);
bus(:,BUS_BS) = excel_bus(:,7);
bus(:,BUS_AREA) = excel_bus(:,10);
bus(:,BUS_VM) = excel_bus(:,4);
bus(:,BUS_VA) = excel_bus(:,5);
bus(:,BUS_baseKV) = excel_bus(:,3);
bus(:,BUS_zone) = excel_bus(:,11);
bus(:,BUS_Vmax) = excel_bus(:,8);
bus(:,BUS_Vmin) = excel_bus(:,9);
%%
%branch表
excel_branch = xlsread(casename, 'Branch');
excel_branch(isnan(excel_branch)==1) = 0;
n_branch = size(excel_branch,1);
%生成matpower branch表
branch = zeros(n_branch,20);
branch(:,[F_BUS, T_BUS]) = excel_branch(:,[3:4]);
branch(:,[BR_R, BR_X, BR_B]) = excel_branch(:,[7:9]);
branch(:,[RATE_A, RATE_B, RATE_C]) = excel_branch(:,[10:12]);
branch(:,[BR_RATIO, BR_ANGLE]) = excel_branch(:,[19:20]);
branch(:,[BR_STATUS]) = excel_branch(:,[6]);
branch(:,[BR_angmin]) = -360;
branch(:,[BR_angmax]) = 360;
%%
%gen表
excel_gen = xlsread(casename, 'Generator');
n_gen = size(excel_gen,1);
%生成matpower gen gencost表
gen = zeros(n_gen, 16);
gen(:,[GEN_BUS]) = excel_gen(:,4);
gen(:,[GEN_PG,GEN_QG]) = excel_gen(:,[6:7]);
gen(:,[GEN_QMAX,GEN_QMIN]) = excel_gen(:,[10:11]);
gen(:,[GEN_STATUS]) = excel_gen(:,[5]);
gen(:,[GEN_PMAX,GEN_PMIN]) = excel_gen(:,[8:9]);


gencost = zeros(n_gen, 7);
gencost(:, GENCOST_TYPE) = 2;
gencost(:, GENCOST_N) = 3;
gencost(:, [GENCOST_C2,GENCOST_C1,GENCOST_C0]) = excel_gen(:,[21:23]);
%%
%load表
excel_PeriodLoad = xlsread(casename, 'PeriodLoad');
n_T = size(excel_PeriodLoad, 1);
PeriodLoad = excel_PeriodLoad(:,2)';
PeriodLoad = 0.75*PeriodLoad;
%%
%maintance generator
[data,text] = xlsread(casename, 'Generator Maintenance Window');
text(1,:) = [];
text = cell2mat(text);
n_MaintGen = size(data,1);
MaintGen = zeros(n_MaintGen, 12);
MaintGen(:,MAINTGEN_INDEX) = data(:,1);
for i = 1: n_MaintGen
    temp = text(i,:);
    temp = temp(3:length(temp)-1);
    MaintGen(i,MAINTGEN_NAME) = str2num(temp);
end
MaintGen(:,[MAINTGEN_ID,MAINTGEN_StartPeriod,MAINTGEN_EndPeriod,MAINTGEN_STATUS]) = data(:,[3:6]); 
MaintGen(:,[MAINTGEN_DURATION]) = excel_gen(MaintGen(:,MAINTGEN_NAME),[25]);
MaintGen(:,[MAINTGEN_COST]) = excel_gen(MaintGen(:,MAINTGEN_NAME),[19]);
%%
%maintance branch
[data,text] = xlsread(casename, 'Line Maintenance Window');
text(1,:) = [];
text = cell2mat(text);
n_MaintBranch = size(data,1);
MaintBranch = zeros(n_MaintBranch, 19);
MaintBranch(:,MAINTBR_INDEX) = data(:,1);
for i = 1: n_MaintBranch
    temp = text(i,:);
    temp = temp(3:length(temp)-1);
    MaintBranch(i,MAINTBR_NAME) = str2num(temp);
end
MaintBranch(:,[MAINTBR_FBUS,MAINTBR_TBUS,MAINTBR_ID,MAINTBR_StartPeriod,MAINTBR_EndPeriod,MAINTBR_STATUS]) = data(:,[3:8]); 
MaintBranch(:,[MAINTBR_DURATION]) = data(:,10);
MaintBranch(:,[MAINTBR_COST, MAINTBR_OutageRate, MAINTBR_OutageDuration,MAINTBR_MaxPartialMaintTimes, MAINTBR_MinPartialMaintDuration, MAINTBR_MinMaintInterval]) = excel_branch(MaintBranch(:,MAINTBR_NAME),[24:26 28:30]);

%%
%crew表
excel_crew = xlsread(casename, 'Maintenance Crew Constraint');
n_crew = size(excel_crew,1);
crew = excel_crew;
crew(:,1) = [];
%%
%baseMVA
baseMVA = 100;
%%
mpc.bus = bus;
mpc.branch = branch;
mpc.gen = gen;
mpc.gencost = gencost;
mpc.PeriodLoad = PeriodLoad;
mpc.MaintGen = MaintGen;
mpc.MaintBranch = MaintBranch;
mpc.crew = crew;
mpc.baseMVA = baseMVA;
