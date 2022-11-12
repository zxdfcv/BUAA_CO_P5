`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:14 11/06/2022 
// Design Name: 
// Module Name:    DecodeReg 
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
module DecodeReg(
	input clk,
	input reset,
	input [31:0] NextIDPC_4,
	input [31:0] NextIDPC,
	output reg [31:0] IDIR,
	output reg [31:0] IDPC_4,//��һ�׶ε�������� ��������չ
	output reg [31:0] IDPC
	//������ˮ�߼Ĵ��������ṩ���ݵ���ˮ���ļ���������� D ����ˮ�߼Ĵ�����ǰһ��Ϊ F ��������һ��Ϊ D ����
    );
	parameter init = 32'h0000_0000;
	always@(posedge clk) begin//��Ҫ����ģ�黯�Ͳ�λ���ơ������ļ�Ϊ mips.v����Ч�������ź�Ҫ������ҽ�����ͬ����λ�ź� reset��ʱ���ź� clk��ע��ͬ����λ������
		if (reset == 1'b1) begin
			IDIR <= init;
			IDPC <= init;
			IDPC_4 <= init;//����PCͳһ��
		end else begin
			IDIR <= NextIDIR;
			IDPC <= NextIDPC;
			IDPC_4 <= NextIDPC_4;
		end
	end
endmodule
