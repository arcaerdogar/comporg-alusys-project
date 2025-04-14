module DataRegister(
    input wire [7:0] I,
    input wire E,
    input wire [1:0] FunSel,
    input wire Clock,
    output reg [31:0] DROut
    );
    
    always @(posedge Clock) begin
        if(E) begin
            case(FunSel)
                2'b00: DROut <= {{24{I[7]}},I[7:0]};
                2'b01: DROut <= {24'b0,I[7:0]};
                2'b10: DROut <= {DROut[23:0],I[7:0]};
                2'b11: DROut <= {I[7:0],DROut[31:8]};
            endcase
        end
        else DROut <= DROut;
    end
endmodule
