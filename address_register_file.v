module AddressRegisterFile(
    input wire [31:0] I,
    input wire [2:0] RegSel,
    input wire [1:0] FunSel, OutCSel, OutDSel,
    output reg [15:0] OutC, OutD,
    input wire Clock
    );
    Register16bit PC(.I(I), .E(RegSel[2]), .FunSel(FunSel), .Clock(Clock), .Q(Q));
    Register16bit SP(.I(I), .E(RegSel[1]), .FunSel(FunSel), .Clock(Clock), .Q(Q));
    Register16bit AR(.I(I), .E(RegSel[0]), .FunSel(FunSel), .Clock(Clock), .Q(Q));
    
    always @* begin
        case(OutCSel)
            2'b00: OutC = PC.Q;
            2'b01: OutC = SP.Q;
            2'b10: OutC = AR.Q;
            2'b11: OutC = AR.Q;
        endcase
        
        case(OutDSel)
            2'b00: OutD = PC.Q;
            2'b01: OutD = SP.Q;
            2'b10: OutD = AR.Q;
            2'b11: OutD = AR.Q;
        endcase
    end
endmodule