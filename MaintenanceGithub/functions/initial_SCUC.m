%��ʼ��
mpc = feval(casename);

baseMVA = mpc.baseMVA;
bus = mpc.bus;
gen = mpc.gen;
branch = mpc.branch;
gencost = mpc.gencost;
GasBranch = mpc.GasBranch;
GasBus = mpc.GasBus;
GasSource = mpc.GasSource;
GasGen = mpc.GasGen;
HeatBranch = mpc.HeatBranch;
HeatBus = mpc.HeatBus;
SituationTempreture = mpc.SituationTempreture;
CHPgen = mpc.CHPgen;
EBoiler = mpc.EBoiler;
%%
%һЩ���� ���ƺ�д��ȫ�ֱ�����һЩ����Ϊ��������������õ���
%Bus type
PQ=1; PV=2; REF=3; NONE=4; 
%Gen type
HUODIAN=1; TIANRANQI=2; CHP=3;
%Bus
BUS_I=1; BUS_TYPE=2; BUS_PD=3; BUS_QD=4; BUS_GS=5; BUS_BS=6; 
BUS_AREA=7; BUS_VM=8; BUS_VA=9; BUS_baseKV=10; BUS_zone=11; BUS_Vmax=12; BUS_Vmin=13;
%Gen
GEN_BUS=1; GEN_PG=2; GEN_QG=3; GEN_QMAX=4; GEN_QMIN=5; GEN_VG=6; GEN_MBASE=7; GEN_STATUS=8; 
GEN_PMAX=9; GEN_PMIN=10; GEN_MINUP=11; GEN_MINDOWN=12; GEN_INITUP=13; GEN_INITDOWN=14; GEN_RU=15; GEN_RD=16; GEN_TYPE=17; 
%Branch
F_BUS=1; T_BUS=2; BR_R=3; BR_X=4; BR_B=5; RATE_A=6; RATE_B=7; RATE_C=8;% standard notation (in input)
BR_RATIO=9; BR_ANGLE=10; BR_STATUS=11; BR_angmin=12; BR_angmax=13;% standard notation (in input)
BR_COEFF = 14; BR_MINDEX = 15;
%Gencost
GENCOST_TYPE=1; GENCOST_START=2; GENCOST_DOWN=3; GENCOST_N=4; GENCOST_C2=5; GENCOST_C1=6; GENCOST_C0=7;

%HeatBus
HEATBUS_TYPE=2;
NONE=1; LOAD=2; SOURCE=3;

QLHV = 9.7*1000000/1000;
Cp = 4200/3600000/1000;  %J/(kg*C��)->MW*h/(kg*C��)
%%
% --- convert bus numbering to internal bus numbering
i2e	= bus(:, BUS_I);
e2i = zeros(max(i2e), 1);
e2i(i2e) = [1:size(bus, 1)]';
bus(:, BUS_I)	= e2i( bus(:, BUS_I)	);
gen(:, GEN_BUS)	= e2i( gen(:, GEN_BUS)	);
branch(:, F_BUS)= e2i( branch(:, F_BUS)	);
branch(:, T_BUS)= e2i( branch(:, T_BUS)	);
branch_f_bus = branch(:, F_BUS);
branch_t_bus = branch(:, T_BUS);

%%
%һЩ�õ������鳤��
n_gen = size(gen, 1);
n_bus = size(bus, 1);
n_branch = size(branch, 1);
% ʱ����t ���ڻ�������Ż�
n_T = size(mpc.load,2);
% ��������� ���κ��� �ֶ����Ի�
n_L = 20;

n_GasBus = size(GasBus,1);
n_GasBranch = size(GasBranch,1);
n_GasSource = size(GasSource,1);
n_GasGen = size(GasGen,1);

n_HeatBranch = size(HeatBranch,1);
n_HeatBus = size(HeatBus,1);
n_CHPgen = size(CHPgen,1);
n_EBoiler = size(EBoiler,1);
%%
%���������Ҫ����������
RU = gen(:, GEN_RU)/baseMVA;                         %ramp-up ������������
SU = 0.8*RU;                                         %startup ���鿪������
RD = gen(:, GEN_RD)/baseMVA;                         %ramp-down ������������
SD = 0.8*RD;                                         %shutdown ����ػ�����

min_up = gen(:, GEN_MINUP);                          %��С����ʱ��
min_down = gen(:, GEN_MINDOWN);                      %��Сͣ��ʱ��
init_up = gen(:, GEN_INITUP);                        %��ʼ����ǰ����ʱ��
init_down = gen(:, GEN_INITDOWN);                    %��ʼ����ǰͣ��ʱ��
%��ʼ����ǰÿ������״̬
init_state = zeros(n_gen, 1);
%��ʼ����ǰÿ�������й�����
init_gen_P = zeros(n_gen, 1);
for i = 1 : n_gen
    if (init_up(i) > 0 && init_down(i) == 0)    %��ʼʱ����������
        init_state(i, 1) = 1;
        init_gen_P(i, 1) = (gen(i, GEN_PMAX) + 0*gen(i, GEN_PMIN))/4/baseMVA;      %�������ʼ������Ϊ���ֵ��1/4
    elseif (init_up(i) == 0 && init_down(i) > 0)    %���鲻������
        init_state(i, 1) = 0;
    else
        error('��ʼ����ǰ����ʱ���ͣ��ʱ�����һ��Ϊ0����һ��Ϊ��');
    end
end
%���鿪������ Cmax*(1-exp(-t*TIMEDELAY))  %�ֶ�ָ������
% start_cost = (mpc.SCUC_data(:, COST_MAX)*ones(1,n_T+max(init_down))).*(1-exp(-mpc.SCUC_data(:,TIME_DELAY)*[1: n_T+max(init_down)])); 
%��������Ϊ����
start_cost = (gencost(:, GENCOST_START)*ones(1,n_T+max(init_down)));        

%���鷢������ ���κ������Ի�
%���ȷֳ�n_L��
P_interval = zeros(n_gen, n_L+1);
for i = 1: n_gen
    if (gen(i,GEN_PMAX)==gen(i,GEN_PMIN))
        P_interval(i, :) = 0;
    else
        P_interval(i, :) = gen(i, GEN_PMIN): (gen(i, GEN_PMAX)-gen(i, GEN_PMIN))/n_L: gen(i, GEN_PMAX);
    end
end
%������Сֵ
A_gen = gencost(:, GENCOST_C2).*gen(:,GEN_PMIN).^2 + gencost(:, GENCOST_C1).*gen(:,GEN_PMIN) + gencost(:, GENCOST_C0);
%����б��
Fij = zeros(n_gen, n_L);
for i = 1: n_gen
    for l = 1: n_L
        Fij(i, l) = ((gencost(i, GENCOST_C2).*P_interval(i,l+1).^2 + gencost(i, GENCOST_C1).*P_interval(i,l+1) + gencost(i, GENCOST_C0)) - ...
                     (gencost(i, GENCOST_C2).*P_interval(i,l).^2 + gencost(i, GENCOST_C1).*P_interval(i,l) + gencost(i, GENCOST_C0)))/(P_interval(i,l+1)-P_interval(i,l));
    end
end

%�������ݣ�����IEEE�����и��ڵ㸺�ɵı�������
PD = bus(:, BUS_PD)/baseMVA;
% 24Сʱ�ĸ�������
P_factor = PD/sum(PD);
%P_sum = sum(PD)*mpc.percent;
P_sum = mpc.load/baseMVA;
PD = P_factor*P_sum;
%��������¯�������¯�õ�ĸ��ɸ�Ϊ����
for i=1:n_EBoiler
    row = EBoiler(i,2);
    PD(row,:) = 0;
end
%��ת����
Spinning = mpc.spinning/baseMVA;

%%
%��Ȼ��������
GasFactor = ones(n_GasBus,1).*(1/n_GasBus);
GasD = GasFactor*mpc.GasLoad;

%%
%��������
HeatFactor = HeatBus(:,3)./sum(HeatBus(:,3));
HeatD = HeatFactor*mpc.HeatLoad;

