`timescale 1ns / 1ps

module adder(a, b, y);
	parameter WIDTH = 32;
	
	input wire [WIDTH - 1:0]	a, b;
	output wire [WIDTH - 1:0]	y;

	assign y = a + b;

endmodule