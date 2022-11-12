`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:26:17 11/03/2022 
// Design Name: 
// Module Name:    highgen 
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
module highgen(
	input [15:0] in,
	output [31:0] out
    );
	assign out = {in, 16'h0000};//无符号加载至高位，适合lui

endmodule
