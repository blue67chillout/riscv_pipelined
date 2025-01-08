module IF_ID_reg (

    input clk,
    input rst,
    input IF_ID_regwrite,
    input [31:0] pcF,
    input [31:0] InstF,
    input [31:0] pc4F,
    output reg [31:0] InstD,
    output reg [31:0] pcD,
    output reg [31:0] pc4D

);
    
    always @(posedge clk) begin
        if(rst) begin

            InstD <= 0;
            pcD <= 0;
            pc4D <= 0;
        
        end

        else if(IF_ID_regwrite) begin
            
            InstD <= InstF;
            pcD <= pc4F;
            pc4D <= pc4F
        
        end
    end



endmodule