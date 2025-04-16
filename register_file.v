module RegisterFile(
    input wire [31:0] I,
    input wire Clock,
    input wire [2:0] FunSel,
    input wire [2:0] OutASel,
    input wire [2:0] OutBSel,
    input wire [3:0] RegSel,
    input wire [3:0] ScrSel,
    output reg [31:0] OutA, OutB
    );
    Register32bit R1(.I(I), .FunSel(FunSel), .Clock(Clock), .E(RegSel[3]));
    Register32bit R2(.I(I), .FunSel(FunSel), .Clock(Clock), .E(RegSel[2]));
    Register32bit R3(.I(I), .FunSel(FunSel), .Clock(Clock), .E(RegSel[1]));
    Register32bit R4(.I(I), .FunSel(FunSel), .Clock(Clock), .E(RegSel[0]));
    
    Register32bit S1(.I(I), .FunSel(FunSel), .Clock(Clock), .E(ScrSel[3]));
    Register32bit S2(.I(I), .FunSel(FunSel), .Clock(Clock), .E(ScrSel[2]));
    Register32bit S3(.I(I), .FunSel(FunSel), .Clock(Clock), .E(ScrSel[1]));
    Register32bit S4(.I(I), .FunSel(FunSel), .Clock(Clock), .E(ScrSel[0]));
    
    always @* begin
        case(OutASel)
            3'b000: OutA = R1.Q;
            3'b001: OutA = R2.Q;
            3'b010: OutA = R3.Q;
            3'b011: OutA = R4.Q;
            3'b100: OutA = S1.Q;
            3'b101: OutA = S2.Q;
            3'b110: OutA = S3.Q;
            3'b111: OutA = S4.Q;
        endcase
        
        case(OutBSel)
            3'b000: OutB = R1.Q;
            3'b001: OutB = R2.Q;
            3'b010: OutB = R3.Q;
            3'b011: OutB = R4.Q;
            3'b100: OutB = S1.Q;
            3'b101: OutB = S2.Q;
            3'b110: OutB = S3.Q;
            3'b111: OutB = S4.Q;
        endcase
    end
endmodule