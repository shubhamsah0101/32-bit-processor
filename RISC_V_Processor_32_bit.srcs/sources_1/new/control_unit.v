`timescale 1ns / 1ps

module control_unit(
    input [6:0] opcode,
    output reg RegWrite, MemRead, MemWrite, MemToReg,
    output reg Branch, ALUSrc,
    output reg [1:0] ALUOp
);
    always @(*) begin
        case(opcode)
            7'b0110011: begin // R-type
                RegWrite=1; MemRead=0; MemWrite=0; MemToReg=0;
                Branch=0; ALUSrc=0; ALUOp=2;
            end
            7'b0010011: begin // I-type ALU
                RegWrite=1; MemRead=0; MemWrite=0; MemToReg=0;
                Branch=0; ALUSrc=1; ALUOp=2;
            end
            7'b0000011: begin // Load
                RegWrite=1; MemRead=1; MemWrite=0; MemToReg=1;
                Branch=0; ALUSrc=1; ALUOp=0;
            end
            7'b0100011: begin // Store
                RegWrite=0; MemRead=0; MemWrite=1; MemToReg=0;
                Branch=0; ALUSrc=1; ALUOp=0;
            end
            7'b1100011: begin // Branch
                RegWrite=0; MemRead=0; MemWrite=0; MemToReg=0;
                Branch=1; ALUSrc=0; ALUOp=1;
            end
            default: begin
                RegWrite=0; MemRead=0; MemWrite=0; MemToReg=0;
                Branch=0; ALUSrc=0; ALUOp=0;
            end
        endcase
    end
endmodule