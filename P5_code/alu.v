
`include "name.v"
module alu(
	input [31:0] A,
	input [31:0] B,
	input [3:0] ALUCtrl,
	output [31:0] result,
	output zero //不需使用
);
	parameter Except = 32'h0000_0000;
	assign result = (ALUCtrl == `ALUCtrl_ADD) ? (A + B) : 
						(ALUCtrl == `ALUCtrl_SUB) ? (A - B) : 
						(ALUCtrl == `ALUCtrl_OR) ? (A | B) :
						(ALUCtrl == `ALUCtrl_AND) ? (A & B) : //增加功能
						Except; //error
	
	assign zero = (A == B);
endmodule
