module leftShift2Bit(
    input [31:0] in_data,
    output reg [31:0] out_data
);

always @(in_data) begin
    out_data = in_data<<2;
end

endmodule