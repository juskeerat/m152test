`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:57:41 05/11/2023
// Design Name:   clocks
// Module Name:   C:/Users/Student/Desktop/group1_lab5/lab3/clocks_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clocks
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clocks_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire onehz_clk;
	wire twohz_clk;
	wire fast_clk;
	wire blink_clk;

	// Instantiate the Unit Under Test (UUT)
	clocks uut (
		.sys_clk(clk), 
		.rst(rst), 
		.onehz_clk(onehz_clk), 
		.twohz_clk(twohz_clk), 
		.fast_clk(fast_clk), 
		.blink_clk(blink_clk)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

