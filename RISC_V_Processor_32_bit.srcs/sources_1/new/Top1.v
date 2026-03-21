`timescale 1ns / 1ps

module Top1(
    input wire clk,
    input wire reset,
    output wire [31:0] debug
);

    wire [31:0] pc, inst;
    wire [31:0] dmemDataStore, dmemDataRead, dmemAdrs;
    wire [2:0]  dmemMode;
    wire        dmemWE;

    assign debug = pc ^ inst ^ dmemAdrs ^ dmemDataRead;

    // CPU
    Single_Cycle_RV32I RV32I_Logic(
        .clk(clk), 
        .reset(reset), 
        .inst(inst),
        .pc(pc),
        .dmemWE(dmemWE), 
        .dmemMode(dmemMode),
        .dmemAdrs(dmemAdrs), 
        .dmemDataRead(dmemDataRead), 
        .dmemDataStore(dmemDataStore)
    );
        
    // Data Memory
    dmem dataMemory(
        .a(dmemAdrs), 
        .rd(dmemDataRead), 
        .wd(dmemDataStore), 
        .clk(clk), 
        .we(dmemWE),
        .mode(dmemMode),
        .reset(reset)
    );

    // Instruction Memory
    imem instrMemory (
        .a(pc), 
        .rd(inst)
    );

endmodule