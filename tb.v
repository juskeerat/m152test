`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:16:46 05/16/2023
// Design Name:   top_module
// Module Name:   C:/Users/Student/Desktop/group1_lab5/lab3/tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;
	// Inputs
	reg clk;
	reg clk2;
	reg reset;
	reg pause;
	reg sel;
	reg [1:0] adj;

	// Outputs
	wire [5:0] mins;
	wire [5:0] secs;
	wire [7:0] seg;
	wire [3:0] an;
	
	wire clk_wire;
	
	
	sel_adj_button sel_adj_uut (
		.adj(adj),
		.onehz_clock(clk),
		.twohz_clock(clk2),
		.chosen_clock(clk_wire)
	);

	// Instantiate the Unit Under Test (UUT)
	counter count_uut (
		.pause(pause),
		.rst(reset),
		.sel(sel),
		.adj(adj),
		.onehz_clk(clk),
		.twohz_clk(clk2),
		.mins(mins),
		.secs(secs)
	);
	
	top_module top(
		.clk(clk),
		.reset(reset),
		.pause(pause),
		.sel(sel),
		.adj(adj),
		.seg(seg),
		.an(an)
	);
	
	initial begin
		// Initialize Inputs
		
		clk = 0;
		clk2 = 0;
		reset = 0;
		pause = 0;
		sel = 0;
		adj = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
	end
     
	always begin

		#10 clk = ~clk;
	end
	
	always begin
		#5 clk2 = ~clk2;
	end
	
	initial begin
	
		reset = 1;
		#100
		reset = 0;
	
		adj = 0;
		
		#200
		
		adj = 1;
		sel = 0;
		
		#200
		
		sel = 1;
		#200
		
		pause = 1;
		#200
		
		pause = 0;

		adj = 0;
		sel = 0;

	end
			
endmodule

