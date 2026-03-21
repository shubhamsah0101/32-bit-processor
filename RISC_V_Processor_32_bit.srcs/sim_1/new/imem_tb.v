`timescale 1ns / 1ps

module imem_tb();
	reg [31:0]		a = 0;
	wire [31:0]		rd;
	
	imem UUT(
		.a(a),
		.rd(rd)
		);
		
	initial begin
		a <= 0;
		#2
		
		a <= 4;
		#2
		
		a <= 8;
		#2
		
		a <= 12;
		#2	
		
		a <= 16;
		#2
		
		a <= 20;
		#2	
		
		$finish;
	end
	
	initial begin
		$dumpfile("imem_tb.vcd");
		$dumpvars(0, imem_tb);
	end
	
	initial begin
        $readmemh("program.mem", mem);
    end

endmodule