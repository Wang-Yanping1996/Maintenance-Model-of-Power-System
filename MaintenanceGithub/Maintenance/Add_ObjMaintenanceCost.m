%ºÏ–ﬁ∑—”√
MaintGenCostMatrix = zeros(n_MaintGen,n_T);
MaintBranchCostMatrix = zeros(n_MaintBranch,n_T);
for i = 1: n_MaintGen
    MaintGenCostMatrix(i,:) = MaintGen(i,MAINTGEN_COST)+MaintGen(i,MAINTGEN_COSTF)*abs([1:n_T]-MaintGen(i,MAINTGEN_InitialStart));
end
for i = 1: n_MaintBranch
    MaintBranchCostMatrix(i,:) = MaintBranch(i,MAINTBR_COST)+MaintBranch(i,MAINTBR_COSTF)*abs([1:n_T]-MaintBranch(i,MAINTBR_InitialStart));
end
MaintGenCost = 0;
MaintBranchCost = 0;
for t = 1: n_T
    for i = 1: n_MaintGen
        MaintGenCost = MaintGenCost + MaintGen(i,MAINTGEN_DURATION)*MaintGenCostMatrix(i,t)*MaintGenStartFlag(i,t);
    end
    for i = 1: n_MaintBranch
        MaintBranchCost = MaintBranchCost + MaintBranch(i,MAINTBR_DURATION)*MaintBranchCostMatrix(i,t)*MaintBranchStartFlag(i,t);
    end
end
TotalMaintCost = MaintGenCost + MaintBranchCost;