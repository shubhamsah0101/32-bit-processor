`timescale 1ns / 1ps

module hazard_unit(
    input MemRead_IDEX,
    input [4:0] rd_IDEX,
    input [4:0] rs1_IFID,
    input [4:0] rs2_IFID,
    output reg stall
);

    always @(*) begin
        if (MemRead_IDEX && ((rd_IDEX == rs1_IFID) || (rd_IDEX == rs2_IFID)))
            stall = 1;
        else
            stall = 0;
    end
endmodule