`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:25 11/03/2022 
// Design Name: 
// Module Name:    sbgen 
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
module sbgen(
	input [31:0] DMdataOut,
	input [31:0] dataOut2,
	input [1:0] Byte, //×Ö½ÚÑ¡ÔñÏß
	output reg [31:0] sbData
    );
	integer i;
	always @(*) begin
		sbData[7 : 0] = (Byte == 2'b00) ? DMdataOut[7 : 0] : dataOut2[7 : 0];
		sbData[15 : 8] = (Byte == 2'b01) ? DMdataOut[15 : 8] : dataOut2[15 : 8];
		sbData[23 : 16] = (Byte == 2'b10) ? DMdataOut[23 : 16] : dataOut2[23 : 16];
		sbData[31 : 24] = (Byte == 2'b11) ? DMdataOut[31 : 24] : dataOut2[31 : 24];
	end

endmodule
