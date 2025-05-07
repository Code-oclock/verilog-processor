
module alu(srcA, srcB, aluControl, zero, aluResult);
  input [31:0] srcA, srcB;
  input [2:0] aluControl;

  output reg zero;
  output reg [31:0] aluResult;

  always @(*) begin
    case (aluControl)
      3'b000:
        begin
          aluResult <= srcA + srcB;
        end
      3'b001:
        begin
          aluResult <= srcA - srcB;
        end
      3'b010:
        begin
          aluResult <= srcA & srcB;
        end
      3'b011:
        begin
          aluResult <= srcA | srcB;
        end
      3'b100:
        begin
          if (srcA < srcB)
            aluResult <= 1;
          else
            aluResult <= 0;
        end
    endcase
  end

  always @(aluResult) begin
    if (aluResult == 0 & aluControl == 1) begin
      zero <= 1;
    end
    else begin
      zero <= 0; 
    end
  end
endmodule