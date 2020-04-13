mpc = feval(casename);

%%
bus = mpc.bus;
branch = mpc.branch;
gen = mpc.gen;
gencost = mpc.gencost;
PeriodLoad = mpc.PeriodLoad;
MaintGen = mpc.MaintGen;
MaintBranch = mpc.MaintBranch;
crew = mpc.crew;
baseMVA = mpc.baseMVA;

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

