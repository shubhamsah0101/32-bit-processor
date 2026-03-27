`timescale 1ns / 1ps

module immgen(
    input [31:0] instr,
    output reg [31:0] imm
);
    wire [6:0] opcode = instr[6:0];

    always @(*) begin
        case(opcode)
            7'b0010011, // I-type
            7'b0000011: imm = {{20{instr[31]}}, instr[31:20]};

            7'b0100011: imm = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type

            7'b1100011: imm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type

            default: imm = 0;
        endcase
    end
endmodule