`include "Processor_MIPS.v"

module TB;
reg clk;
Mypip sc1(clk);

initial begin
    clk=1'b0;
    forever begin
        #3 clk =~clk;
    end
end

initial begin
    #100 $finish();
end



endmodule