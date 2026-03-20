`timescale 1ns / 1ps

module dmem(a, rd, wd, clk, we, mode, reset);

    input wire clk, we, reset;
    input wire [2:0] mode;
    input wire [31:0] a, wd;
    output reg [31:0] rd;

    reg [7:0] mem [0:255];

    integer i;

    // Initialization
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 8'h00;
        end
    end

    // WRITE (Synchronous)
    always @(posedge clk) begin
        if (we) begin
            case (mode)
                3'b000: {mem[a], mem[a+1], mem[a+2], mem[a+3]} <= wd;
                3'b001: {mem[a], mem[a+1]} <= wd[15:0];
                3'b101: {mem[a], mem[a+1]} <= wd[15:0];
                3'b010: mem[a] <= wd[7:0];
                3'b110: mem[a] <= wd[7:0];
                default:{mem[a], mem[a+1], mem[a+2], mem[a+3]} <= wd;
            endcase
        end
    end

    // READ (Combinational)
    always @(*) begin
        case (mode)
            3'b000: rd = {mem[a], mem[a+1], mem[a+2], mem[a+3]};
            3'b001: rd = {16'b0, mem[a], mem[a+1]};
            3'b101: rd = {{16{mem[a][7]}}, mem[a], mem[a+1]};
            3'b010: rd = {24'b0, mem[a]};
            3'b110: rd = {{24{mem[a][7]}}, mem[a]};
            default:rd = {mem[a], mem[a+1], mem[a+2], mem[a+3]};
        endcase
    end

    // RESET (Synchronous)
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1) begin
                mem[i] <= 8'h00;
            end
        end
    end

endmodule