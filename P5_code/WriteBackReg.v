`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:25 11/06/2022 
// Design Name: 
// Module Name:    WriteBackReg 
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
module WriteBackReg(
	input clk,
	input reset,
	input [31:0] NextWBIR,
	input [31:0] NextWBRD,
	input [31:0] NextWBPC,
	input [31:0] NextWBPC_4,
	input [31:0] NextWBALUOut,
	
	output reg [31:0] WBIR,
	output reg [31:0] WBRD,
	output reg [31:0] WBPC,
	output reg [31:0] WBPC_4,
	output reg [31:0] WBALUOut
    );
	parameter init = 32'h0000_0000;
	always@(posedge clk) begin
		if (reset == 1'b1) begin
			WBIR <= init;
			WBRD <= init;
			WBPC <= init;
			WBPC_4 <= init;
			WBALUOut <=  init;
		end else begin
			WBIR <= NextWBIR;
			WBRD <= NextWBRD;
			WBPC <= NextWBPC;
			WBPC_4 <= NextWBPC_4;
			WBALUOut <= NextWBALUOut;
		end
	end

endmodule
