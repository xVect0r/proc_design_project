module valueExtender(
    input [15:0] inpData,
    output reg [31:0] outData
);

always @(inpData) begin
    $display("Value of the input datat is preserved with sign");
    outData[15:0] = {inpData};
    outData[31:16] = {16{inpData[15]}};

end
endmodule