`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:15:32 11/11/2022 
// Design Name: 
// Module Name:    name 
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
`define _R  6'b000000
`define ADD 6'b100000
`define SUB 6'b100010
`define ORI 6'b001101
`define LUI 6'b001111
`define LW 	6'b100011
`define SW  6'b101011
`define BEQ 6'b000100
`define JAL 6'b000011
`define JR 	6'b001000

`define RegDist_rd 2'b00
`define RegDist_rt 2'b01
`define RegDist_$ra 2'b10

`define ALUSrc_rt 2'b00
`define ALUSrc_ExtImm 2'b01

`define MemtoReg_ALUOut 2'b00
`define MemtoReg_MemOut 2'b01 //内存的结果
`define MemtoReg_NowPC 2'b10

`define RegWrite_Yes 1'b1
`define RegWrite_No 1'b0

`define MemWrite_Yes 1'b1
`define MemWrite_No 1'b0

`define PCSrc_Order 2'b00
`define PCSrc_Beq 2'b01
`define PCSrc_Jal 2'b10
`define PCSrc_Jr 2'b11

`define ExtOp_signed 2'b00
`define ExtOp_unsigned 2'b01
`define ExtOp_high 2'b10 //suitable for high
`define ExtOp_26bit 2'b11 //需要立即数和PC

`define ALUCtrl_ADD 4'b0000
`define ALUCtrl_SUB 4'b0001
`define ALUCtrl_OR 4'b0010
`define ALUCtrl_AND 4'b0011

module name(
    );


endmodule
