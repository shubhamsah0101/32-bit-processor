`timescale 1ns / 1ps

module imem(a, rd);
	input wire [31:0]	a;
	output wire [31:0]	rd;
	
	reg [31:0] mem [0:63];

	parameter INITIAL_DATA_PATH = "../../source/imem.dat";
	
	initial
		$readmemh(INITIAL_DATA_PATH, mem);
	
	
	assign rd = mem[a[31:2]];

endmodule