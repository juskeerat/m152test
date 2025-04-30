`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:09:33 05/11/2023 
// Design Name: 
// Module Name:    sel_adj_button 
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
module sel_adj_button(
		input wire adj,
		input wire onehz_clock,
		input wire twohz_clock,
		output wire chosen_clock
	);
	reg chosen_clock_tmp;
	
	always @(*) begin
		if (~adj) begin
			chosen_clock_tmp = onehz_clock;
		end
		else begin
			chosen_clock_tmp = twohz_clock;
		end
	end
	assign chosen_clock = chosen_clock_tmp;
endmodule
