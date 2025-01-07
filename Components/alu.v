`timescale 1 ns/1 ns
module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [3:0] alu_ctrl,         // ALU control
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      zero,
    input funct3_0                    // zero flag
);

always @(a, b, alu_ctrl) begin
    case (alu_ctrl)
        4'b0000:  alu_out <= a + b;       // ADD,ADDI
        4'b0001:  alu_out <= a + ~b + 1;  // SUB
        4'b0010:  alu_out <= a & b;       // AND,ANDI
        4'b0011:  alu_out <= a | b;       // OR,ORI
        4'b0110:  alu_out <= a ^ b;       //XOR,XORI
        4'b0101:  alu_out <= (a < b) ? 1:0;  //SLTU,SLTUI
        4'b0111:  alu_out <= a << b;   // SLL,SLLI
        4'b1000:  alu_out <= a >> b;   // SRL ,SRLI
        4'b1001:  alu_out <= $signed(a) >>> b;  // SRA .SRAI
        4'b0100:  begin                   // SLT,SLTI
                     if (a[31] != b[31]) alu_out <= a[31] ? 1 : 0;
                     else alu_out <= a < b ? 1 : 0;
                 end
        default: alu_out = 0;
    endcase
end

assign zero = ((alu_out == 0 && !funct3_0 && alu_ctrl == 4'b0001) || (alu_out != 0 && funct3_0 && alu_ctrl == 4'b0001) || 
               (alu_out == 1 && !funct3_0 && alu_ctrl == 4'b0100) || (alu_out == 0 && funct3_0 && alu_ctrl == 4'b0100) ||
               (alu_out == 1 && !funct3_0 && alu_ctrl == 4'b0101) || (alu_out == 0 && funct3_0 && alu_ctrl == 4'b0101) 
               ) ? 1'b1 : 1'b0;

endmodule