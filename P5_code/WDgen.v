`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:46:05 11/02/2022 
// Design Name: 
// Module Name:    WDgen 
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
module WDgen(
	input [31:0] ALUOut,
	input [31:0] DMdataOut,
	input [31:0] high,
	input [31:0] pcAdd4,
	input MemtoReg, //这里有待整合,可以增加选择多位信号的MUX
	input Imm_high_zero,
	input nPC_sel_1,
	output [31:0] out
    );
	wire [1:0] sel;
	wire [31:0] out2;
	assign sel = {nPC_sel_1, Imm_high_zero};//sew signal
	mux2 mux2_WD(.x0(ALUOut), .x1(DMdataOut), .sel(MemtoReg), .result(out2));
	mux3 mux3_WD(.x0(out2), .x1(high), .x2(pcAdd4), .sel(sel), .result(out));//模块化 连接输出
endmodule
