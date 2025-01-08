module MEM_WB_reg (
    input clk,
    input rst,

    input  [31:0] ALUResultM,
    input  [31:0] ReadDataM,
    input  [4:0] rdM,

    output [31:0] ALUResultW,
    output [31:0] ReadDataW,
    output [4:0] rdW

);

always @(posedge clk) begin

    if(rst) begin
        ALUResultW <=0;
        ReadDataW <=0;
        rdW <=0;
    end

    else begin
        ALUResultW <=ALUResultM;
        ReadDataW <=ReadDataM;
        rdW <=rdM;
end
end
    
endmodule