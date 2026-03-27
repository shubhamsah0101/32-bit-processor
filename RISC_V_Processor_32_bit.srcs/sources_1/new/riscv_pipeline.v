`timescale 1ns / 1ps

module riscv_pipeline (
    input clk,
    input reset
);

    // ------------------------------
    // IF STAGE
    // ------------------------------

    wire [31:0] pc, next_pc, instr;

    pc PC(clk, reset, next_pc, pc);
    instruction_memory IMEM(pc, instr);

    // IF/ID Register
    wire [31:0] IFID_pc, IFID_instr;
    if_id_reg IFID(clk, reset, pc, instr, IFID_pc, IFID_instr);

    // ------------------------------
    // ID STAGE
    // ------------------------------

    wire [6:0] opcode = IFID_instr[6:0];
    wire [4:0] rs1 = IFID_instr[19:15];
    wire [4:0] rs2 = IFID_instr[24:20];
    wire [4:0] rd  = IFID_instr[11:7];
    wire [2:0] funct3 = IFID_instr[14:12];
    wire funct7 = IFID_instr[30];

    // Control signals
    wire RegWrite, MemRead, MemWrite, MemToReg, Branch, ALUSrc;
    wire [1:0] ALUOp;

    control_unit CU(opcode, RegWrite, MemRead, MemWrite, MemToReg, Branch, ALUSrc, ALUOp);

    // Register file
    wire [31:0] reg1, reg2;
    wire [31:0] wb_data;
    regefile RF(clk, RegWrite_WB, rs1, rs2, rd_WB, wb_data, reg1, reg2);

    // Immediate
    wire [31:0] imm;
    immgen IMM(IFID_instr, imm);

    // ID/EX Register
    wire [31:0] IDEX_pc, IDEX_reg1, IDEX_reg2, IDEX_imm;
    wire [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd;
    wire IDEX_RegWrite, IDEX_MemRead, IDEX_MemWrite, IDEX_MemToReg, IDEX_Branch, IDEX_ALUSrc;
    wire [1:0] IDEX_ALUOp;

    id_ex_reg IDEX(
        clk, reset,
        IFID_pc, reg1, reg2, imm,
        rs1, rs2, rd,
        RegWrite, MemRead, MemWrite, MemToReg, Branch, ALUSrc, ALUOp,
        IDEX_pc, IDEX_reg1, IDEX_reg2, IDEX_imm,
        IDEX_rs1, IDEX_rs2, IDEX_rd,
        IDEX_RegWrite, IDEX_MemRead, IDEX_MemWrite, IDEX_MemToReg,
        IDEX_Branch, IDEX_ALUSrc, IDEX_ALUOp
    );

    // ------------------------------
    // EX STAGE
    // ------------------------------

    // ALU control
    wire [3:0] alu_ctrl;
    alu_control ALUCTRL(IDEX_ALUOp, funct3, funct7, alu_ctrl);

    // ALU input B selection
    wire [31:0] alu_in2 = (IDEX_ALUSrc) ? IDEX_imm : IDEX_reg2;

    // ALU itself
    wire [31:0] alu_result;
    wire zero;
    alu ALU(IDEX_reg1, alu_in2, alu_ctrl, alu_result, zero);

    // Branch target
    wire [31:0] branch_addr = IDEX_pc + IDEX_imm;

    // EX/MEM Register
    wire [31:0] EXMEM_alu, EXMEM_reg2, EXMEM_branch_target;
    wire [4:0] EXMEM_rd;
    wire EXMEM_RegWrite, EXMEM_MemRead, EXMEM_MemWrite, EXMEM_MemToReg, EXMEM_Branch, EXMEM_zero;

    ex_mem_reg EXMEM(
        clk, reset,
        alu_result, IDEX_reg2, IDEX_rd,
        IDEX_RegWrite, IDEX_MemRead, IDEX_MemWrite, IDEX_MemToReg, IDEX_Branch,
        zero, branch_addr,
        EXMEM_alu, EXMEM_reg2, EXMEM_rd,
        EXMEM_RegWrite, EXMEM_MemRead, EXMEM_MemWrite, EXMEM_MemToReg, EXMEM_Branch,
        EXMEM_zero, EXMEM_branch_target
    );

    // ------------------------------
    // MEM STAGE
    // ------------------------------

    wire [31:0] mem_data;
    data_memory DMEM(clk, EXMEM_MemRead, EXMEM_MemWrite, EXMEM_alu, EXMEM_reg2, mem_data);

    // Branch decision
    assign next_pc = (EXMEM_Branch && EXMEM_zero) ? EXMEM_branch_target : (pc + 4);

    // MEM/WB Register
    wire [31:0] MEMWB_mem, MEMWB_alu;
    wire [4:0] MEMWB_rd;
    wire MEMWB_RegWrite, MEMWB_MemToReg;

    mem_wb_reg MEMWB(
        clk, reset,
        mem_data, EXMEM_alu, EXMEM_rd,
        EXMEM_RegWrite, EXMEM_MemToReg,
        MEMWB_mem, MEMWB_alu, MEMWB_rd,
        MEMWB_RegWrite, MEMWB_MemToReg
    );

    // ------------------------------
    // WB STAGE
    // ------------------------------

    assign wb_data = (MEMWB_MemToReg) ? MEMWB_mem : MEMWB_alu;
    wire RegWrite_WB = MEMWB_RegWrite;
    wire [4:0] rd_WB  = MEMWB_rd;

endmodule