module ArithmeticLogicUnit(
    input wire [31:0] A, B,
    input wire [4:0] FunSel,
    input wire WF,
    output wire [31:0] ALUOut,
    output reg [3:0] FlagsOut,
    input wire Clock
    );
    
    wire [16:0] sum16 = {1'b0, A[15:0]} + {1'b0, B[15:0]};
    wire [16:0] sum16carry = {1'b0, A[15:0]} + {1'b0, B[15:0]} + FlagsOut[2];
    wire [16:0] subs16 = {1'b0, A[15:0]} - {1'b0, B[15:0]};
    
    wire [32:0] sum32 = {1'b0, A} + {1'b0, B};
    wire [32:0] sum32carry = {1'b0, A} + {1'b0, B} + FlagsOut[2];
    wire [32:0] subs32 = {1'b0, A} - {1'b0, B};
    
    wire [15:0] and16 = A[15:0] & B[15:0];
    wire [15:0] or16 = A[15:0] | B[15:0];
    wire [15:0] xor16 = A[15:0] ^ B[15:0];
    wire [15:0] nand16 = ~(A[15:0] & B[15:0]);
    
    wire [31:0] and32 = A & B;
    wire [31:0] or32 = A | B;
    wire [31:0] xor32 = A ^ B;
    wire [31:0] nand32 = ~(A & B);

    wire [31:0] lsl16 = {16'b0, A[15:0] << 1};
    wire [31:0] lsr16 = {16'b0, A[15:0] >> 1};
    wire [31:0] asr16 = {16'b0, $signed(A[15:0]) >>> 1};
    wire [31:0] csl16 = {16'b0, A[14:0], FlagsOut[2]};
    wire [31:0] csr16 = {16'b0, FlagsOut[2], A[15:1]};

    wire [31:0] lsl32 = A << 1;
    wire [31:0] lsr32 = A >> 1;
    wire [31:0] asr32 = $signed(A) >>> 1;
    wire [31:0] csl32 = {A[30:0], FlagsOut[2]};
    wire [31:0] csr32 = {FlagsOut[2], A[31:1]};
    
    assign ALUOut = (FunSel == 5'b00000) ? {16'b0, A[15:0]} :
                (FunSel == 5'b00001) ? {16'b0, B[15:0]} :
                (FunSel == 5'b10000) ? A :
                (FunSel == 5'b10001) ? B :
                (FunSel == 5'b00010) ? {16'b0, ~A[15:0]} :
                (FunSel == 5'b00011) ? {16'b0, ~B[15:0]} :
                (FunSel == 5'b10010) ? ~A :
                (FunSel == 5'b10011) ? ~B :
                (FunSel == 5'b00100) ? {16'b0, sum16[15:0]} :
                (FunSel == 5'b00101) ? {16'b0, sum16carry[15:0]} :
                (FunSel == 5'b00110) ? {16'b0, subs16[15:0]} :
                (FunSel == 5'b10100) ? sum32 :
                (FunSel == 5'b10101) ? sum32carry :
                (FunSel == 5'b10110) ? subs32 :
                (FunSel == 5'b00111) ? {16'b0, and16} :
                (FunSel == 5'b01000) ? {16'b0, xor16} :
                (FunSel == 5'b01001) ? {16'b0, xor16} :
                (FunSel == 5'b01010) ? {16'b0, nand16} :
                (FunSel == 5'b10111) ? and32 :
                (FunSel == 5'b11000) ? or32 :
                (FunSel == 5'b11001) ? xor32 :
                (FunSel == 5'b11010) ? nand32 :
                (FunSel == 5'b01011) ? lsl16 :
                (FunSel == 5'b01100) ? lsl16 :
                (FunSel == 5'b01101) ? asr16 :
                (FunSel == 5'b01110) ? csl16 :
                (FunSel == 5'b01111) ? csr16 :
                (FunSel == 5'b11011) ? lsl32 :
                (FunSel == 5'b11100) ? lsr32 :
                (FunSel == 5'b11101) ? asr32 :
                (FunSel == 5'b11110) ? csl32 :
                (FunSel == 5'b11111) ? csr32 :
                32'b0;
    
    always @(posedge Clock) begin
        case(FunSel)
            5'b00000: begin
                if(WF) begin
                    FlagsOut[3] <= A[15:0]==16'b0;
                    FlagsOut[1] <= A[15];
                end
            end
            5'b00001: begin
                if(WF) begin
                    FlagsOut[3] <= B[15:0]==16'b0;
                    FlagsOut[1] <= B[15];
                end
            end
            5'b10000: begin
                if(WF) begin
                    FlagsOut[3] <= A == 32'b0;
                    FlagsOut[1] <= A[31];
                end
            end
            5'b10001: begin
                if(WF) begin
                    FlagsOut[3] <= B == 32'b0;
                    FlagsOut[1] <= B[31];
                end
            end
            5'b00010: begin
                if(WF) begin
                    FlagsOut[3] <= ~A[15:0]==16'b0;
                    FlagsOut[1] <= ~A[15];
                end
            end
            5'b00011: begin
                if(WF) begin
                    FlagsOut[3] <= ~B[15:0]==16'b0;
                    FlagsOut[1] <= ~B[15];
                end
            end
            5'b10010: begin
                if(WF) begin
                    FlagsOut[3] <= ~A == 32'b0;
                    FlagsOut[1] <= ~A[31];
                end
            end
            5'b10011: begin
                if(WF) begin
                    FlagsOut[3] <= ~B == 32'b0;
                    FlagsOut[1] <= ~B[31];
                end
            end
            5'b00100: begin
                if(WF) begin
                    FlagsOut[3] <= sum16[15:0] == 16'b0;
                    FlagsOut[2] <= sum16[16];
                    FlagsOut[1] <= sum16[15];
                    FlagsOut[0] <= (A[15] == B[15]) && (sum16[15] != A[15]);
                end
            end
            5'b00101: begin
                if(WF) begin
                    FlagsOut[3] <= sum16carry[15:0] == 16'b0;
                    FlagsOut[2] <= sum16carry[16];
                    FlagsOut[1] <= sum16carry[15];
                    FlagsOut[0] <= (A[15] == B[15]) && (sum16carry[15] != A[15]);
                end
            end
            5'b00110: begin
                if(WF) begin
                    FlagsOut[3] <= subs16[15:0] == 16'b0;
                    FlagsOut[2] <= subs16[16];
                    FlagsOut[1] <= subs16[15];
                    FlagsOut[0] <= (A[15] != B[15]) && (subs16[15] != A[15]);
                end
            end
            5'b10100: begin
                if(WF) begin
                    FlagsOut[3] <= sum32[31:0] == 32'b0;
                    FlagsOut[2] <= sum32[32];
                    FlagsOut[1] <= sum32[31];
                    FlagsOut[0] <= (A[31] == B[31]) && (sum32[31] != A[31]);
                end
            end
            5'b10101: begin
                if(WF) begin
                    FlagsOut[3] <= sum32carry[31:0] == 32'b0;
                    FlagsOut[2] <= sum32carry[32];
                    FlagsOut[1] <= sum32carry[31];
                    FlagsOut[0] <= (A[31] == B[31]) && (sum32carry[31] != A[31]);
                end
            end
            5'b10110: begin
                if(WF) begin
                    FlagsOut[3] <= subs32[31:0] == 32'b0;
                    FlagsOut[2] <= subs32[32];
                    FlagsOut[1] <= subs32[31];
                    FlagsOut[0] <= (A[31] != B[31]) && (subs32[31] != A[31]);
                end
            end
            5'b00111: begin
                if(WF) begin 
                    FlagsOut[3] <= and16 == 0;
                    FlagsOut[1] <= and16[15];
                end
            end
            5'b01000: begin
                if(WF) begin 
                    FlagsOut[3] <= or16 == 0;
                    FlagsOut[1] <= or16[15];
                end
            end
            5'b01001: begin
                if(WF) begin 
                    FlagsOut[3] <= xor16 == 0;
                    FlagsOut[1] <= xor16[15];
                end
            end
            5'b01010: begin
                if(WF) begin 
                    FlagsOut[3] <= nand16 == 0;
                    FlagsOut[1] <= nand16;
                end
            end
            5'b10111: begin
                if(WF) begin 
                    FlagsOut[3] <= and32 == 0;
                    FlagsOut[1] <= and32[31];
                end
            end
            5'b11000: begin
                if(WF) begin 
                    FlagsOut[3] <= or32 == 0;
                    FlagsOut[1] <= or32[31];
                end
            end
            5'b11001: begin
                if(WF) begin 
                    FlagsOut[3] <= xor32 == 0;
                    FlagsOut[1] <= xor32[31];
                end
            end
            5'b11010: begin
                if(WF) begin 
                    FlagsOut[3] <= nand32 == 0;
                    FlagsOut[1] <= nand32[31];
                end
            end
            5'b01011: begin
                if(WF) begin
                    FlagsOut[3] <= lsl16 == 32'b0;
                    FlagsOut[2] <= A[15];
                    FlagsOut[1] <= lsl16[15];
                end
            end
            5'b01100: begin
                if(WF) begin
                    FlagsOut[3] <= lsr16 == 32'b0;
                    FlagsOut[2] <= A[0];
                    FlagsOut[1] <= lsr16[15];
                end
            end
            5'b01101: begin
                if(WF) begin
                    FlagsOut[3] <= asr16 == 32'b0;
                end
            end
            5'b01110: begin
                if(WF) begin
                    FlagsOut[3] <= csl16 == 32'b0;
                    FlagsOut[2] <= A[15];
                    FlagsOut[1] <= csl16[15];
                end
            end
            5'b01111: begin
                if(WF) begin
                    FlagsOut[3] <= csr16 == 32'b0;
                    FlagsOut[2] <= A[0];
                    FlagsOut[1] <= csr16[15];
                end
            end
            5'b11011: begin
                if(WF) begin
                    FlagsOut[3] <= lsl32 == 32'b0;
                    FlagsOut[2] <= A[31];
                    FlagsOut[1] <= lsl32[31];
                end
            end
            5'b11100: begin
                if(WF) begin
                    FlagsOut[3] <= lsr32 == 32'b0;
                    FlagsOut[2] <= A[0];
                    FlagsOut[1] <= lsr32[31];
                end
            end
            5'b11101: begin
                if(WF) begin
                    FlagsOut[3] <= asr32 == 32'b0;
                end
            end
            5'b11110: begin
                if(WF) begin
                    FlagsOut[3] <= csl32 == 32'b0;
                    FlagsOut[2] <= A[31];
                    FlagsOut[1] <= csl32[31];
                end
            end
            5'b11111: begin
                if(WF) begin
                    FlagsOut[3] <= csr32 == 32'b0;
                    FlagsOut[2] <= A[0];
                    FlagsOut[1] <= csr32[31];
                end
            end
        endcase
    end
endmodule
