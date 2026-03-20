`timescale 1ns / 1ps

module Top(clk, reset);
    input wire      clk, reset;

    wire [31:0]     pc, inst;
    wire [31:0]     dmemDataStore, dmemDataRead, dmemAdrs;
    wire [2:0]      dmemMode;
    wire            dmemWE;      

    Single_Cycle_RV32I RV32I_Logic(
        .clk(clk), 
        .reset(reset), 
        .inst(inst),
        .pc(pc),
        .dmemWE(dmemWE), 
        .dmemMode(dmemMode),
        .dmemAdrs(dmemAdrs), 
        .dmemDataRead(dmemDataRead), 
        .dmemDataStore(dmemDataStore));
        
    dmem dataMemory(
        .a(dmemAdrs), 
        .rd(dmemDataRead), 
        .wd(dmemDataStore), 
        .clk(clk), 
        .we(dmemWE),                // Control Logic
        .mode(dmemMode),            // Control Logic
        .reset(reset));

    imem instrMemory (
        .a(pc), 
        .rd(inst));

endmodule