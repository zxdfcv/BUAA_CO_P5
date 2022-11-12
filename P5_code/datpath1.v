//?根据你设计的数据通路架构图以及各个部件模块的输入输出端口，在 datapath.v 中定义一些内部的 wire 型变量，
//利用模块间的逻辑关系，对各个部件模块进行实例化，串接在一起，
//使之成为一个整体，最后预留出控制器信号的输入和输出端口即可。

//这句话相当重要
module datapath(
	input clk,
	input reset
);
	parameter init = 32'h0000_0000;
	wire clk;
	wire reset;
	
	wire [31:0] branch;
	wire [31:0] jal;
	wire cmp;//比较结果
	
	
	wire [31:0] IFPC;
	wire [31:0] IFPC_4;//+4的PC
	wire [31:0] IFNextPC;
	wire [31:0] IFIR;
	
	wire [31:0] IDPC;
	wire [31:0] IDPC_4;
	wire [31:0] IDIR;
	wire [31:0] IDRD1;
	wire [31:0] IDRD2;
	wire [31:0] IDImm;
	wire [1:0] PCSrc;//控制信号不需要流水前面不加流水线寄存器名称
	wire [1:0] ExtOp;
	
	wire [31:0] EXPC_4;
	wire [31:0] EXPC;
	wire [31:0] EXIR;
	wire [31:0] EXRD1;
	wire [31:0] EXRD2;
	wire [31:0] EXImm;//EX拓展出的立即数
	wire [1:0] ALUSrc;
	wire [3:0] ALUCtrl;
	
	wire [31:0] MEMPC_4;
	wire [31:0] MEMPC;
	wire [31:0] MEMIR;
	wire [31:0] MEMRD2;
	wire [31:0] MEMALUOut;
	wire MemWrite;
	
	wire [31:0] WBPC;
	wire [31:0] WBPC_4;
	wire [31:0] WBIR;
	wire [31:0] WBALUOut;
	wire [31:0] WBRD;//memdataout
	wire [31:0] WBPC_8;
	wire [31:0] WD;//最终写入数据
	//IF
	PCcalculate PCcalculate(
	.order(IFPC_4),
	.branch(branch), 
	.jal(jal), 
	.jr(IDRD1), //IF级用了ID级的PC
	.cmp(cmp), 
	.PCSrc(PCSrc)
	);//分布式译码控制信号无需流水
	
	pc pc(
	.clk(clk), 
	.reset(reset), 
	.next_pc(IFNextPC), 
	.pc(IFPC)
	);
	
	adder IFadder(
	.A(IFPC),
	.B(32'h0000_0004),
	.out(IFPC_4)
	);//generate IFPC_4
	
	im im(
	.pc(IFPC),
	.instruct(IFIR)
	);
	//四级流水线寄存器->五级流水线
	
	//ID
	DecodeReg UutDecodeReg(
	.clk(clk),
	.reset(reset),
	.NextIDIR(IFIR),
	.NextIDPC_4(IFPC_4),
	.NextIDPC(IFPC),
	.IDIR(IDIR),
	.IDPC_4(IDPC_4),//这一阶段的数据最简单 无其他扩展
	.IDPC(IDPC)
	//我们流水线寄存器以其提供数据的流水级的简称命名，如 D 级流水线寄存器的前一级为 F 级，而后一级为 D 级。
    );
	controller controllerDe(
	.Instr(IFIR),
	.PCSrc(PCSrc),
	.ExtOp(ExtOp)
	);
	Comparator Comparator(
	.A(IDRD1), 
	.B(IDRD2), 
	.cmp(cmp)
	);
	
	extender extender(
	.Instr(IDIR),
	.IDPC(IDPC),
	.IDPC_4(IDPC_4),
	.ExtOp(ExtOp), //Mode 选择
	.out(IDImm),
	.beq(brach), //无需reg
	.jal(jal)
   );//通用性
	
	//EX
	ExecuteReg UutExecuteReg(
	.clk(clk),
	.reset(reset),
	.NextEXPC_4(IDPC_4),
	.NextEXPC(IDPC),
	.NextEXIR(IDIR),

	.NextEXImm(IDImm),
	.NextEXRD1(IDRD1),
	.NextEXRD2(IDRD2),

	.EXPC(EXPC),
	.EXPC_4(EXPC_4),
	.EXIR(EXIR), 

	.EXImm(EXImm),
	.EXRD1(EXRD1),
	.EXRD2(EXRD2),
   );
	
	controller controllerEx(
	.Instr(ExIR),
	.ALUSrc(ALUSrc),
	.ALUCtrl(ALUCtrl)
	);
	
	mux4 mux4_ALUSrc(
	.x0(EXImm),
	.x1(EXRD2),
	.x2(init),
	.x3(init), //暂时不用
	.sel(ALUSrc)
	);
	
	alu ALU(
	.A(EXRD1),
	.B(ALUB),
	.ALUCtrl(ALUCtrl),
	.result(EXALUOut)
	);
	
	//MEM
	MemoryReg UutMemoryReg(
	.NextMEMALUOut(EXALUOut),
	.NextMEMPC_4(EXPC_4),
	.NextMEMIR(EXIR),
	.NextMEMRD2(EXRD2),
	
	.MEMPC_4(MEMPC_4),
	.MEMPC(MEMPC),
	.MEMIR(MEMIR),
	.MEMRD2(MEMRD2),
	.MEMALUOut(MEMALUOut)
   );
	controller controllerMem(
	.Instr(MEMIR), //IR : Instr
	.MemWrite(MemWrite)
	);
	
	dm DM(
	.clk(clk),
	.reset(reset),
	.MemWrite(MemWrite),
	.addr(ALUOut[13:2]), //取出数据地址 ->截掉两位
	.dataIn(MEMRD2), //输入数据
	.pc(MEMPC),
	.fullAddress(ALUOut),
	.dataOut(DMRD) //输出数据
	);
	
	//WB
	WriteBackReg UutWriteReg(
	.clk(clk),
	.reset(reset),
	.NextWBIR(MEMIR),
	.NextWBRD(MEMRD),
	.NextWBPC(MEMPC),
	.NextWBPC_4(MEMPC_4),
	.NextWBALUOut(MEMALUOut),
	
	.WBIR(WBIR),
	.WBRD(WBRD),
	.WBPC(WBPC),
	.WBPC_4(WBPC_4),
	.WBALUOut(WBALUOut)
   );
	controller controllerWB(
	.Instr(WBIR),
	.RegWrite(RegWrite), //WE
	.MemtoReg(MemtoReg),//sel
	.A3(A3)//A3
	);
	adder WBadder(
	.A(WBPC_4),
	.B(32'h0000_0004),
	.out(WBPC_8) //PC_8
	);//generate IFPC_4
	
	mux3 mux3_MemtoReg(
	.x0(WBALUOut),
	.x1(WBRD),
	.x2(WBPC_8),
	.sel(MemtoReg),
	.result(WD)
	);
	
	//GRF单独列出 ->涉及ID和WB
	grf GRF(
	.clk(clk),
	.reset(reset),
	.WE(RegWrite),
	.A1(IDIF[25:21]),
	.A2(IDIF[20:16]),
	.A3(A3),
	.WD(WD),
	.pc(WBPC),
	.RD1(IFRD1), 
	.RD2(IFRD2)
	);
	
endmodule
