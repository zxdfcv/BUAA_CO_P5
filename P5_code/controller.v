`timescale 1ns / 1ps
`include "name.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:47:41 10/29/2022 
// Design Name: 
// Module Name:    datapath1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module controller(
	input [31:0] Instr,
	//output [1:0] RegDist, //寄存器写选择信号
	output [1:0] ALUSrc,
	output [1:0] MemtoReg,
	output RegWrite,
	output MemWrite,
	output [1:0] PCSrc, //输出信号 跳转指令相关
	output [1:0] ExtOp,
	output [3:0] ALUCtr1, //ALU两位控制信号
	output ByteSel, //控制byte选择
	output [4:0] A3
);
//R
wire [1:0] RegDist;
wire [5:0] Op = Instr[31:26];
wire [5:0] Fucnt= Instr[5:0];
wire _add = (Op == `_R && Funct == `ADD);
wire _sub = (Op == `_R && Funct == `SUB);
wire _jr = (Op == `_R && Funct == `JR);
//I
wire _ori = (Op == ORI);
wire _lui = (Op == LUI);
wire _lw = (Op == LW);
wire _sw = (Op == SW);
wire _beq = (Op == BEQ);
//J
wire _jal = (Op == JAL);//define + "`"

//wire 前面一定要加下划线！！！！不然查不到BUG！！！！！
//

assign RegDist = (_ori | _lui |  _lw) ? `RegDist_rt :
						(_jal) ? `RegDist_$ra :
						RegDist_rd;
						
assign ALUSrc = (_ori | _lui | _lw | _sw) ? `ALUSrc_ExtImm :
					`ALUSrc_rt; //ALU  second imput selection
					
assign MemtoReg = (_ori | _lui | _sw) ? `MemtoReg_MemOut :
						(_jal) ? `MemtoReg_NowPC :
						`MemtoReg_ALUOut;
						

assign RegWrite = (_add | _sub | _ori | lui | _lw | _jal) ? `RegWrite_Yes:
					`RegWrite_No;
						
assign MemWrite = (_sw) ? `MemWrite_Yes : 
					`MemWrite_No;
					
assign PCSrc = (_beq) ? `PCSrc_Beq :
					(_jal) ? `PCSrc_Jal :
					(_jr) ? `PCSrc_Jr : //must secure the connection of single wire
					`PCSrc_Order;
					
assign ExtOp = (_lw | _sw | _beq) ? `ExtOp_signed : 
					(_lui) ? `ExtOp_high :
					(jal) ? `ExtOp_26bit : 
					`ExtOp_unsigned;
					
assign ALUCtr1 = (_sub | _beq) ? ALUCtr1_SUB :  //全称
						(_ori) ? ALUCtrl_OR :
						ALUCtrl_ADD;
assign ByteSel = 1'b0;
	
	
assign A3 = (RegDist == `RegDist_$ra) ? 5'b11111 : //$ra
				(RegDist == `RegDist_rt) ? Instr[20:16] : //rt
				Instr[15:11]; //rd //默认 //必须要写才有效
endmodule

