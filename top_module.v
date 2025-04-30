`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:12:53 05/09/2023 
// Design Name: 
// Module Name:    top_module 
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
module top_module(
		input clk,
		input reset,
		input pause,
		input sel,
		input wire [1:0] adj,
		output reg[7:0] seg,
		output reg[3:0] an
	);
	//reg[7:0] seg;
	//reg[3:0] an;
	wire [5:0] mins;
	wire [5:0] secs;
	
	wire onehz_clk;
	wire twohz_clk;
	wire faster_clk;
	wire blinker_clk;
	
	// TO DO: Debouncer for adj and sel also???
	wire reset_status;
	wire pause_status;
	
	wire [3:0] min_10s_count;
	wire [3:0] min_1s_count;
	wire [3:0] sec_10s_count;
	wire [3:0] sec_1s_count;
	
	wire [7:0] seven_seg_min_10s;
	wire [7:0] seven_seg_min_1s;
	wire [7:0] seven_seg_sec_10s;
	wire [7:0] seven_seg_sec_1s;
	
	debouncer reset_debounce(.btn(reset), .clk(clk), .btn_state(reset_status));
	debouncer pause_debounce(.btn(pause), .clk(clk), .btn_state(pause_status));
	
	clocks clock(.sys_clk(clk), .rst(reset),.onehz_clk(onehz_clk), .twohz_clk(twohz_clk), .faster_clk(faster_clk),.blinker_clk(blinker_clk));
	
	counter count (
		.pause(pause),
		.rst(reset),
		.sel(sel),
		.adj(adj),
		.onehz_clk(onehz_clk),
		.twohz_clk(twohz_clk),
		.mins(mins),
		.secs(secs)
	);
	
//	assign min_10s_count = mins/10;
//	assign min_1s_count = mins/10 - (10 * min_10s_count);
//	assign sec_10s_count = secs/10;
//	assign sec_1s_count = secs/10 - (10 * sec_10s_count);
	
	svn_seg seven_seg_min_call(.dig(mins), .svn_seg10s(seven_seg_min_10s), .svn_seg1s(seven_seg_min_1s));
	svn_seg seven_seg_sec_call(.dig(secs), .svn_seg10s(seven_seg_sec_10s), .svn_seg1s(seven_seg_sec_1s));
	
	reg[1:0] counter_val = 2'b00;
	
	wire [7:0] blank;
	wire [7:0] useless;
	svn_seg value(
			.dig(4'b1111),
			.svn_seg10s(blank), .svn_seg1s(useless)
	);
			
			
	reg min = 1'b0;
	reg sec = 1'b0; 

	always @ (posedge faster_clk) begin 
		case(counter_val)
			2'b00	:	an <= 4'b0111;
			2'b01	:	an <= 4'b1011;
			2'b10	:	an <= 4'b1101;
			2'b11	:	an <= 4'b1110;
		endcase
		if(adj == 1 || adj == 2) begin
			$write(seven_seg_min_10s);
			$write(seven_seg_min_1s);
			$write(seven_seg_sec_10s);
			$write(seven_seg_sec_1s);
			if(!sel) begin 
				if (counter_val == 0) begin
					//an <= 4'b0111;
					if (blinker_clk) begin
						seg <= seven_seg_min_10s;
					end
					else begin
						seg <= blank;
					end
					counter_val <= counter_val + 1;
				end
				else if (counter_val == 1) begin
					if (blinker_clk) begin
						seg <= seven_seg_min_1s;
					end
					else begin
						seg <= blank;
					end
					counter_val <= counter_val + 1;
				end
				else if (counter_val == 2) begin
					seg <= seven_seg_sec_10s;
					counter_val <= counter_val + 1;
				end
				else if (counter_val == 3) begin
					seg <= seven_seg_sec_1s;
					counter_val <= counter_val + 1;
				end
			end
			else begin
				if (counter_val == 0) begin
					seg <= seven_seg_min_10s;
					counter_val <= counter_val + 1;
				end
				else if (counter_val == 1) begin
					seg <= seven_seg_min_1s;
					counter_val <= counter_val + 1;
				end
				else if (counter_val == 2) begin
					seg <= seven_seg_sec_10s;
					counter_val <= counter_val + 1;
				end
				else if (counter_val == 3) begin
					seg <= seven_seg_sec_1s;
					counter_val <= counter_val + 1;
				end
			end
		end
		else begin
			if (counter_val == 0) begin
				seg <= seven_seg_min_10s;
				counter_val <= counter_val + 1;
			end
			if (counter_val == 1) begin 
				seg <= seven_seg_min_1s;
				counter_val <= counter_val + 1;
			end
			if (counter_val == 2) begin 
				seg <= seven_seg_sec_10s;
				counter_val <= counter_val + 1;
			end
			if (counter_val == 3) begin
				seg <= seven_seg_sec_1s;
				counter_val <= counter_val + 1;
			end
		end
	end
endmodule
