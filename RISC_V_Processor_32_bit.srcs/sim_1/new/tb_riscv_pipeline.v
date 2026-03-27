`timescale 1ns/1ps

module tb_riscv_pipeline;

    reg clk;
    reg reset;

    // Instantiate DUT
    riscv_pipeline DUT (
        .clk(clk),
        .reset(reset)
    );

    // Clock: 10 ns period (100 MHz)
    always #5 clk = ~clk;

    // Reset logic
    initial begin
        clk = 0;
        reset = 1;

        // Hold reset for 3 cycles
        #20;
        reset = 0;
    end

    // Initialize instruction memory manually if required
    initial begin
        // Optional: Load your own program file (if your IMEM supports it)
//         $readmemh("program.hex", DUT.IMEM.memory);

        // Example program: Add, load, store, branch (modify as needed)
        /*
        DUT.IMEM.memory[0] = 32'h00208093; // addi x1, x1, 2
        DUT.IMEM.memory[1] = 32'h00310113; // addi x2, x2, 3
        DUT.IMEM.memory[2] = 32'h002081b3; // add x3, x1, x2
        DUT.IMEM.memory[3] = 32'h0031a023; // sw x3, 0(x3)
        DUT.IMEM.memory[4] = 32'h0031a503; // lw x10, 0(x3)
        DUT.IMEM.memory[5] = 32'hfe519ae3; // beq x3, x2, loop
        */

        #10;
    end

    // Dump VCD file for waveform
    initial begin
        $dumpfile("riscv_pipeline.vcd");
        $dumpvars(0, tb_riscv_pipeline);

        // Run for N cycles then stop
        #2000;
        $finish;
    end

endmodule