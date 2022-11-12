`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:33 11/02/2022 
// Design Name: 
// Module Name:    mux3 
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
module mux3(
	input [31:0] x0,
	input [31:0] x1,
	input [31:0] x2,
	input [1:0] sel,
	output [31:0] result
    );
	assign result = (sel == 2'b00) ? x0 : 
						(sel == 2'b01) ? x1 :
						(sel == 2'b10) ? x2 :
						32'h0000_0000; //error

endmodule
