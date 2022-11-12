`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:03 11/03/2022 
// Design Name: 
// Module Name:    jalgen 
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
module jalgen(
	input [25:0] Imm,
	input [3:0] PC_4, //还是[31:28] ? 不清楚 fit length is al
	output [31:0] newPC //计算新的PC(select)
    );
	assign newPC = {PC_4, Imm, 2'b00}; //拼接 注意存储当前PC

endmodule
