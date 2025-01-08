module EX_MEM_reg (
    input clk,
    input rst,

    input [31:0]AluoutE,
    input [4:0]rdE,
    input [31:0]Mem_dataE,

    output reg [31:0]AluoutM,
    output reg [4:0]rdM,
    output reg [31:0]Mem_dataM,

    //control signals

    ///////////////............WB ..........///////////////

    input RegWriteE,
    input ResultSrcE,

    output reg RegWriteM,
    output reg ResultSrcM,
    
    ///////////////............MEM ..........///////////////

    input MemWriteE,
    output reg MemWriteM

   
);

always @(posedge clk) begin
    if(rst) begin
        AluoutM <=0;
        rdM <=0;
        Mem_dataM <=0;
        RegWriteM <=0;
        ResultSrcM <=0;
        MemWriteM <=0;
    end

    else begin
        AluoutM <=AluoutE;
        rdM <=rdE;
        Mem_dataM <=Mem_dataE;
        RegWriteM <=RegWriteE;
        ResultSrcM <=ResultSrcE;
        MemWriteM <=MemWriteE;
    end
end
    
endmodule