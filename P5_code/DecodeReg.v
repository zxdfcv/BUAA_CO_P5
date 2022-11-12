`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:14 11/06/2022 
// Design Name: 
// Module Name:    DecodeReg 
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
module DecodeReg(
	input clk,
	input reset,
	input [31:0] NextIDPC_4,
	input [31:0] NextIDPC,
	output reg [31:0] IDIR,
	output reg [31:0] IDPC_4,//这一阶段的数据最简单 无其他扩展
	output reg [31:0] IDPC
	//我们流水线寄存器以其提供数据的流水级的简称命名，如 D 级流水线寄存器的前一级为 F 级，而后一级为 D 级。
    );
	parameter init = 32'h0000_0000;
	always@(posedge clk) begin//需要采用模块化和层次化设计。顶层文件为 mips.v，有效的驱动信号要求包括且仅包括同步复位信号 reset和时钟信号 clk，注意同步复位！！！
		if (reset == 1'b1) begin
			IDIR <= init;
			IDPC <= init;
			IDPC_4 <= init;//两种PC统一存
		end else begin
			IDIR <= NextIDIR;
			IDPC <= NextIDPC;
			IDPC_4 <= NextIDPC_4;
		end
	end
endmodule
