`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:13:28 05/09/2023 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
		input btn,
		input clk,
		output btn_state
	);
	reg btn_state_temp = 0;
	reg[15:0] counter;
	
	reg clk1;
	reg clk2;
	
	always @ (posedge clk) begin
		if (btn == 1) begin
			counter <= counter + 1'b1;
//			$write("not counted\n");
			if (counter == 16'hffff) begin
//				$write("counted\n");
				counter <= 0;
				btn_state_temp <= 1;
			end
		end
		else begin
			counter <= 0;
			btn_state_temp <= 0;
		end
	end
	
	assign btn_state = btn_state_temp;


endmodule
