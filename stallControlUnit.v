module stallControlUnit(
    input clk,
    input [5:0] Operand1,
    input [5:0] Operand2,
    input [5:0] Operand3,
    output reg stallFlag
);

initial begin
    stallFlag=1'b1;
end

always @(posedge clk)begin


    if(Operand1==6'b000100 | Operand1==6'b000101 | Operand1==6'b000010)begin// beq or bne or j
        stallFlag=1'b0;
    end

    if(Operand2==6'b000100 | Operand2==6'b000101 | Operand2==6'b000010)begin// beq or bne or j
        stallFlag=1'b0;
    end

    if(Operand3==6'b000100 | Operand3==6'b000101 | Operand3==6'b000010)begin// beq or bne or j
        stallFlag=1'b0;
    end

    else begin
        stallFlag=1'b1;
    end

end

endmodule

module nopSet(
    input clk,
    input S1,
    input S2,
    input [31:0] OldF,
    input [31:0]OldD,
    output reg [31:0] NewF,
    output reg [31:0] NewD
);

    always @(posedge clk)begin
        if(S1==1'b0 && S2==1'b0)begin
            NewF=32'b0;
            NewD=32'b0;
        end
        else if(S1==1'b0 && S2==1'b1)begin
            NewD=32'b0;
        end
        else if(S1==1'b1 && S2==1'b0)begin
            NewF=32'b0;
        end
        else
        begin
            NewD=OldD;
            NewF=OldF;
        end
    end
endmodule