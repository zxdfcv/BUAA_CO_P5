`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:44 11/02/2022 
// Design Name: 
// Module Name:    PCcalculate 
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
module PCcalculate(
	input [31:0] order,
	input [31:0] branch,
	input [31:0] jal, //orj
	input [31:0] jr,
	input cmp,
	input [2:0] PCSrc, //三位pc选择
	output [31:0] next_pc
    );
	wire [31:0] beq;
	//reg PC_8 = order + 4;
	mux2 mux2_1(.x0(order), .x1(branch), .sel(cmp), .out(beq)); //加入PC + 8 //不需要
	mux4 mux4_1(.x0(order), ,x1(beq), .x2(jal), .x3(jr), .sel(PCSrc));
endmodule
