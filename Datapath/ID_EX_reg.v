module ID_EX_reg (
    input clk,
    input rst,

    input [4:0]rs1nD,  //rs1 reg number
    input [4:0]rs2nD,  //rs2 reg number
    input [4:0]rdnD    //rd reg number

    output [4:0]rs1nE,
    output [4:0]rs2nE,  
    output [4:0]rdnE,   

    input [31:0] rs1D,
    input [31:0] rs2D,
    input [31:0] immD,

    output [31:0] rs1E,
    output [31:0] rs2E, 
    output [31:0] immE,

    //control signals

    ///////////////............WB ..........///////////////

    input RegWriteD,
    input ResultSrcD,

    output RegWriteE,
    output ResultSrcE,
    
    ///////////////............MEM ..........///////////////

    input MemWriteD,
    output MemWriteE,

    ///////////////............EX ..........///////////////

    input ALUControlD,
    input ALUSrcD,
    output ALUControlE,
    output ALUSrcE
);
    
    always @(posedge clk) begin
        if(rst) begin
            rs1E <=0;
            rs1nE <=0;
            rs2E <=0;
            rs2nE <=0;
            rdnE <=0;
            immE <=0;
            RegWriteE <=0;
            ResultSrcE <=0;
            MemWriteE <=0;
            ALUControlE <=0;
            ALUSrcE <=0;
        end

        else begin
            rs1E <=rs1D;
            rs1nE <=rs1nD;
            rs2E <=rs2D;
            rs2nE <=rs2nD;
            rdnE <=rdnD;
            immE <=immD;
            RegWriteE <=RegWriteD;
            ResultSrcE <=ResultSrcD;
            MemWriteE <=MemWriteD;
            ALUControlE <=ALUControlD;
            ALUSrcE <=ALUSrcD;
        end
    end



endmodule