`timescale 1 ns/1 ns
// main_decoder.v - logic for main decoder

module main_decoder (
    input  [6:0] op,
    input  [2:0] funct3,
    output [1:0] ResultSrc,
    output       MemWrite, Branch, ALUSrc,
    output       RegWrite, Jump,
    output [1:0] ImmSrc,
    output [1:0] ALUOp
);

reg [10:0] controls;

always @(*) begin
    case (op)
              // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump_pcsrc
        7'b0000011: controls = 11'b1_00_1_0_01_0_00_0; // lw
        7'b0100011: controls = 11'b0_01_1_1_00_0_00_0; // sw
        7'b0110011: controls = 11'b1_xx_0_0_00_0_11_0; // R–type
       
        7'b1100011: begin // branch
            
            case (funct3)
                3'b000: controls = 11'b0_10_0_0_00_1_01_0; // beq
                3'b001: controls = 11'b0_10_0_0_00_1_10_0; // bne
                3'b100: controls = 11'b0_10_0_0_00_1_10_0; // blt
                3'b101: controls = 11'b0_10_0_0_00_1_10_0; // bge
                3'b110: controls = 11'b0_10_0_0_00_1_10_0; //bltu
                3'b111: controls = 11'b0_10_0_0_00_1_10_0; //bgeu

                default: controls = 11'bx_xx_x_x_xx_x_xx_x;
            endcase
        end

        7'b0010011: controls = 11'b1_00_1_0_00_0_11_0; // I–type ALU
        7'b1101111: controls = 11'b1_11_0_0_10_0_00_1; // jal
        7'b1100111: controls = 11'b1_00_1_0_10_0_00_1; // jalr
        7'b0110111: controls = 11'b1_xx_1_0_11_0_00_0; // lui
        7'b0010111: controls = 11'b1_xx_1_0_11_0_00_0; // auipc

        default:    controls = 11'bx_xx_x_x_xx_x_xx_x; // ???
    endcase
end

assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump} = controls;


endmodule