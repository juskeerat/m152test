`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:16:47 05/11/2023 
// Design Name: 
// Module Name:    svn_seg 
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
module svn_seg(
		input wire [5:0] dig,
		output wire[7:0] svn_seg10s,
		output wire[7:0] svn_seg1s
	);
	reg[7:0] svn_seg_temp10s;
	reg[7:0] svn_seg_temp1s;
	reg[3:0] dig10s;
	reg[3:0] dig1s;
	
	always @(*) begin
		dig10s = dig/10;
		dig1s = dig/10 - (10 * dig10s);
		case(dig10s)
			4'b1: svn_seg_temp10s = 8'b11000000;
			4'b10: svn_seg_temp10s = 8'b11111001;
			4'b11: svn_seg_temp10s = 8'b10110000;
			4'b100: svn_seg_temp10s = 8'b10011001;
			4'b101: svn_seg_temp10s = 8'b10010010;
			4'b110: svn_seg_temp10s = 8'b10000010;
			4'b111: svn_seg_temp10s = 8'b11111000;
			4'b1000: svn_seg_temp10s = 8'b10000000;
			4'b1001: svn_seg_temp10s = 8'b10010000;
			default: svn_seg_temp10s = 8'b11111111;
		endcase
		case(dig1s)
			4'b1: svn_seg_temp1s = 8'b11000000;
			4'b10: svn_seg_temp1s = 8'b11111001;
			4'b11: svn_seg_temp1s = 8'b10110000;
			4'b100: svn_seg_temp1s = 8'b10011001;
			4'b101: svn_seg_temp1s = 8'b10010010;
			4'b110: svn_seg_temp1s = 8'b10000010;
			4'b111: svn_seg_temp1s = 8'b11111000;
			4'b1000: svn_seg_temp1s = 8'b10000000;
			4'b1001: svn_seg_temp1s = 8'b10010000;
			default: svn_seg_temp1s = 8'b11111111;
		endcase
	end
	assign svn_seg10s = svn_seg_temp10s;
	assign svn_seg1s = svn_seg_temp1s;

endmodule
