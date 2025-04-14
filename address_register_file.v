`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2025 21:19:04
// Design Name: 
// Module Name: adress_register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AddressRegisterFile(
    input wire [15:0] I,
    input wire [2:0] RegSel,
    input wire [1:0] FunSel, OutASel, OutBSel, OutCSel, OutDSel,
    output reg [15:0] OutC, OutD,
    input wire Clock
    );
    Register16bit PC(.I(I), .E(E), .FunSel(FunSel), .Clock(clk.clock), .Q(Q));
    Register16bit SP(.I(I), .E(E), .FunSel(FunSel), .Clock(clk.clock), .Q(Q));
    Register16bit AR(.I(I), .E(E), .FunSel(FunSel), .Clock(clk.clock), .Q(Q));
    
    always @(posedge Clock) begin
        case(OutCSel)
            2'b00: OutC <= PC.Q;
            2'b01: OutC <= SP.Q;
            2'b10: OutC <= AR.Q;
            2'b11: OutC <= AR.Q;
        endcase
        
        case(OutDSel)
            2'b00: OutD <= PC.Q;
            2'b01: OutD <= SP.Q;
            2'b10: OutD <= AR.Q;
            2'b11: OutD <= AR.Q;
        endcase
    end
endmodule
