// alu_control.v - logic for ALU decoder
`timescale 1 ns/1 ns
module alu_decoder (
    input            opb5,
    input [2:0]      funct3,
    input            funct7b5,
    input [1:0]      ALUOp,
    output reg [3:0] ALUControl
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 4'b0000;             // addition for lw and sw
        2'b01: ALUControl = 4'b0001;             // subtraction for branch
        2'b10: case (funct3)
            3'b001: ALUControl = 4'b0001;
            3'b100: ALUControl = 4'b0100;
            3'b101: ALUControl = 4'b0100;
            3'b110: ALUControl = 4'b0101;
            3'b111: ALUControl = 4'b0101;
            default: ALUControl = 4'bxxxx; 
        endcase
        2'b11:
            case (funct3) // R-type or I-type ALU
                3'b000: begin
                    // True for R-type subtract
                    if   (funct7b5 & opb5) ALUControl = 4'b0001; //sub
                    else ALUControl = 4'b0000; // add, addi
                end
                3'b010:  ALUControl = 4'b0100; // slt, slti
                3'b011:  ALUControl = 4'b0101; // sltu, sltui
                3'b110:  ALUControl = 4'b0011; // or, ori
                3'b111:  ALUControl = 4'b0010; // and, andi
                3'b100:  ALUControl = 4'b0110; //xor, xori
                3'b001:  ALUControl = 4'b0111; //sll , slli
                3'b101:  ALUControl = (funct7b5) ? 4'b1001 : 4'b1000; //sra ,srai,srl,srli
                default: ALUControl = 4'bxxxx; // ???
            endcase
          default: ALUControl = 4'bxxxx;
    endcase
end

endmodule