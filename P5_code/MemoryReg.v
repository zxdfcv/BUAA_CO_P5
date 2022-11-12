`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:02 11/06/2022 
// Design Name: 
// Module Name:    MEMoryReg 
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
module MemoryReg(
	input [31:0] NextMEMALUOut,
	input [31:0] NextMEMPC_4,
	input [31:0] NextMEMPC,
	input [31:0] NextMEMIR,
	input [4:0] NextMEMRD2,
	
	output reg [31:0] NextMEMPC,
	output reg [31:0] MEMPC_4,
	output reg [31:0] MEMIR,
	output reg [31:0] MEMRD2,
	output reg [31:0] MEMALUOut
    );
	patameter init = 32'h0000_0000;//可以加一个头文件装载所有的参数
	always@(posedge clk) begin
		if (reset == 1'b1) begin
			MEMPC_4 <= init;
			MEMPC <= init;
			MEMIR <= init;
			MEMRD2 <= init;
			MEMALUOut <= init;
		end else begin
			MEMPC <= NextMEMPC;
			MEMPC_4 <= NextMEMPC_4;//PC + 4
			MEMIR <= NextMEMIR;
			MEMRD2 <= NextMEMRD2;
			MEMALUOut <= NextALUOut;
		end
	end

endmodule
