`timescale 1ns / 1ps

module id_ex_reg(
    input clk, reset,
    input [31:0] pc_in, reg1_in, reg2_in, imm_in,
    input [4:0] rs1_in, rs2_in, rd_in,
    input RegWrite_in, MemRead_in, MemWrite_in, MemToReg_in, Branch_in, ALUSrc_in,
    input [1:0] ALUOp_in,

    output reg [31:0] pc_out, reg1_out, reg2_out, imm_out,
    output reg [4:0] rs1_out, rs2_out, rd_out,
    output reg RegWrite_out, MemRead_out, MemWrite_out, MemToReg_out, Branch_out, ALUSrc_out,
    output reg [1:0] ALUOp_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 0;
            reg1_out <= 0;
            reg2_out <= 0;
            imm_out <= 0;
            rs1_out <= 0;
            rs2_out <= 0;
            rd_out <= 0;
            RegWrite_out <= 0;
            MemRead_out <= 0;
            MemWrite_out <= 0;
            MemToReg_out <= 0;
            Branch_out <= 0;
            ALUSrc_out <= 0;
            ALUOp_out <= 0;
        end else begin
            pc_out <= pc_in;
            reg1_out <= reg1_in;
            reg2_out <= reg2_in;
            imm_out <= imm_in;
            rs1_out <= rs1_in;
            rs2_out <= rs2_in;
            rd_out <= rd_in;
            RegWrite_out <= RegWrite_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            MemToReg_out <= MemToReg_in;
            Branch_out <= Branch_in;
            ALUSrc_out <= ALUSrc_in;
            ALUOp_out <= ALUOp_in;
        end
    end
endmodule
