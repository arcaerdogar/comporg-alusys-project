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
    reg [31:0] R1, R2, R3, R4, S1, S2, S3, S4;
    
    always @(posedge Clock) begin
        case(OutASel)
            3'b000: OutA <= R1;
            3'b001: OutA <= R2;
            3'b010: OutA <= R3;
            3'b011: OutA <= R4;
            3'b100: OutA <= S1;
            3'b101: OutA <= S2;
            3'b110: OutA <= S3;
            3'b111: OutA <= S4;
        endcase
        
        case(OutBSel)
            3'b000: OutB <= R1;
            3'b001: OutB <= R2;
            3'b010: OutB <= R3;
            3'b011: OutB <= R4;
            3'b100: OutB <= S1;
            3'b101: OutB <= S2;
            3'b110: OutB <= S3;
            3'b111: OutB <= S4;
        endcase
        
        case(FunSel)
            3'b000: begin
                if (RegSel[3]) R1 <= R1 - 1;
                if (RegSel[2]) R2 <= R2 - 1;
                if (RegSel[1]) R3 <= R3 - 1;
                if (RegSel[0]) R4 <= R4 - 1;

                if (ScrSel[3]) S1 <= S1 - 1;
                if (ScrSel[2]) S2 <= S2 - 1;
                if (ScrSel[1]) S3 <= S3 - 1;
                if (ScrSel[0]) S4 <= S4 - 1;
            end
            3'b001: begin
                if (RegSel[3]) R1 <= R1 + 1;
                if (RegSel[2]) R2 <= R2 + 1;
                if (RegSel[1]) R3 <= R3 + 1;
                if (RegSel[0]) R4 <= R4 + 1;
    
                if (ScrSel[3]) S1 <= S1 + 1;
                if (ScrSel[2]) S2 <= S2 + 1;
                if (ScrSel[1]) S3 <= S3 + 1;
                if (ScrSel[0]) S4 <= S4 + 1;
            end
            3'b010: begin
                if (RegSel[3]) R1 <= I;
                if (RegSel[2]) R2 <= I;
                if (RegSel[1]) R3 <= I;
                if (RegSel[0]) R4 <= I;

                if (ScrSel[3]) S1 <= I;
                if (ScrSel[2]) S2 <= I;
                if (ScrSel[1]) S3 <= I;
                if (ScrSel[0]) S4 <= I;
            end
            3'b011: begin
                if (RegSel[3]) R1 <= 32'b0;
                if (RegSel[2]) R2 <= 32'b0;
                if (RegSel[1]) R3 <= 32'b0;
                if (RegSel[0]) R4 <= 32'b0;

                if (ScrSel[3]) S1 <= 32'b0;
                if (ScrSel[2]) S2 <= 32'b0;
                if (ScrSel[1]) S3 <= 32'b0;
                if (ScrSel[0]) S4 <= 32'b0;
            end
            3'b100: begin
                if (RegSel[3]) R1 <= {24'b0, I[7:0]};
                if (RegSel[2]) R2 <= {24'b0, I[7:0]};
                if (RegSel[1]) R3 <= {24'b0, I[7:0]};
                if (RegSel[0]) R4 <= {24'b0, I[7:0]};

                if (ScrSel[3]) S1 <= {24'b0, I[7:0]};
                if (ScrSel[2]) S2 <= {24'b0, I[7:0]};
                if (ScrSel[1]) S3 <= {24'b0, I[7:0]};
                if (ScrSel[0]) S4 <= {24'b0, I[7:0]};
            end
            3'b101: begin
                if (RegSel[3]) R1 <= {16'b0, I[15:0]};
                if (RegSel[2]) R2 <= {16'b0, I[15:0]};
                if (RegSel[1]) R3 <= {16'b0, I[15:0]};
                if (RegSel[0]) R4 <= {16'b0, I[15:0]};

                if (ScrSel[3]) S1 <= {16'b0, I[15:0]};
                if (ScrSel[2]) S2 <= {16'b0, I[15:0]};
                if (ScrSel[1]) S3 <= {16'b0, I[15:0]};
                if (ScrSel[0]) S4 <= {16'b0, I[15:0]};
            end
            3'b110: begin
                if (RegSel[3]) R1 <= {R1[23:0], I[7:0]};
                if (RegSel[2]) R2 <= {R2[23:0], I[7:0]};
                if (RegSel[1]) R3 <= {R3[23:0], I[7:0]};
                if (RegSel[0]) R4 <= {R4[23:0], I[7:0]};

                if (ScrSel[3]) S1 <= {S1[23:0], I[7:0]};
                if (ScrSel[2]) S2 <= {S2[23:0], I[7:0]};
                if (ScrSel[1]) S3 <= {S3[23:0], I[7:0]};
                if (ScrSel[0]) S4 <= {S4[23:0], I[7:0]};
            end
            3'b111: begin
                if (RegSel[3]) R1 <= {{16{I[15]}}, I[15:0]};
                if (RegSel[2]) R2 <= {{16{I[15]}}, I[15:0]};
                if (RegSel[1]) R3 <= {{16{I[15]}}, I[15:0]};
                if (RegSel[0]) R4 <= {{16{I[15]}}, I[15:0]};

                if (ScrSel[3]) S1 <= {{16{I[15]}}, I[15:0]};
                if (ScrSel[2]) S2 <= {{16{I[15]}}, I[15:0]};
                if (ScrSel[1]) S3 <= {{16{I[15]}}, I[15:0]};
                if (ScrSel[0]) S4 <= {{16{I[15]}}, I[15:0]};
            end
        endcase
    end
endmodule