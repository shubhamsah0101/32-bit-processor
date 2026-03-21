`timescale 1ns / 1ps

module tb_top;

    // Inputs
    reg clk;
    reg reset;

    // Instantiate DUT
    Top1 uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset sequence
    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    // Run simulation
    initial begin
        #1000;
        $finish;
    end

    // Monitor key signals (HIERARCHICAL ACCESS)
    initial begin
        $monitor("T=%0t | PC=%h | INST=%h | ALU=%h | MEM_ADDR=%h | MEM_WD=%h | MEM_RD=%h",
            $time,
            uut.pc,
            uut.inst,
            uut.RV32I_Logic.alu_result,   // adjust if name differs
            uut.dmemAdrs,
            uut.dmemDataStore,
            uut.dmemDataRead
        );
    end

endmodule