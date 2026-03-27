`timescale 1ns / 1ps

module instruction_memory (
    input [31:0] addr,
    output [31:0] instr
);
    reg [31:0] mem [0:255];   // 256 instructions

    initial begin
        $readmemh("program.hex", mem); // hex file
    end

    assign instr = mem[addr[9:2]];  // word aligned
endmodule