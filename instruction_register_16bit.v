module InstructionRegister(
    input wire [7:0] I,
    input wire Write,
    input wire LH,
    input wire Clock,
    output reg [15:0] IROut
    );
    
    always @(posedge Clock) begin
        if(Write) begin
            if(LH) begin
               IROut[15:8] <= I[7:0]; 
            end
            else begin
                IROut[7:0] <= I[7:0];
            end
        end
    end
endmodule