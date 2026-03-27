`timescale 1ns / 1ps

module regefile(
    input clk,
    input RegWrite,
    input [4:0] rs1, rs2, rd,
    input [31:0] write_data,
    output [31:0] reg1, reg2
);
    reg [31:0] regs [0:31];

    // Read
    assign reg1 = (rs1 == 0) ? 0 : regs[rs1];
    assign reg2 = (rs2 == 0) ? 0 : regs[rs2];

    // Write
    always @(posedge clk) begin
        if (RegWrite && rd != 0)
            regs[rd] <= write_data;
    end
endmodule