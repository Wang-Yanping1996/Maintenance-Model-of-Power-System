function mpc = case_RTS_GMLC
%CASE_RTS_GMLC  RTS-GMLC Test Case
%
%   Reliability Test System - Grid Modernization Lab Consortium
%
%   by Clayton Barrows, Ali Ehlen, Matt O Connell, Dheepak Krishnamurthy,
%      Brendan McBennett, and Aaron Bloom
%   National Renewable Energy Lab, Golden CO
%
%   Please see https://github.com/GridMod/RTS-GMLC for more details and/or
%   updated versions.
%
%   This version created via SAVECASE on Jan 10, 2019 from:
%     https://github.com/GridMod/RTS-GMLC/blob/master/RTS_Data/FormattedData/MATPOWER/RTS_GMLC.m
%       >> mpc = loadcase('RTS_GMLC');
%       >> mpc = toggle_dcline(mpc, 'on');
%       >> savecase('case_RTS_GMLC', mpc);
%   Manually added this help text and, in mpc.dcline data, manually deleted
%   output columns MU_PMIN-MU_QMAXT and changed values of 9999 to Inf (RDZ).

%   DATA USE DISCLAIMER AGREEMENT
%   ("Agreement")
% 
%   These data ("Data") are provided by the National Renewable Energy
%   Laboratory ("NREL"), which is operated by Alliance for Sustainable
%   Energy, LLC ("ALLIANCE") for the U.S. Department Of Energy ("DOE").
% 
%   Access to and use of these Data shall impose the following obligations
%   on the user, as set forth in this Agreement.  The user is granted the
%   right, without any fee or cost, to use, copy, and distribute these Data
%   for any purpose whatsoever, provided that this entire notice appears in
%   all copies of the Data. Further, the user agrees to credit
%   DOE/NREL/ALLIANCE in any publication that results from the use of these
%   Data.  The names DOE/NREL/ALLIANCE, however, may not be used in any
%   advertising or publicity to endorse or promote any products or
%   commercial entities unless specific written permission is obtained from
%   DOE/NREL/ ALLIANCE.  The user also understands that DOE/NREL/Alliance is
%   not obligated to provide the user with any support, consulting, training
%   or assistance of any kind with regard to the use of these Data or to
%   provide the user with any updates, revisions or new versions of these
%   Data.
% 
%   **YOU AGREE TO INDEMNIFY DOE/NREL/ALLIANCE, AND ITS SUBSIDIARIES,
%   AFFILIATES, OFFICERS, AGENTS, AND EMPLOYEES AGAINST ANY CLAIM OR DEMAND,
%   INCLUDING REASONABLE ATTORNEYS' FEES, RELATED TO YOUR USE OF THESE DATA.
%    THESE DATA ARE PROVIDED BY DOE/NREL/Alliance "AS IS" AND ANY EXPRESS OR
%   IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
%   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
%   IN NO EVENT SHALL DOE/NREL/ALLIANCE BE LIABLE FOR ANY SPECIAL, INDIRECT
%   OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER, INCLUDING BUT NOT
%   LIMITED TO CLAIMS ASSOCIATED WITH THE LOSS OF DATA OR PROFITS, WHICH MAY
%   RESULT FROM AN ACTION IN CONTRACT, NEGLIGENCE OR OTHER TORTIOUS CLAIM
%   THAT ARISES OUT OF OR IN**

%   MATPOWER

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	101	2	108	22	0	0	1	1.04777	-7.74152	138	11	1.05	0.95;
	102	2	97	20	0	0	1	1.04783	-7.81784	138	12	1.05	0.95;
	103	1	180	37	0	0	1	1.01085	-7.2109	138	11	1.05	0.95;
	104	1	74	15	0	0	1	1.01765	-10.56614	138	11	1.05	0.95;
	105	1	71	14	0	0	1	1.03568	-10.70887	138	11	1.05	0.95;
	106	1	136	28	0	-100	1	1.03242	-13.27944	138	12	1.05	0.95;
	107	2	125	25	0	0	1	1.03745	-11.27673	138	12	1.05	0.95;
	108	1	171	35	0	0	1	1.01024	-13.74967	138	12	1.05	0.95;
	109	1	175	36	0	0	1	1.0261	-8.81524	138	13	1.05	0.95;
	110	1	195	40	0	0	1	1.05	-10.62063	138	13	1.05	0.95;
	111	1	0	0	0	0	1	1.02764	-3.91674	230	13	1.05	0.95;
	112	1	0	0	0	0	1	1.02024	-2.42424	230	13	1.05	0.95;
	113	3	265	54	0	0	1	1.03943	0	230	14	1.05	0.95;
	114	2	194	39	0	0	1	1.04401	-1.73056	230	16	1.05	0.95;
	115	2	317	64	0	0	1	1.04335	7.9597	230	16	1.05	0.95;
	116	2	100	20	0	0	1	1.04565	7.56929	230	16	1.05	0.95;
	117	1	0	0	0	0	1	1.04783	11.43417	230	17	1.05	0.95;
	118	2	333	68	0	0	1	1.05	12.52457	230	17	1.05	0.95;
	119	1	181	37	0	0	1	1.03962	6.65777	230	15	1.05	0.95;
	120	1	128	26	0	0	1	1.04399	7.7406	230	15	1.05	0.95;
	121	2	0	0	0	0	1	1.05	13.08653	230	17	1.05	0.95;
	122	2	0	0	0	0	1	1.05	18.94978	230	17	1.05	0.95;
	123	2	0	0	0	0	1	1.05	9.05617	230	15	1.05	0.95;
	124	1	0	0	0	0	1	1.01155	2.38339	230	16	1.05	0.95;
	201	2	108	22	0	0	2	1.04841	-10.68973	138	21	1.05	0.95;
	202	2	97	20	0	0	2	1.04844	-10.75906	138	22	1.05	0.95;
	203	1	180	37	0	0	2	1.01886	-10.47453	138	21	1.05	0.95;
	204	1	74	15	0	0	2	1.0189	-13.48479	138	21	1.05	0.95;
	205	1	71	14	0	0	2	1.03603	-13.61187	138	21	1.05	0.95;
	206	1	136	28	0	-100	2	1.03259	-16.15672	138	22	1.05	0.95;
	207	2	125	25	0	0	2	1.03973	-13.46606	138	22	1.05	0.95;
	208	1	171	35	0	0	2	1.01203	-16.22359	138	22	1.05	0.95;
	209	1	175	36	0	0	2	1.02781	-11.72409	138	23	1.05	0.95;
	210	1	195	40	0	0	2	1.05	-13.47986	138	23	1.05	0.95;
	211	1	0	0	0	0	2	1.02735	-6.93336	230	23	1.05	0.95;
	212	1	0	0	0	0	2	1.01921	-5.25334	230	23	1.05	0.95;
	213	2	265	54	0	0	2	1.03752	-3.2151	230	24	1.05	0.95;
	214	2	194	39	0	0	2	1.04335	-4.68519	230	26	1.05	0.95;
	215	2	317	64	0	0	2	1.04327	4.63351	230	26	1.05	0.95;
	216	2	100	20	0	0	2	1.04556	4.70009	230	26	1.05	0.95;
	217	1	0	0	0	0	2	1.04847	8.81839	230	27	1.05	0.95;
	218	2	333	68	0	0	2	1.05	9.99473	230	27	1.05	0.95;
	219	1	181	37	0	0	2	1.03946	4.21233	230	25	1.05	0.95;
	220	1	128	26	0	0	2	1.0438	5.66449	230	25	1.05	0.95;
	221	2	0	0	0	0	2	1.05	10.63209	230	27	1.05	0.95;
	222	2	0	0	0	0	2	1.05	16.43203	230	27	1.05	0.95;
	223	2	0	0	0	0	2	1.05	7.18151	230	25	1.05	0.95;
	224	1	0	0	0	0	2	1.01456	-0.96005	230	26	1.05	0.95;
	301	2	108	22	0	0	3	1.0486	-9.34821	138	31	1.05	0.95;
	302	2	97	20	0	0	3	1.04864	-9.431	138	32	1.05	0.95;
	303	1	180	37	0	0	3	1.01045	-8.57689	138	31	1.05	0.95;
	304	1	74	15	0	0	3	1.01785	-12.18784	138	31	1.05	0.95;
	305	1	71	14	0	0	3	1.03609	-12.35005	138	31	1.05	0.95;
	306	1	136	28	0	-100	3	1.0326	-14.94205	138	32	1.05	0.95;
	307	2	125	25	0	0	3	1.03804	-12.54795	138	32	1.05	0.95;
	308	1	171	35	0	0	3	1.01056	-15.18287	138	32	1.05	0.95;
	309	1	175	36	0	0	3	1.02579	-10.44617	138	33	1.05	0.95;
	310	1	195	40	0	0	3	1.05	-12.30117	138	33	1.05	0.95;
	311	1	0	0	0	0	3	1.0283	-5.74069	230	33	1.05	0.95;
	312	1	0	0	0	0	3	1.019	-4.14604	230	33	1.05	0.95;
	313	2	265	54	0	0	3	1.03802	-2.41513	230	34	1.05	0.95;
	314	2	194	39	0	0	3	1.04631	-3.20793	230	36	1.05	0.95;
	315	2	317	64	0	0	3	1.043	7.05088	230	36	1.05	0.95;
	316	2	100	20	0	0	3	1.04558	6.59875	230	36	1.05	0.95;
	317	1	0	0	0	0	3	1.04785	10.34418	230	37	1.05	0.95;
	318	2	333	68	0	0	3	1.05	11.34262	230	37	1.05	0.95;
	319	1	181	37	0	0	3	1.03953	5.91539	230	35	1.05	0.95;
	320	1	128	26	0	0	3	1.04389	7.19709	230	35	1.05	0.95;
	321	2	0	0	0	0	3	1.05	12.34122	230	37	1.05	0.95;
	322	2	0	0	0	0	3	1.05	18.06914	230	37	1.05	0.95;
	323	2	0	0	0	0	3	1.05	8.62112	230	35	1.05	0.95;
	324	1	0	0	0	0	3	1.01046	1.30606	230	36	1.05	0.95;
	325	1	0	0	0	0	3	1.04986	8.99332	230	35	1.05	0.95;
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	101	8	4.96	10	0	1.0468	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	101	8	4.96	10	0	1.0468	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	101	76	0.14	30	-25	1.0468	100	1	76	30	0	0	0	0	0	0	2	2	2	2	0;
	101	76	0.14	30	-25	1.0468	100	1	76	30	0	0	0	0	0	0	2	2	2	2	0;
	102	8	4.88	10	0	1.0467	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	102	8	4.88	10	0	1.0467	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	102	76	-2.31	30	-25	1.0467	100	1	76	30	0	0	0	0	0	0	2	2	2	2	0;
	102	76	-2.31	30	-25	1.0467	100	1	76	30	0	0	0	0	0	0	2	2	2	2	0;
	107	355	49.51	150	-25	1.05	100	1	355	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;
	113	55	19	19	-15	1.0347	100	1	197	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;      %Pmax改为197
	113	55	19	19	-15	1.0347	100	1	197	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;      %Pmax改为197
	113	55	19	19	-15	1.0347	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;      
	113	55	19	19	-15	1.0347	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	115	5	6	6	0	1.0428	100	1	12	5	0	0	0	0	0	0	1	1	1	1	0;
	115	5	6	6	0	1.0428	100	1	12	5	0	0	0	0	0	0	1	1	1	1	0;
	115	155	80	80	-50	1.0428	100	1	155	62	0	0	0	0	0	0	3	3	3	3	0;
	116	155	80	80	-50	1.0461	100	1	155	62	0	0	0	0	0	0	3	3	3	3	0;
	118	355	68.43	150	-25	1.05	100	1	400	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;  %Pmax改为400
	123	155	-5.19	80	-50	1.05	100	1	155	62	0	0	0	0	0	0	3	3	3	3	0;
	123	350	28.41	150	-25	1.05	100	1	350	140	0	0	0	0	0	0	4	4	4	4	0;
	123	55	0.62	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	123	55	0.62	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	123	55	0.62	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	201	8	5.29	10	0	1.05	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	201	8	5.29	10	0	1.05	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	201	76	6.99	30	-25	1.05	100	1	76	30	0	0	0	0	0	0	2	2	2	2	0;
	202	8	5.13	10	0	1.05	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	202	8	5.13	10	0	1.05	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	202	76	2.01	30	-25	1.05	100	1	76	30	0	0	0	0	0	0	2	2	2	2	0;
	202	76	2.01	30	-25	1.05	100	1	76	30	0	0	0	0	0	0	2	2	2	2	0;
	207	55	19	19	-15	0.9699	100	1	100	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;      %Pmax改为100
	207	55	19	19	-15	0.9699	100	1	100	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;      %Pmax改为100
	213	355	135.8	150	-25	1.05	100	1	355	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;
	213	55	9.23	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	213	55	9.23	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	215	55	19	19	-15	1.0437	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	215	55	19	19	-15	1.0437	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	216	155	80	80	-50	1.0473	100	1	155	62	0	0	0	0	0	0	3	3	3	3	0;
	218	355	60.3	150	-25	1.05	100	1	355	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;
	221	296.97	-7.52	150	-25	1.05	100	1	355	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;
	223	155	-10.31	80	-50	1.05	100	1	155	62	0	0	0	0	0	0	3	3	3	3	0;
	223	155	-10.31	80	-50	1.05	100	1	155	62	0	0	0	0	0	0	3	3	3	3	0;
	223	350	20.59	150	-25	1.05	100	1	350	140	0	0	0	0	0	0	4	4	4	4	0;
	223	22	0.24	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	223	22	0.24	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	223	22	0.24	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	301	8	7.95	10	0	1.05	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	301	8	7.95	10	0	1.05	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	301	44	16.53	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	301	44	16.53	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	302	8	6.16	10	0	1.05	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	302	8	6.16	10	0	1.05	100	1	20	8	0	0	0	0	0	0	3	3	3	3	0;
	302	55	10.99	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	302	55	10.99	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	307	55	19	19	-15	0.9568	100	1	100	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;  %Pmax改为100
	307	55	19	19	-15	0.9568	100	1	100	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;  %Pmax改为100
	313	355	150	150	-25	1.035	100	1	355	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;
	315	5	6	6	0	1.0422	100	1	12	5	0	0	0	0	0	0	1	1	1	1	0;
	315	5	6	6	0	1.0422	100	1	12	5	0	0	0	0	0	0	1	1	1	1	0;
	315	5	6	6	0	1.0422	100	1	12	5	0	0	0	0	0	0	1	1	1	1	0;
	315	5	6	6	0	1.0422	100	1	12	5	0	0	0	0	0	0	1	1	1	1	0;
	315	5	6	6	0	1.0422	100	1	12	5	0	0	0	0	0	0	1	1	1	1	0;
	315	55	19	19	-15	1.0422	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	315	55	19	19	-15	1.0422	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	315	55	60	60	0	1.0422	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	316	155	80	80	-50	1.0449	100	1	155	62	0	0	0	0	0	0	3	3	3	3	0;
	318	355	63.12	150	-25	1.05	100	1	355	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;
	321	355	-3.34	150	-25	1.05	100	1	355	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;
	322	55	-9.73	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	322	55	-9.73	19	-15	1.05	100	1	55	22	0	0	0	0	0	0	3.7	3.7	3.7	3.7	0;
	323	355	37.41	150	-25	1.05	100	1	350	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;  %Pmax改为350
	323	355	37.41	150	-25	1.05	100	1	355	170	0	0	0	0	0	0	4.14	4.14	4.14	4.14	0;
	114	0	103.32	200	-50	1.0441	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;
	121	400	-21.87	200	-50	1.05	100	1	400	396	0	0	0	0	0	0	20	20	20	20	0;
	122	50	-6.79	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	122	50	-6.79	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	122	50	-6.79	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	122	50	-6.79	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	122	50	-6.79	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	122	50	-6.79	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	201	50	4.15	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	214	0	125.28	200	-50	1.05	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;
	215	50	16	16	-10	1.0437	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	215	50	16	16	-10	1.0437	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	215	50	16	16	-10	1.0437	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	222	50	-6.97	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	222	50	-6.97	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	222	50	-6.97	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	222	50	-6.97	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	222	50	-6.97	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	222	50	-6.97	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	314	0	166.63	200	-50	1.05	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;
	322	50	-5.13	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	322	50	-5.13	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	322	50	-5.13	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	322	50	-5.13	16	-10	1.05	100	1	50	0	0	0	0	0	0	0	50	50	50	50	0;
	320	0	0	0	0	1	100	0	51.6	0	0	0	0	0	0	0	51.6	51.6	51.6	51.6	0;
	314	0	0	0	0	1	100	0	51.6	0	0	0	0	0	0	0	51.6	51.6	51.6	51.6	0;
	314	0	0	0	0	1	100	0	51.6	0	0	0	0	0	0	0	51.6	51.6	51.6	51.6	0;
	313	0	0	0	0	1	100	0	95.1	0	0	0	0	0	0	0	95.1	95.1	95.1	95.1	0;
	314	0	0	0	0	1	100	0	92.7	0	0	0	0	0	0	0	92.7	92.7	92.7	92.7	0;
	314	0	0	0	0	1	100	0	51.6	0	0	0	0	0	0	0	51.6	51.6	51.6	51.6	0;
	313	0	0	0	0	1	100	0	93.3	0	0	0	0	0	0	0	93.3	93.3	93.3	93.3	0;
	310	0	0	0	0	1	100	0	51.7	0	0	0	0	0	0	0	51.7	51.7	51.7	51.7	0;
	324	0	0	0	0	1	100	0	49.7	0	0	0	0	0	0	0	49.7	49.7	49.7	49.7	0;
	312	0	0	0	0	1	100	0	94.1	0	0	0	0	0	0	0	94.1	94.1	94.1	94.1	0;
	310	0	0	0	0	1	100	0	51.6	0	0	0	0	0	0	0	51.6	51.6	51.6	51.6	0;
	324	0	0	0	0	1	100	0	51.6	0	0	0	0	0	0	0	51.6	51.6	51.6	51.6	0;
	324	0	0	0	0	1	100	0	51	0	0	0	0	0	0	0	51	51	51	51	0;
	113	0	0	0	0	1	100	0	93.6	0	0	0	0	0	0	0	93.6	93.6	93.6	93.6	0;
	319	0	0	0	0	1	100	0	188.2	0	0	0	0	0	0	0	188.2	188.2	188.2	188.2	0;
	215	0	0	0	0	1	100	0	125.1	0	0	0	0	0	0	0	125.1	125.1	125.1	125.1	0;
	102	0	0	0	0	1	100	0	25.6	0	0	0	0	0	0	0	25.6	25.6	25.6	25.6	0;
	101	0	0	0	0	1	100	0	25.9	0	0	0	0	0	0	0	25.9	25.9	25.9	25.9	0;
	102	0	0	0	0	1	100	0	25.3	0	0	0	0	0	0	0	25.3	25.3	25.3	25.3	0;
	104	0	0	0	0	1	100	0	26.8	0	0	0	0	0	0	0	26.8	26.8	26.8	26.8	0;
	212	0	0	0	0	1	100	0	200	30	0	0	0	0	0	0	20	20	20	20	0;
	101	0	0	0	0	1	100	0	26.7	0	0	0	0	0	0	0	26.7	26.7	26.7	26.7	0;
	101	0	0	0	0	1	100	0	26.2	0	0	0	0	0	0	0	26.2	26.2	26.2	26.2	0;
	101	0	0	0	0	1	100	0	25.8	0	0	0	0	0	0	0	25.8	25.8	25.8	25.8	0;
	103	0	0	0	0	1	100	0	61.5	0	0	0	0	0	0	0	61.5	61.5	61.5	61.5	0;
	119	0	0	0	0	1	100	0	66.6	0	0	0	0	0	0	0	66.6	66.6	66.6	66.6	0;
	308	0	0	0	0	1	100	0	100.9	0	0	0	0	0	0	0	100.9	100.9	100.9	100.9	0;
	313	0	0	0	0	1	100	0	101.7	0	0	0	0	0	0	0	101.7	101.7	101.7	101.7	0;
	313	0	0	0	0	1	100	0	63.1	0	0	0	0	0	0	0	63.1	63.1	63.1	63.1	0;
	313	0	0	0	0	1	100	0	65.4	0	0	0	0	0	0	0	65.4	65.4	65.4	65.4	0;
	313	0	0	0	0	1	100	0	67	0	0	0	0	0	0	0	67	67	67	67	0;
	313	0	0	0	0	1	100	0	64.8	0	0	0	0	0	0	0	64.8	64.8	64.8	64.8	0;
	313	0	0	0	0	1	100	0	63.8	0	0	0	0	0	0	0	63.8	63.8	63.8	63.8	0;
	313	0	0	0	0	1	100	0	64.1	0	0	0	0	0	0	0	64.1	64.1	64.1	64.1	0;
	313	0	0	0	0	1	100	0	66.6	0	0	0	0	0	0	0	66.6	66.6	66.6	66.6	0;
	313	0	0	0	0	1	100	0	62.4	0	0	0	0	0	0	0	62.4	62.4	62.4	62.4	0;
	313	0	0	0	0	1	100	0	66.9	0	0	0	0	0	0	0	66.9	66.9	66.9	66.9	0;
	313	0	0	0	0	1	100	0	65.2	0	0	0	0	0	0	0	65.2	65.2	65.2	65.2	0;
	313	0	0	0	0	1	100	0	27.8	0	0	0	0	0	0	0	27.8	27.8	27.8	27.8	0;
	320	0	0	0	0	1	100	0	27.3	0	0	0	0	0	0	0	27.3	27.3	27.3	27.3	0;
	320	0	0	0	0	1	100	0	27	0	0	0	0	0	0	0	27	27	27	27	0;
	320	0	0	0	0	1	100	0	28.3	0	0	0	0	0	0	0	28.3	28.3	28.3	28.3	0;
	313	0	0	0	0	1	100	0	27.2	0	0	0	0	0	0	0	27.2	27.2	27.2	27.2	0;
	320	0	0	0	0	1	100	0	27	0	0	0	0	0	0	0	27	27	27	27	0;
	320	0	0	0	0	1	100	0	28.2	0	0	0	0	0	0	0	28.2	28.2	28.2	28.2	0;
	118	0	0	0	0	1	100	0	9.3	0	0	0	0	0	0	0	9.3	9.3	9.3	9.3	0;
	118	0	0	0	0	1	100	0	9.7	0	0	0	0	0	0	0	9.7	9.7	9.7	9.7	0;
	118	0	0	0	0	1	100	0	9.4	0	0	0	0	0	0	0	9.4	9.4	9.4	9.4	0;
	118	0	0	0	0	1	100	0	9.1	0	0	0	0	0	0	0	9.1	9.1	9.1	9.1	0;
	118	0	0	0	0	1	100	0	9.1	0	0	0	0	0	0	0	9.1	9.1	9.1	9.1	0;
	118	0	0	0	0	1	100	0	9.7	0	0	0	0	0	0	0	9.7	9.7	9.7	9.7	0;
	320	0	0	0	0	1	100	0	9.4	0	0	0	0	0	0	0	9.4	9.4	9.4	9.4	0;
	118	0	0	0	0	1	100	0	11.8	0	0	0	0	0	0	0	11.8	11.8	11.8	11.8	0;
	118	0	0	0	0	1	100	0	11.2	0	0	0	0	0	0	0	11.2	11.2	11.2	11.2	0;
	118	0	0	0	0	1	100	0	10.3	0	0	0	0	0	0	0	10.3	10.3	10.3	10.3	0;
	118	0	0	0	0	1	100	0	4.5	0	0	0	0	0	0	0	4.5	4.5	4.5	4.5	0;
	213	0	0	0	0	1	100	0	13.2	0	0	0	0	0	0	0	13.2	13.2	13.2	13.2	0;
	309	0	0	0	0	1	100	0	148.3	0	0	0	0	0	0	0	148.3	148.3	148.3	148.3	0;
	317	0	0	0	0	1	100	0	799.1	0	0	0	0	0	0	0	799.1	799.1	799.1	799.1	0;
	303	0	0	0	0	1	100	0	847	0	0	0	0	0	0	0	847	847	847	847	0;
	122	0	0	0	0	1	100	0	713.5	0	0	0	0	0	0	0	713.5	713.5	713.5	713.5	0;
	313	0	0	0	0	1	100	0	50	0	0	0	0	0	0	0	50	50	50	50	0;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
	101	102	0.003	0.014	0.461	175	175	175	0	0	1	-180	180;
	101	103	0.055	0.211	0.057	175	175	175	0	0	1	-180	180;
	101	105	0.022	0.085	0.023	175	175	175	0	0	1	-180	180;
	102	104	0.033	0.127	0.034	175	175	175	0	0	1	-180	180;
	102	106	0.05	0.192	0.052	175	175	175	0	0	1	-180	180;
	103	109	0.031	0.119	0.032	175	175	175	0	0	1	-180	180;
	103	124	0.002	0.084	0	400	400	400	1.015	0	1	-180	180;
	104	109	0.027	0.104	0.028	175	175	175	0	0	1	-180	180;
	105	110	0.023	0.088	0.024	175	175	175	0	0	1	-180	180;
	106	110	0.014	0.061	2.459	175	175	175	0	0	1	-180	180;
	107	108	0.016	0.061	0.017	175	175	175	0	0	1	-180	180;
	107	203	0.042	0.161	0.044	175	175	175	0	0	1	-180	180;
	108	109	0.043	0.165	0.045	175	175	175	0	0	1	-180	180;
	108	110	0.043	0.165	0.045	175	175	175	0	0	1	-180	180;
	109	111	0.002	0.084	0	400	400	400	1.03	0	1	-180	180;
	109	112	0.002	0.084	0	400	400	400	1.03	0	1	-180	180;
	110	111	0.002	0.084	0	400	400	400	1.015	0	1	-180	180;
	110	112	0.002	0.084	0	400	400	400	1.015	0	1	-180	180;
	111	113	0.006	0.048	0.1	500	500	500	0	0	1	-180	180;
	111	114	0.005	0.042	0.088	500	500	500	0	0	1	-180	180;
	112	113	0.006	0.048	0.1	500	500	500	0	0	1	-180	180;
	112	123	0.012	0.097	0.203	500	500	500	0	0	1	-180	180;
	113	123	0.011	0.087	0.182	500	500	500	0	0	1	-180	180;
	113	215	0.01	0.075	0.158	500	500	500	0	0	1	-180	180;
	114	116	0.005	0.059	0.082	500	500	500	0	0	1	-180	180;
	115	116	0.002	0.017	0.036	500	500	500	0	0	1	-180	180;
	115	121	0.006	0.049	0.103	500	500	500	0	0	1	-180	180;
	115	121	0.006	0.049	0.103	500	500	500	0	0	1	-180	180;
	115	124	0.007	0.052	0.109	500	500	500	0	0	1	-180	180;
	116	117	0.003	0.026	0.055	500	500	500	0	0	1	-180	180;
	116	119	0.003	0.023	0.049	500	500	500	0	0	1	-180	180;
	117	118	0.002	0.014	0.03	500	500	500	0	0	1	-180	180;
	117	122	0.014	0.105	0.221	500	500	500	0	0	1	-180	180;
	118	121	0.003	0.026	0.055	500	500	500	0	0	1	-180	180;
	118	121	0.003	0.026	0.055	500	500	500	0	0	1	-180	180;
	119	120	0.005	0.04	0.083	500	500	500	0	0	1	-180	180;
	119	120	0.005	0.04	0.083	500	500	500	0	0	1	-180	180;
	120	123	0.003	0.022	0.046	500	500	500	0	0	1	-180	180;
	120	123	0.003	0.022	0.046	500	500	500	0	0	1	-180	180;
	121	122	0.009	0.068	0.142	500	500	500	0	0	1	-180	180;
	123	217	0.01	0.074	0.155	500	500	500	0	0	1	-180	180;
	201	202	0.003	0.014	0.461	175	175	175	0	0	1	-180	180;
	201	203	0.055	0.211	0.057	175	175	175	0	0	1	-180	180;
	201	205	0.022	0.085	0.023	175	175	175	0	0	1	-180	180;
	202	204	0.033	0.127	0.034	175	175	175	0	0	1	-180	180;
	202	206	0.05	0.192	0.052	175	175	175	0	0	1	-180	180;
	203	209	0.031	0.119	0.032	175	175	175	0	0	1	-180	180;
	203	224	0.002	0.084	0	400	400	400	1.015	0	1	-180	180;
	204	209	0.027	0.104	0.028	175	175	175	0	0	1	-180	180;
	205	210	0.023	0.088	0.024	175	175	175	0	0	1	-180	180;
	206	210	0.014	0.061	2.459	175	175	175	0	0	1	-180	180;
	207	208	0.016	0.061	0.017	175	175	175	0	0	1	-180	180;
	208	209	0.043	0.165	0.045	175	175	175	0	0	1	-180	180;
	208	210	0.043	0.165	0.045	175	175	175	0	0	1	-180	180;
	209	211	0.002	0.084	0	400	400	400	1.03	0	1	-180	180;
	209	212	0.002	0.084	0	400	400	400	1.03	0	1	-180	180;
	210	211	0.002	0.084	0	400	400	400	1.015	0	1	-180	180;
	210	212	0.002	0.084	0	400	400	400	1.015	0	1	-180	180;
	211	213	0.006	0.048	0.1	500	500	500	0	0	1	-180	180;
	211	214	0.005	0.042	0.088	500	500	500	0	0	1	-180	180;
	212	213	0.006	0.048	0.1	500	500	500	0	0	1	-180	180;
	212	223	0.012	0.097	0.203	500	500	500	0	0	1	-180	180;
	213	223	0.011	0.087	0.182	500	500	500	0	0	1	-180	180;
	214	216	0.005	0.059	0.082	500	500	500	0	0	1	-180	180;
	215	216	0.002	0.017	0.036	500	500	500	0	0	1	-180	180;
	215	221	0.006	0.049	0.103	500	500	500	0	0	1	-180	180;
	215	221	0.006	0.049	0.103	500	500	500	0	0	1	-180	180;
	215	224	0.007	0.052	0.109	500	500	500	0	0	1	-180	180;
	216	217	0.003	0.026	0.055	500	500	500	0	0	1	-180	180;
	216	219	0.003	0.023	0.049	500	500	500	0	0	1	-180	180;
	217	218	0.002	0.014	0.03	500	500	500	0	0	1	-180	180;
	217	222	0.014	0.105	0.221	500	500	500	0	0	1	-180	180;
	218	221	0.003	0.026	0.055	500	500	500	0	0	1	-180	180;
	218	221	0.003	0.026	0.055	500	500	500	0	0	1	-180	180;
	219	220	0.005	0.04	0.083	500	500	500	0	0	1	-180	180;
	219	220	0.005	0.04	0.083	500	500	500	0	0	1	-180	180;
	220	223	0.003	0.022	0.046	500	500	500	0	0	1	-180	180;
	220	223	0.003	0.022	0.046	500	500	500	0	0	1	-180	180;
	221	222	0.009	0.068	0.142	500	500	500	0	0	1	-180	180;
	301	302	0.003	0.014	0.461	175	175	175	0	0	1	-180	180;
	301	303	0.055	0.211	0.057	175	175	175	0	0	1	-180	180;
	301	305	0.022	0.085	0.023	175	175	175	0	0	1	-180	180;
	302	304	0.033	0.127	0.034	175	175	175	0	0	1	-180	180;
	302	306	0.05	0.192	0.052	175	175	175	0	0	1	-180	180;
	303	309	0.031	0.119	0.032	175	175	175	0	0	1	-180	180;
	303	324	0.002	0.084	0	400	400	400	1.015	0	1	-180	180;
	304	309	0.027	0.104	0.028	175	175	175	0	0	1	-180	180;
	305	310	0.023	0.088	0.024	175	175	175	0	0	1	-180	180;
	306	310	0.014	0.061	2.459	175	175	175	0	0	1	-180	180;
	307	308	0.016	0.061	0.017	175	175	175	0	0	1	-180	180;
	308	309	0.043	0.165	0.045	175	175	175	0	0	1	-180	180;
	308	310	0.043	0.165	0.045	175	175	175	0	0	1	-180	180;
	309	311	0.002	0.084	0	400	400	400	1.03	0	1	-180	180;
	309	312	0.002	0.084	0	400	400	400	1.03	0	1	-180	180;
	310	311	0.002	0.084	0	400	400	400	1.015	0	1	-180	180;
	310	312	0.002	0.084	0	400	400	400	1.015	0	1	-180	180;
	311	313	0.006	0.048	0.1	500	500	500	0	0	1	-180	180;
	311	314	0.005	0.042	0.088	500	500	500	0	0	1	-180	180;
	312	313	0.006	0.048	0.1	500	500	500	0	0	1	-180	180;
	312	323	0.012	0.097	0.203	500	500	500	0	0	1	-180	180;
	313	323	0.011	0.087	0.182	500	500	500	0	0	1	-180	180;
	314	316	0.005	0.059	0.082	500	500	500	0	0	1	-180	180;
	315	316	0.002	0.017	0.036	500	500	500	0	0	1	-180	180;
	315	321	0.006	0.049	0.103	500	500	500	0	0	1	-180	180;
	315	321	0.006	0.049	0.103	500	500	500	0	0	1	-180	180;
	315	324	0.007	0.052	0.109	500	500	500	0	0	1	-180	180;
	316	317	0.003	0.026	0.055	500	500	500	0	0	1	-180	180;
	316	319	0.003	0.023	0.049	500	500	500	0	0	1	-180	180;
	317	318	0.002	0.014	0.03	500	500	500	0	0	1	-180	180;
	317	322	0.014	0.105	0.221	500	500	500	0	0	1	-180	180;
	318	321	0.003	0.026	0.055	500	500	500	0	0	1	-180	180;
	318	321	0.003	0.026	0.055	500	500	500	0	0	1	-180	180;
	319	320	0.005	0.04	0.083	500	500	500	0	0	1	-180	180;
	319	320	0.005	0.04	0.083	500	500	500	0	0	1	-180	180;
	320	323	0.003	0.022	0.046	500	500	500	0	0	1	-180	180;
	320	323	0.003	0.022	0.046	500	500	500	0	0	1	-180	180;
	321	322	0.009	0.068	0.142	500	500	500	0	0	1	-180	180;
	325	121	0.012	0.097	0.203	500	500	500	0	0	1	-180	180;
	318	223	0.013	0.104	0.218	500	500	500	0	0	1	-180	180;
	323	325	0	0.009	0	722	722	722	1	0	1	-180	180;
];

%%-----  OPF Data  -----%%
%% area data
%	area	refbus
mpc.areas = [
	1	101;
	2	201;
	3	301;
];

%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	1	51.747	51.747	4	8	1085.77625	12	1477.23196	16	1869.51562	20	2298.06357;
	1	51.747	51.747	4	8	1085.77625	12	1477.23196	16	1869.51562	20	2298.06357;
	1	11172.0143	11172.0143	4	30	841.57942	45.33333	1059.17805	60.66667	1319.40176	76	1596.51343;
	1	11172.0143	11172.0143	4	30	841.57942	45.33333	1059.17805	60.66667	1319.40176	76	1596.51343;
	1	51.747	51.747	4	8	1212.03893	12	1567.9341	16	1946.59795	20	2344.92565;
	1	51.747	51.747	4	8	1212.03893	12	1567.9341	16	1946.59795	20	2344.92565;
	1	11172.0143	11172.0143	4	30	735.09774	45.33333	1018.2061	60.66667	1337.84562	76	1683.0926;
	1	11172.0143	11172.0143	4	30	735.09774	45.33333	1018.2061	60.66667	1337.84562	76	1683.0926;
	1	28046.681	28046.681	4	170	4772.49548	231.66667	6203.57553	293.33333	7855.66994	355	9738.3672;
	1	5665.23443	5665.23443	4	22	1122.43477	33	1417.43201	44	1742.48912	55	2075.88432;
	1	5665.23443	5665.23443	4	22	1122.43477	33	1417.43201	44	1742.48912	55	2075.88432;
	1	5665.23443	5665.23443	4	22	1122.43477	33	1417.43201	44	1742.48912	55	2075.88432;
	1	5665.23443	5665.23443	4	22	1122.43477	33	1417.43201	44	1742.48912	55	2075.88432;
	1	703.7592	703.7592	4	5	897.29298	7.33333	1187.80064	9.66667	1479.58817	12	1791.41904;
	1	703.7592	703.7592	4	5	897.29298	7.33333	1187.80064	9.66667	1479.58817	12	1791.41904;
	1	22784.7956	22784.7956	4	62	1500.19723	93	2132.59734	124	2829.8758	155	3668.4449;
	1	22784.7956	22784.7956	4	62	1735.06998	93	2345.3197	124	3011.01092	155	3751.14842;
	1	28046.681	28046.681	4	170	4795.62444	231.66667	6187.87116	293.33333	7899.41412	355	9901.2482;
	1	22784.7956	22784.7956	4	62	1437.41596	93	2039.7361	124	2751.75964	155	3775.85462;
	1	36749.8136	36749.8136	4	140	3582.87481	210	4981.72313	280	6497.03117	350	8137.67767;
	1	5665.23443	5665.23443	4	22	1088.22724	33	1377.15264	44	1704.98911	55	2046.97895;
	1	5665.23443	5665.23443	4	22	1088.22724	33	1377.15264	44	1704.98911	55	2046.97895;
	1	5665.23443	5665.23443	4	22	1088.22724	33	1377.15264	44	1704.98911	55	2046.97895;
	1	51.747	51.747	4	8	1157.22851	12	1487.12598	16	1822.73633	20	2269.08525;
	1	51.747	51.747	4	8	1157.22851	12	1487.12598	16	1822.73633	20	2269.08525;
	1	11172.0143	11172.0143	4	30	823.75848	45.33333	1163.9488	60.66667	1523.42575	76	1918.3966;
	1	51.747	51.747	4	8	1131.23082	12	1455.62241	16	1805.10095	20	2196.47386;
	1	51.747	51.747	4	8	1131.23082	12	1455.62241	16	1805.10095	20	2196.47386;
	1	11172.0143	11172.0143	4	30	751.26977	45.33333	1075.05834	60.66667	1401.47249	76	1819.68454;
	1	11172.0143	11172.0143	4	30	751.26977	45.33333	1075.05834	60.66667	1401.47249	76	1819.68454;
	1	5665.23443	5665.23443	4	22	1116.10638	33	1492.56031	44	1897.96238	55	2366.39182;
	1	5665.23443	5665.23443	4	22	1116.10638	33	1492.56031	44	1897.96238	55	2366.39182;
	1	28046.681	28046.681	4	170	5170.31357	231.66667	6688.64875	293.33333	8361.5981	355	10458.8375;
	1	5665.23443	5665.23443	4	22	1122.43477	33	1417.43201	44	1742.48912	55	2075.88432;
	1	5665.23443	5665.23443	4	22	1122.43477	33	1417.43201	44	1742.48912	55	2075.88432;
	1	5665.23443	5665.23443	4	22	1216.84757	33	1501.96739	44	1800.72745	55	2160.80453;
	1	5665.23443	5665.23443	4	22	1216.84757	33	1501.96739	44	1800.72745	55	2160.80453;
	1	22784.7956	22784.7956	4	62	1426.14416	93	2001.92316	124	2679.08278	155	3412.47031;
	1	28046.681	28046.681	4	170	7523.51994	231.66667	8815.08767	293.33333	10151.4815	355	11987.1952;
	1	28046.681	28046.681	4	170	4551.1183	231.66667	5977.40411	293.33333	7600.7331	355	9828.37578;
	1	22784.7956	22784.7956	4	62	1422.99854	93	2013.06389	124	2623.44468	155	3256.43459;
	1	22784.7956	22784.7956	4	62	1422.99854	93	2013.06389	124	2623.44468	155	3256.43459;
	1	36749.8136	36749.8136	4	140	3323.31912	210	4643.59043	280	6258.48853	350	7981.70748;
	1	5665.23443	5665.23443	4	22	1692.75992	33	2103.03655	44	2540.25162	55	2996.75119;
	1	5665.23443	5665.23443	4	22	1692.75992	33	2103.03655	44	2540.25162	55	2996.75119;
	1	5665.23443	5665.23443	4	22	1692.75992	33	2103.03655	44	2540.25162	55	2996.75119;
	1	51.747	51.747	4	8	1208.23035	12	1557.25352	16	1956.0366	20	2377.50557;
	1	51.747	51.747	4	8	1208.23035	12	1557.25352	16	1956.0366	20	2377.50557;
	1	5665.23443	5665.23443	4	22	1119.44162	33	1432.61161	44	1754.76108	55	2235.93283;
	1	5665.23443	5665.23443	4	22	1119.44162	33	1432.61161	44	1754.76108	55	2235.93283;
	1	51.747	51.747	4	8	1208.23035	12	1557.25352	16	1956.0366	20	2377.50557;
	1	51.747	51.747	4	8	1208.23035	12	1557.25352	16	1956.0366	20	2377.50557;
	1	5665.23443	5665.23443	4	22	1316.56254	33	1688.27018	44	2110.47669	55	2535.46257;
	1	5665.23443	5665.23443	4	22	1316.56254	33	1688.27018	44	2110.47669	55	2535.46257;
	1	5665.23443	5665.23443	4	22	1141.93307	33	1448.77467	44	1770.19723	55	2160.4197;
	1	5665.23443	5665.23443	4	22	1141.93307	33	1448.77467	44	1770.19723	55	2160.4197;
	1	28046.681	28046.681	4	170	5243.00459	231.66667	6213.11865	293.33333	7863.05566	355	9944.47408;
	1	703.7592	703.7592	4	5	745.67427	7.33333	921.69342	9.66667	1155.95898	12	1445.52485;
	1	703.7592	703.7592	4	5	745.67427	7.33333	921.69342	9.66667	1155.95898	12	1445.52485;
	1	703.7592	703.7592	4	5	745.67427	7.33333	921.69342	9.66667	1155.95898	12	1445.52485;
	1	703.7592	703.7592	4	5	745.67427	7.33333	921.69342	9.66667	1155.95898	12	1445.52485;
	1	703.7592	703.7592	4	5	745.67427	7.33333	921.69342	9.66667	1155.95898	12	1445.52485;
	1	5665.23443	5665.23443	4	22	884.43584	33	1174.85782	44	1470.71025	55	1821.1237;
	1	5665.23443	5665.23443	4	22	884.43584	33	1174.85782	44	1470.71025	55	1821.1237;
	1	5665.23443	5665.23443	4	22	884.43584	33	1174.85782	44	1470.71025	55	1821.1237;
	1	22784.7956	22784.7956	4	62	1552.62418	93	2207.24021	124	2867.16447	155	3712.68014;
	1	28046.681	28046.681	4	170	5254.89948	231.66667	6910.34987	293.33333	8592.40827	355	10536.7115;
	1	28046.681	28046.681	4	170	4775.79962	231.66667	6177.63481	293.33333	7775.31462	355	9868.71865;
	1	5665.23443	5665.23443	4	22	1031.69929	33	1288.38408	44	1579.87505	55	1886.71665;
	1	5665.23443	5665.23443	4	22	1031.69929	33	1288.38408	44	1579.87505	55	1886.71665;
	1	28046.681	28046.681	4	170	4877.56703	231.66667	6507.36825	293.33333	8374.48424	355	10331.0128;
	1	28046.681	28046.681	4	170	4877.56703	231.66667	6507.36825	293.33333	8374.48424	355	10331.0128;
	1	0	0	4	0	0	0.33333	0	0.66667	0	1	0;
	1	63999.8223	63999.8223	4	396	3208.986	397.33333	3219.79067	398.66667	3230.59533	400	3241.4;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	0.33333	0	0.66667	0	1	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	0.33333	0	0.66667	0	1	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
	1	0	0	4	0	0	17.2	0	34.4	0	51.6	0;
	1	0	0	4	0	0	17.2	0	34.4	0	51.6	0;
	1	0	0	4	0	0	17.2	0	34.4	0	51.6	0;
	1	0	0	4	0	0	31.7	0	63.4	0	95.1	0;
	1	0	0	4	0	0	30.9	0	61.8	0	92.7	0;
	1	0	0	4	0	0	17.2	0	34.4	0	51.6	0;
	1	0	0	4	0	0	31.1	0	62.2	0	93.3	0;
	1	0	0	4	0	0	17.23333	0	34.46667	0	51.7	0;
	1	0	0	4	0	0	16.56667	0	33.13333	0	49.7	0;
	1	0	0	4	0	0	31.36667	0	62.73333	0	94.1	0;
	1	0	0	4	0	0	17.2	0	34.4	0	51.6	0;
	1	0	0	4	0	0	17.2	0	34.4	0	51.6	0;
	1	0	0	4	0	0	17	0	34	0	51	0;
	1	0	0	4	0	0	31.2	0	62.4	0	93.6	0;
	1	0	0	4	0	0	62.73333	0	125.46667	0	188.2	0;
	1	0	0	4	0	0	41.7	0	83.4	0	125.1	0;
	1	0	0	4	0	0	8.53333	0	17.06667	0	25.6	0;
	1	0	0	4	0	0	8.63333	0	17.26667	0	25.9	0;
	1	0	0	4	0	0	8.43333	0	16.86667	0	25.3	0;
	1	0	0	4	0	0	8.93333	0	17.86667	0	26.8	0;
	1	10000	0	4	30	0	66	0	120	0	160	0;
	1	0	0	4	0	0	8.9	0	17.8	0	26.7	0;
	1	0	0	4	0	0	8.73333	0	17.46667	0	26.2	0;
	1	0	0	4	0	0	8.6	0	17.2	0	25.8	0;
	1	0	0	4	0	0	20.5	0	41	0	61.5	0;
	1	0	0	4	0	0	22.2	0	44.4	0	66.6	0;
	1	0	0	4	0	0	33.63333	0	67.26667	0	100.9	0;
	1	0	0	4	0	0	33.9	0	67.8	0	101.7	0;
	1	0	0	4	0	0	21.03333	0	42.06667	0	63.1	0;
	1	0	0	4	0	0	21.8	0	43.6	0	65.4	0;
	1	0	0	4	0	0	22.33333	0	44.66667	0	67	0;
	1	0	0	4	0	0	21.6	0	43.2	0	64.8	0;
	1	0	0	4	0	0	21.26667	0	42.53333	0	63.8	0;
	1	0	0	4	0	0	21.36667	0	42.73333	0	64.1	0;
	1	0	0	4	0	0	22.2	0	44.4	0	66.6	0;
	1	0	0	4	0	0	20.8	0	41.6	0	62.4	0;
	1	0	0	4	0	0	22.3	0	44.6	0	66.9	0;
	1	0	0	4	0	0	21.73333	0	43.46667	0	65.2	0;
	1	0	0	4	0	0	9.26667	0	18.53333	0	27.8	0;
	1	0	0	4	0	0	9.1	0	18.2	0	27.3	0;
	1	0	0	4	0	0	9	0	18	0	27	0;
	1	0	0	4	0	0	9.43333	0	18.86667	0	28.3	0;
	1	0	0	4	0	0	9.06667	0	18.13333	0	27.2	0;
	1	0	0	4	0	0	9	0	18	0	27	0;
	1	0	0	4	0	0	9.4	0	18.8	0	28.2	0;
	1	0	0	4	0	0	3.1	0	6.2	0	9.3	0;
	1	0	0	4	0	0	3.23333	0	6.46667	0	9.7	0;
	1	0	0	4	0	0	3.13333	0	6.26667	0	9.4	0;
	1	0	0	4	0	0	3.03333	0	6.06667	0	9.1	0;
	1	0	0	4	0	0	3.03333	0	6.06667	0	9.1	0;
	1	0	0	4	0	0	3.23333	0	6.46667	0	9.7	0;
	1	0	0	4	0	0	3.13333	0	6.26667	0	9.4	0;
	1	0	0	4	0	0	3.93333	0	7.86667	0	11.8	0;
	1	0	0	4	0	0	3.73333	0	7.46667	0	11.2	0;
	1	0	0	4	0	0	3.43333	0	6.86667	0	10.3	0;
	1	0	0	4	0	0	1.5	0	3	0	4.5	0;
	1	0	0	4	0	0	4.4	0	8.8	0	13.2	0;
	1	0	0	4	0	0	49.43333	0	98.86667	0	148.3	0;
	1	0	0	4	0	0	266.36667	0	532.73333	0	799.1	0;
	1	0	0	4	0	0	282.33333	0	564.66667	0	847	0;
	1	0	0	4	0	0	237.83333	0	475.66667	0	713.5	0;
	1	0	0	4	0	0	16.66667	0	33.33333	0	50	0;
];

%% bus names
mpc.bus_name = {
	'ABEL';
	'ADAMS';
	'ADLER';
	'AGRICOLA';
	'AIKEN';
	'ALBER';
	'ALDER';
	'ALGER';
	'ALI';
	'ALLEN';
	'ANNA';
	'ARCHER';
	'ARNE';
	'ARNOLD';
	'ARTHUR';
	'ASSER';
	'ASTON';
	'ASTOR';
	'ATTAR';
	'ATTILA';
	'ATTLEE';
	'AUBREY';
	'AUSTEN';
	'AVERY';
	'BACH';
	'BACON';
	'BAFFIN';
	'BAILEY';
	'BAIN';
	'BAJER';
	'BAKER';
	'BALCH';
	'BALZAC';
	'BANKS';
	'BARDEEN';
	'BARKLA';
	'BARLOW';
	'BARRY';
	'BARTON';
	'BASOV';
	'BATES';
	'BAYLE';
	'BEDE';
	'BEETHOVEN';
	'BEHRING';
	'BELL';
	'BLOCH';
	'BORDET';
	'CABELL';
	'CABOT';
	'CAESAR';
	'CAINE';
	'CALVIN';
	'CAMUS';
	'CAREW';
	'CARREL';
	'CARTER';
	'CARUSO';
	'CARY';
	'CAXTON';
	'CECIL';
	'CHAIN';
	'CHASE';
	'CHIFA';
	'CHUHSI';
	'CLARK';
	'CLAY';
	'CLIVE';
	'COBB';
	'COLE';
	'COMTE';
	'CURIE';
	'CURTISS';
};

%%-----  DC Line Data  -----%%
%	fbus	tbus	status	Pf	Pt	Qf	Qt	Vf	Vt	Pmin	Pmax	QminF	QmaxF	QminT	QmaxT	loss0	loss1
mpc.dcline = [
	113	316	1	0	0	0	0	1	1	-100	100	-Inf	Inf	-Inf	Inf	0	0;%%
];
%%
% modification
% 检修计划，包括20台机组
mpc.MaintGen = [
%Index Name ID StartPeriod EndPeriod Status    Sign Duration   Cost    InitialStart InitialEnd CostF
    1   18  1       1           13      1       0       6       100     7           12          10;
    2   74  1       6           20      1       0       6       100     16          21          10;
    3   20  1       18          30      1       0       5       100     20          24          10;
    4   43  1       25          36      1       0       5       100     32          36          10;
    5   71  1       32          40      1       0       5       200     36          40          10;
    6   10  1       9           20      1       0       4       200     12          15          10;
    7   11  1       16          25      1       0       4       200     20          23          10;
    8   16  1       43          50      1       0       4       250     45          48          10;
    9   17  1       18          30      1       0       4       250     21          24          10;
    10  19  1       22          32      1       0       4       300     22          25          10;
    11  31  1       7           15      1       0       3       200     7           9           10;
    12  32  1       4           10      1       0       3       200     8           10          10;
    13  55  1       10          20      1       0       3       300     12          14          10;
    14  56  1       22          26      1       0       5       300     23          26          10;
    15  3   1       24          36      1       0       3       300     28          30          10;
    16  4   1       8           17      1       0       3       300     12          14          10;
    17  1   1       23          32      1       0       2       300     25          26          10;
    18  2   1       22          29      1       0       2       300     26          27          10;
    19  14  1       2           15      1       0       2       200     11          12          10;
    20  15  1       32          38      1       0       2       200     34          35          10;
];
mpc.MaintBranch = [
%Index Name Fbus Tbus ID StartPeriod EndPeriod State Sign Duration Cost OutageRate OutageDuration MaxPartialTimes MinPartialDuration MinPartialInterval

];
mpc.PeriodLoad = [
    86.2
    90.0
    87.8
    83.4
    88.0
    84.1
    83.2
    80.6
    74.0
    73.7
    71.5
    72.7
    70.4
    75.0
    72.1
    80.0
    75.4
    83.7
    87.0
    88.0
    85.6
    81.1
    90.0
    88.7
    89.6
    86.1
    75.5
    81.6
    80.1
    88.0
    72.2
    77.6
    80.0
    72.9
    72.6
    70.5
    78.0
    69.5
    72.4
    72.4
    74.3
    74.4
    80.0
    88.1
    88.5
    90.9
    94.0
    89.0
    94.2
    97.0
   100.0
    95.2
]'/100*sum(mpc.bus(:,3))/mpc.baseMVA;
mpc.crew = [
%   N_gen   CapacityGen    N_branch   CapacityBranch
    1e10        1e10        1e10        1e10;
];
mpc.crew = ones(length(mpc.PeriodLoad),1)*mpc.crew;


