`timescale 1ns / 1ps

module mux2(a, b, sel, y);
	parameter WIDTH = 32;
	
	input wire [WIDTH - 1:0]	a, b;
	input wire 					sel;
	output wire [WIDTH - 1:0]	y;

	assign y = sel ? b : a;

endmodule