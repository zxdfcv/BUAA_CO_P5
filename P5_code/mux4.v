`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:43 11/02/2022 
// Design Name: 
// Module Name:    mux4 
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
module mux4(
	input [31:0] x0,
	input [31:0] x1,
	input [31:0] x2,
	input [31:0] x3,
	input [1:0] sel,
	output result
    );
	assign result = (sel == 1'b00) ? x0 : 
						(sel == 1'b01) ? x1 :
						(sel == 1'b10) ? x2 :
						(sel == 1'b11) ? x3 :
						32'h0000_0000; //error

endmodule
