`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:17 11/03/2022 
// Design Name: 
// Module Name:    lbgen 
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
module lbgen(
	input [31:0] WriteData, //即将写入grf的数据
	input [1:0] Byte, //字节选择线
	output [31:0] lbData
    );
	wire [7:0] low;
	assign low = (Byte == 2'b00) ? WriteData[7:0] : 
						(Byte == 2'b01) ? WriteData[15:8] : 
						(Byte == 2'b10) ? WriteData[23:16] :
						(Byte == 2'b11) ? WriteData[31:17] :
						8'h00;//error
	assign lbData = {24'h00_0000, low};//线路拼接
endmodule
