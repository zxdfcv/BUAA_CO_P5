`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:14 11/02/2022 
// Design Name: 
// Module Name:    mux2 
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
module mux2(
	input [31:0] x0,
	input [31:0] x1,
	input sel,
	output [31:0] result
    );//s
	assign result = (sel == 1'b0) ? x0 : 
						(sel == 1'b1) ? x1 :
						32'h0000_0000; //error

endmodule
