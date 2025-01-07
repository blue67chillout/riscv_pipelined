`timescale 1 ns/1 ns
// controller.v - controller for RISC-V CPU

module controller (
    input [6:0]  op,
    input [2:0]  funct3,
    input        funct7b5,
    input        Zero,
    output       [1:0] ResultSrc,
    output PCSrc,
    output       MemWrite,
    output       ALUSrc,
    output       RegWrite, Jump,
    output [1:0] ImmSrc,
    output [3:0] ALUControl,
    output jalr,
    output Branch
    
);

wire [1:0] ALUOp;
//wire       Branch;

main_decoder    md (op, funct3,ResultSrc, MemWrite, Branch,
                    ALUSrc, RegWrite, Jump, ImmSrc, ALUOp);

alu_decoder     ad (op[5], funct3, funct7b5, ALUOp, ALUControl);

// for jump and branch
assign PCSrc = (Branch & Zero) | Jump;
assign jalr = (op == 7'b1100111);

endmodule