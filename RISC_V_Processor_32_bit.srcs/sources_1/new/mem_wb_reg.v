`timescale 1ns / 1ps

module mem_wb_reg(
    input clk, reset,

    input [31:0] mem_in,
    input [31:0] alu_in,
    input [4:0] rd_in,

    input RegWrite_in, MemToReg_in,

    output reg [31:0] mem_out,
    output reg [31:0] alu_out,
    output reg [4:0] rd_out,

    output reg RegWrite_out, MemToReg_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            mem_out <= 0;
            alu_out <= 0;
            rd_out <= 0;
            RegWrite_out <= 0;
            MemToReg_out <= 0;
        end
        else begin
            mem_out <= mem_in;
            alu_out <= alu_in;
            rd_out <= rd_in;
            RegWrite_out <= RegWrite_in;
            MemToReg_out <= MemToReg_in;
        end
    end
endmodule