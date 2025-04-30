`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:44:12 05/09/2023 
// Design Name: 
// Module Name:    clocks 
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
`define ONEHZ 50000000
`define TWOHZ 25000000
`define FASTHZ 125000
`define BLINKHZ 12500000

module clocks(
		input wire sys_clk,
		input wire rst,
		output wire onehz_clk,
		output wire twohz_clk,
		output wire faster_clk,
		output wire blinker_clk
	);
	reg onehz_clk_temp;
	reg twohz_clk_temp;
	reg faster_clk_temp;
	reg blinker_clk_temp;
	
	reg [31:0] onehz_clk_cnt;
	reg [31:0] twohz_clk_cnt;
	reg [31:0] faster_clk_cnt;
	reg [31:0] blinker_clk_cnt;
	
	//for 1hz
	always @ (posedge sys_clk or posedge rst) begin
		if (rst == 1'b1) begin
			onehz_clk_cnt <= 32'b0;
			onehz_clk_temp <= 1'b0;
		end
		else if (onehz_clk_cnt == `ONEHZ - 1) begin
			onehz_clk_cnt <= 32'b0;
			onehz_clk_temp <= ~onehz_clk;
		end
		else begin
			onehz_clk_cnt <= onehz_clk_cnt + 1;
			onehz_clk_temp <= onehz_clk;
		end
	end
	
	//for 2hz
	always @ (posedge sys_clk or posedge rst) begin
		if (rst == 1'b1) begin
			twohz_clk_cnt <= 32'b0;
			twohz_clk_temp <= 1'b0;
		end
		else if (twohz_clk_cnt == `TWOHZ - 1) begin
			twohz_clk_cnt <= 32'b0;
			twohz_clk_temp <= ~twohz_clk;
		end
		else begin
			twohz_clk_cnt <= twohz_clk_cnt + 1;
			twohz_clk_temp <= twohz_clk;
		end
	end
	
	//for fast
	always @ (posedge sys_clk or posedge rst) begin
		if (rst == 1'b1) begin
			faster_clk_cnt <= 32'b0;
			faster_clk_temp <= 1'b0;
		end
		else if (faster_clk_cnt == `FASTHZ - 1) begin
			faster_clk_cnt <= 32'b0;
			faster_clk_temp <= ~faster_clk;
		end
		else begin
			faster_clk_cnt <= faster_clk_cnt + 1;
			faster_clk_temp <= faster_clk;
		end
	end
	
	//for blink
	always @ (posedge sys_clk or posedge rst) begin
		if (rst == 1'b1) begin
			blinker_clk_cnt <= 32'b0;
			blinker_clk_temp <= 1'b0;
		end
		else if (faster_clk_cnt == `BLINKHZ - 1) begin
			blinker_clk_cnt <= 32'b0;
			blinker_clk_temp <= ~blinker_clk;
		end
		else begin
			blinker_clk_cnt <= blinker_clk_cnt + 1;
			blinker_clk_temp <= blinker_clk;
		end
	end
	
	assign onehz_clk = onehz_clk_temp;
	assign twohz_clk = twohz_clk_temp;
	assign faster_clk = faster_clk_temp;
	assign blinker_clk = blinker_clk_temp;
endmodule
