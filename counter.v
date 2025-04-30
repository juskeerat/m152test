`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:31:26 05/09/2023 
// Design Name: 
// Module Name:    counter 
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
module counter(
		input wire pause,
		input wire rst,
		input wire sel,
		input wire adj,
		input wire onehz_clk,
		input wire twohz_clk,
		output wire [5:0] mins,
		output wire [5:0] secs
	);
	reg [5:0] min_temp = 5'b0;
	reg [5:0] sec_temp = 5'b0;
	reg paused = 0;
	
	//implement choosing which clock
	sel_adj_button(.adj(adj), .onehz_clock(onehz_clk), .twohz_clock(twohz_clk), .chosen_clock(clk));
	
	always @ (posedge clk or posedge pause) begin
		if (pause) begin
			paused <= ~paused;
		end
		else begin
			paused <= paused;
		end
	end
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			min_temp <= 5'b0;
			sec_temp <= 5'b0;
		end
		else if (~paused) begin
			min_temp <= mins;
			sec_temp <= secs;
			if (adj) begin
				if (sel) begin
					if (sec_temp == 59) begin
						sec_temp <= 5'b0;
					end
					else begin 
						sec_temp <= sec_temp + 1;
					end
				end
				else begin
					if (min_temp == 59) begin
						min_temp <= 5'b0;
					end
					else begin 
						min_temp <= min_temp + 1;
					end
				end
			end
		end
		else begin
			if (min_temp == 59 && sec_temp == 59) begin
				min_temp <= 5'b0;
				sec_temp <= 5'b0;
			end
			else if (min_temp != 59 && sec_temp == 59) begin
				sec_temp <= 5'b0;
				min_temp <= min_temp + 5'b1;
			end
			else begin
				sec_temp <= sec_temp + 5'b1;
			end
		end
	end
	
	assign mins = min_temp;
	assign secs = sec_temp;
endmodule
