module MUX4_1_32bit (
    input  wire [31:0] in1, in2, in3, in4,
    input  wire [1:0] sel,
    output reg  [31:0] out
);
  always @(*) begin
    case (sel)
      2'b00: out = in1;
      2'b01: out = in2;
      2'b10: out = in3;
      2'b11: out = in4;
    endcase
  end
endmodule

module MUX4_1_8bit (
    input  wire [7:0] in1, in2, in3, in4,
    input  wire [1:0] sel,
    output reg  [7:0] out
);
  always @(*) begin
    case (sel)
      2'b00: out = in1;
      2'b01: out = in2;
      2'b10: out = in3;
      2'b11: out = in4;
    endcase
  end
endmodule

module MUX2_1_32bit (
    input wire [31:0] in1, in2,
    input wire sel,
    output reg [31:0] out
);
  always @(*) begin
    case (sel)
      1'b0: out = in1;
      1'b1: out = in2;
    endcase
  end
endmodule

module ArithmeticLogicUnitSystem(
    input wire MuxDSel, IR_Write, IR_LH, 
               DR_E, ALU_WF, Mem_WR, Mem_CS,
               Clock,
               
    input wire [1:0] MuxASel, MuxBSel, MuxCSel, DR_FunSel, 
                     ARF_OutCSel, ARF_OutDSel, ARF_FunSel,
    
    input wire [2:0] RF_FunSel, RF_OutASel, RF_OutBSel, 
                     ARF_RegSel,
                      
    input wire [3:0] RF_RegSel, RF_ScrSel, 
    
    input wire [4:0] ALU_FunSel,
    
    output reg Z, C, N, O
);
    wire [31:0] ALU_A, ALUOut, RF_I, ARF_I, MuxAOut, MuxBOut, MuxDOut;
    wire [7:0]  MEM_I, MemOut, MuxCOut;
    wire [31:0] OutA, OutB, DROut;
    wire [15:0] IROut, OutD, OutC, Address;
    
    ArithmeticLogicUnit ALU(.WF(ALU_WF),.FunSel(ALU_FunSel),
                        .A(ALU_A),.B(OutB),.Clock(Clock),
                        .ALUOut(ALUOut));

    RegisterFile RF(.I(RF_I),.Clock(Clock),.RegSel(RF_RegSel),
                .ScrSel(RF_ScrSel),.FunSel(RF_FunSel),
                .OutASel(RF_OutASel),.OutBSel(RF_OutBSel),.OutA(OutA),.OutB(OutB));

    AddressRegisterFile ARF(.I(ARF_I),.Clock(Clock),.RegSel(ARF_RegSel),
                      .FunSel(ARF_FunSel),.OutDSel(ARF_OutDSel),
                      .OutCSel(ARF_OutCSel),.OutD(OutD),.OutC(OutC));

    DataRegister DR(.I(MemOut),.Clock(Clock),.E(DR_E),.FunSel(DR_FunSel),.DROut(DROut));

    InstructionRegister IR(.I(MemOut),.Clock(Clock),.Write(IR_Write),.LH(IR_LH),.IROut(IROut));

    Memory MEM(.Data(MEM_I), .Address(OutD),.Clock(Clock), .MemOut(MemOut),.WR(Mem_WR),.CS(Mem_CS));
    
    assign Address = OutD;
    assign RF_I = MuxAOut;
    assign ARF_I = MuxBOut;
    assign MEM_I = MuxCOut;
    assign ALU_A = MuxDOut;
    
    MUX4_1_32bit MuxA (
        .in1(ALUOut),
        .in2({16'b0, OutC}),
        .in3(DROut),
        .in4({24'b0, IROut[7:0]}),
        .sel(MuxASel),
        .out(MuxAOut)
    );
    
    MUX4_1_32bit MuxB (
        .in1(ALUOut),
        .in2({16'b0, OutC}),
        .in3(DROut),
        .in4({24'b0, IROut[7:0]}),
        .sel(MuxBSel),
        .out(MuxBOut)
    );
    
    MUX4_1_8bit MuxC (
        .in1(ALUOut[7:0]),
        .in2(ALUOut[15:8]),
        .in3(ALUOut[23:16]),
        .in4(ALUOut[31:24]),
        .sel(MuxASel),
        .out(MuxCOut)
    );
    
    MUX2_1_32bit MuxD (
        .in1(OutA),
        .in2({16'b0, OutC}),
        .sel(MuxDSel),
        .out(MuxDOut)
    );

endmodule