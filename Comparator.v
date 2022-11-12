`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:53 11/11/2022 
// Design Name: 
// Module Name:    Comparator 
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
module Comparator(
	input [31:0] A,
	input [31:0] B,
	output cmp
    );
	assign cmp = (A == B);

endmodule
