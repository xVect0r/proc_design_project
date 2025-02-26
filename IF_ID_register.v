module IF_ID_register(
    input clk,
    input [31:0] nextPCInput,
    input [31:0] instrOutInput,
    output reg [31:0] nextPCOutput,
    output reg [31:0] instrOutOutput,
    input IFIDControl
);

always@(posedge clk) begin
    if(IFIDControl==1'b1) begin
        $display("IF->ID stage execution is taking place");
        nextPCInput <= nextPCOutput;
        instrOutOutput <= instrOutInput;
    end
end

endmodule
