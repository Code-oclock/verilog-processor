module control_unit(op, funct, memToReg, memWrite, branch, aluControl, aluSrc, regDst, regWrite, jType, jal, jr);
  input [5:0] funct, op;

  output reg memToReg, memWrite, branch, regDst, regWrite, aluSrc, jType, jal, jr;
  output reg [2:0] aluControl;

  always @(*) begin
    case (op)
      6'b100011:
        begin
          regWrite <= 1;
          regDst <= 0;
          aluSrc <= 1;
          branch <= 0;
          memWrite <= 0;
          memToReg <= 1;
          aluControl <= 0;
          jType <= 0;
          jal <= 0;
          jr <= 0;
        end
      6'b101011:
        begin
          regWrite <= 0;
          regDst <= 1'bx;
          aluSrc <= 1;
          branch <= 0;
          memWrite <= 1;
          memToReg <= 1'bx;
          aluControl <= 0;
          jType <= 0;
          jal <= 0;
          jr <= 0;
        end
      6'b000100:
        begin
          regWrite <= 0;
          regDst <= 1'bx;
          aluSrc <= 0;
          branch <= 1;
          memWrite <= 0;
          memToReg <= 1'bx;
          aluControl <= 1;
          jType <= 0;
          jal <= 0;
          jr <= 0;
        end
      6'b001000:
        begin
          regWrite <= 1;
          regDst <= 0;
          aluSrc <= 1;
          branch <= 0;
          memWrite <= 0;
          memToReg <= 0;
          aluControl <= 0;
          jType <= 0;
          jal <= 0;
          jr <= 0;
        end
      6'b001100:
        begin
          regWrite <= 1;
          regDst <= 0;
          aluSrc <= 1;
          branch <= 0;
          memWrite <= 0;
          memToReg <= 0;
          aluControl <= 2;
          jType <= 0;
          jal <= 0;
          jr <= 0;
        end
      6'b000101:
        begin
          regWrite <= 0;
          regDst <= 1'bx;
          aluSrc <= 0;
          branch <= 1;
          memWrite <= 0;
          memToReg <= 1'bx;
          aluControl <= 1;
          jType <= 0;
          jal <= 0;
          jr <= 0;
        end
      6'b000010:
        begin
          regWrite <= 0;
          regDst <= 1'bx;
          aluSrc <= 0;
          branch <= 0;
          memWrite <= 0;
          memToReg <= 1'bx;
          aluControl <= 0;
          jType <= 1;
          jal <= 0;
          jr <= 0;
        end
      6'b000011:
        begin
          regWrite <= 1;
          regDst <= 0;
          aluSrc <= 0;
          branch <= 0;
          memWrite <= 0;
          memToReg <= 0;
          aluControl <= 0;
          jType <= 1;
          jal <= 1;
          jr <= 0;
        end
      6'b000000:
        begin
          regWrite <= 1;
          regDst <= 1;
          aluSrc <= 0;
          branch <= 0;
          memWrite <= 0;
          memToReg <= 0;
          jType <= 0;
          jal <= 0;
          jr <= 0;
          case (funct)
            6'b100000:
              aluControl <= 3'b000;
            6'b100010:
              aluControl <= 3'b001;
            6'b100100:
              aluControl <= 3'b010;
            6'b100101:
              aluControl <= 3'b011;
            6'b101010:
              aluControl <= 3'b100;
            6'b001000:
              begin
                regWrite <= 0;
                jType <= 1;
                jr <= 1;
                aluControl <= 0;
              end
          endcase
        end
    endcase
  end
endmodule