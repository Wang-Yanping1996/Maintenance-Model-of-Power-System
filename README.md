# Maintenance-Model-of-Power-System  
Maintenance Model of Power System with Matlab and Yalmip, including the maintenance of  branches and generators, and a partial mantenance is allowed for branches. The Object Functions are 1.Maximize the minimum reserve rate, 2.Minimize the cost, 3. Minimize the Variance of reserve rate(resulting in a long solution time)  
使用Matlab和Yalmip进行电力系统维护的模型，包括分支机构和发电机的维护，并且分支机构可以进行部分维护。 对象函数是1.最大化最小储备率，2.最小化成本，3.最小化储备率的差异（导致较长的求解时间）

Besides, note that the model is based on the Matlab, Yalmip, and the solver is Gurobi. It can be changed to other solvers, such as Cplex, by modifying the parameter 'gurobi' in sentence 'ops = settings('solver','gurobi''.   
此外，请注意，该模型基于Matlab，Yalmip，求解器为Gurobi。 通过修改句子'ops = settings('solver'，'gurobi'中的参数'gurobi'，可以将其更改为其他求解器，例如Cplex。

If you have any idea on improving this model, please contact me.   
如果您有任何改进此模型的想法，请联系我.

注：matlab上传github，中文注释乱码的问题，暂时没找到解决办法，如果您有，可以告诉我。目前我的解决方法是，上传了一个.zip的压缩包，下载后解压应该不会乱码。
Note that: when I upload the .m files to github, its Chinese notes will be error codes, I didn't find any way to solve it, if you know, please tell me. Now my solution is that a .zip file is uploaded, upzip it seems to avoid the error codes problem.
