`timescale 1ns / 1ps

module ex_mem_reg(
    input clk, reset,

    input [31:0] alu_in,
    input [31:0] reg2_in,
    input [4:0] rd_in,

    input RegWrite_in, MemRead_in, MemWrite_in, MemToReg_in, Branch_in,
    input zero_in,
    input [31:0] branch_target_in,

    output reg [31:0] alu_out,
    output reg [31:0] reg2_out,
    output reg [4:0] rd_out,

    output reg RegWrite_out, MemRead_out, MemWrite_out, MemToReg_out, Branch_out,
    output reg zero_out,
    output reg [31:0] branch_target_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            alu_out <= 0;
            reg2_out <= 0;
            rd_out <= 0;
            RegWrite_out <= 0;
            MemRead_out <= 0;
            MemWrite_out <= 0;
            MemToReg_out <= 0;
            Branch_out <= 0;
            zero_out <= 0;
            branch_target_out <= 0;
        end
        else begin
            alu_out <= alu_in;
            reg2_out <= reg2_in;
            rd_out <= rd_in;
            RegWrite_out <= RegWrite_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            MemToReg_out <= MemToReg_in;
            Branch_out <= Branch_in;
            zero_out <= zero_in;
            branch_target_out <= branch_target_in;
        end
    end
endmodule