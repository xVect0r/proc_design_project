module progCounterRegWrite(
    input [31:0] instAddress_in,
    input controlPC,
    output reg [31:0] instAddress_out
);

// Start at first instruction
initial begin
    $display("Program starts execution");
    instAddress_out = 32'b0;
end

// Move to given instruction
always @(instAddress_in or controlPC) begin
    $display("Program progresses at signal from Control");
    if (controlPC == 1'b1) 
        instAddress_out = instAddress_in;
end

endmodule
