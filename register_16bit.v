module Register16bit(
    input wire [15:0] I,
    input wire E,
    input wire [1:0] FunSel,
    input wire Clock,
    output reg [15:0] Q
);

always @(posedge Clock) begin
    if(E) begin
        case(FunSel)
            2'b00 : Q <= Q - 1;
            2'b01 : Q <= Q + 1;
            2'b10 : Q <= I;
            2'b11 : Q <= 16'b0;
        endcase
    end
    else begin 
        Q <= Q;
    end
end
endmodule
