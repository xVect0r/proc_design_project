module ALUControl(
    input [5:0] ALUOperation,
    input [2:0] ALUOpcode,
    output reg [3:0] ALUOutputSignal
);

always @(*) begin
    $display("Deciding the control signal based on the format of the code");

    case (ALUOpcode)
        3'b000: ALUOutputSignal = 4'b0000;
        3'b001: ALUOutputSignal = 4'b0001;
        3'b010: begin
            case (ALUOperation)
                6'b100000: ALUOutputSignal = 4'b0000; 
                6'b100010: ALUOutputSignal = 4'b0001; 
                6'b100100: ALUOutputSignal = 4'b0010; 
                6'b100101: ALUOutputSignal = 4'b0011; 
                default: begin
                    ALUOutputSignal = 4'b1111;
                    $display("Warning: Undefined ALU control signal!");
                end
            endcase
        end
        3'b011: ALUOutputSignal = 4'b0010;
        3'b100: ALUOutputSignal = 4'b0011;
        3'b111: ALUOutputSignal = 4'b0101;
        default: begin
            ALUOutputSignal = 4'b1111;
            $display("Warning: Undefined ALU control signal!");
        end
    endcase
end

endmodule
