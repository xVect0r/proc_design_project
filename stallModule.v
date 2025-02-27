module stallUnit(
    input clk,
    input [4:0] Rs,
    input [4:0] Rt,
    input [5:0] InstOpCode,
    input [31:0] IR_ID,
    input [31:0] IR_EX,
    input [31:0] IR_MEM,
    input [4:0] regWB,
    input WWB,
    input [31:0] IR_WB,
    output reg stallFlag
);

reg We1,We2,We3;
reg [4:0]Ws1,Ws2,Ws3;
reg Res,Ret;

initial begin
    stallFlag=1'b1;
    We1=1'b0;
    We2=1'b0;
    We3=1'b0;
    Res=1'b0;
    Ret=1'b0;
end

always @(posedge clk)begin
    if(IR_ID != 32'b0)begin
        case(InstOpCode)
            //Rtype
            6'b0:begin
                Res=1'b1;
                Ret=1'b1;
            end
            6'b100011:begin//lw
                Res=1'b1;
                Ret=1'b0;
            end
            6'b101011:begin//sw
                Res=1'b1;
                Ret=1'b1;
            end
            6'b000010:begin//jump
                Res=1'b0;
                Ret=1'b0;
            end
            6'b100:begin//beq
                Res=1'b1;
                Ret=1'b1;
            end
            6'b101:begin//bne
                Res=1'b1;
                Ret=1'b1;
            end
            default begin//IType
                Res=1'b1;
                Ret=1'b0;
            end
        endcase
    end
    else begin
        Res=1'b0;
        Ret=1'b0;
    end

    //
    if(IR_EX != 32'b0)begin
        case(IR_EX[31:26])//we1,ws1
        //Rtype:opcode 6bit and function
            6'b0:begin
                We1=1'b1;
                Ws1=IR_EX[15:11];
            end		 
            6'b100011:begin//lw
                We1=1'b1;
                Ws1=IR_EX[20:16];
            end
            6'b101011:begin//sw
                We1=1'b0;
                Ws1=5'b0;
            end
            6'b000010:begin//jump
                We1=1'b0;
                Ws1=5'b0;
            end
            6'b100:begin//beq
                We1=1'b0;
                Ws1=5'b0;
            end
            6'b101:begin//bne
                We1=1'b0;
                Ws1=5'b0;
            end
            default begin//IType
                We1=1'b1;
                Ws1=IR_EX[20:16];
            end
        endcase
    end
    else begin
        We1=1'b0;
    end

    //
    if(IR_MEM != 32'b0)begin
        case(IR_MEM[31:26])//we2,ws2
        //Rtype:opcode 6bit and function 6bit
            6'b0:begin
                We2=1'b1;
                Ws2=IR_EX[15:11];
            end
            6'b100011:begin//lw
                We2=1'b1;
                Ws2=IR_EX[20:16];
            end
            6'b101011:begin//sw
                We2=1'b0;
                Ws2=5'b0;
            end
            6'b000010:begin//jump
                We2=1'b0;
                Ws2=5'b0;
            end
            6'b100:begin//beq
                We2=1'b0;
                Ws2=5'b0;
            end
            6'b101:begin//bne
                We2=1'b0;
                Ws2=5'b0;
            end
            default begin//IType
                We2=1'b1;
                Ws2=IR_EX[20:16];
            end
        endcase
    end
    else begin
        We2=1'b0;
    end

    //
    if(IR_WB != 32'b0)begin
        We3=WWB;
        Ws3=regWB;
    end
    else begin
        We3=1'b0;
    end
    stallFlag=~((((Rs==Ws1)&We1) + ((Rs==Ws2)&We2) + ((Rs==Ws3)&We3))&Res + (((Rt==Ws1)&We1) + ((Rt==Ws2)&We2) + ((Rt==Ws3)&We3))&Ret);

end
endmodule