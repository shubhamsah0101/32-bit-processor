`timescale 1ns / 1ps

module data_memory(
    input clk,
    input MemRead,
    input MemWrite,
    input [31:0] addr,
    input [31:0] write_data,
    output reg [31:0] read_data
);

    reg [31:0] mem [0:255];

    always @(*) begin
        if (MemRead)
            read_data = mem[addr[9:2]];
        else
            read_data = 32'b0;
    end

    always @(posedge clk) begin
        if (MemWrite)
            mem[addr[9:2]] <= write_data;
    end
endmodule