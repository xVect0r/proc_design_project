module JumpAddressGeneration(
    input [3:0] addr_inp1, 
    input [25:0] addr_inp2, 
    output reg [31:0] jumpAddress
);

always @(addr_inp1, addr_inp2) begin
    jumpAddress= {addr_inp1,addr_inp2,2'b0};
end

endmodule