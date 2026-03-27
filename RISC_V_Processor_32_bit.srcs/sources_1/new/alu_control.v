`timescale 1ns / 1ps

module alu_control(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input funct7,
    output reg [3:0] alu_ctrl
);
    always @(*) begin
        case (ALUOp)
            2'b00: alu_ctrl = 4'b0010; // add for load/store
            2'b01: alu_ctrl = 4'b0110; // subtract for branch
            2'b10: begin
                case ({funct7, funct3})
                    4'b0000: alu_ctrl = 4'b0010; // add
                    4'b1000: alu_ctrl = 4'b0110; // sub
                    4'b0111: alu_ctrl = 4'b0000; // and
                    4'b0110: alu_ctrl = 4'b0001; // or
                    default: alu_ctrl = 4'b0000;
                endcase
            end
            default: alu_ctrl = 4'b0000;
        endcase
    end
endmodule