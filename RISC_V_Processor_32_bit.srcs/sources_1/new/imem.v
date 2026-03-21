`timescale 1ns / 1ps

module imem(a, rd);

    input wire [31:0] a;
    output wire [31:0] rd;

    reg [31:0] mem [0:255];

    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 32'h00000013;
        end

        $readmemh("program.mem", mem);
    end

    assign rd = mem[a[9:2]];

endmodule