`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:52:44 11/03/2022 
// Design Name: 
// Module Name:    mux3_5bit 
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
module mux3_5bit(
	input [4:0] x0,
	input [4:0] x1,
	input [4:0] x2,
	input [1:0] sel,
	output [4:0] result
    );
	assign result = (sel == 2'b00) ? x0 : 
						(sel == 2'b01) ? x1 :
						(sel == 2'b10) ? x2 :
						5'b00000; //error

endmodule 