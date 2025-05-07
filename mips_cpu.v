`include "util.v"
`include "control_unit.v"
`include "alu.v"

module mips_cpu(clk, pc, pc_new, instruction_memory_a, instruction_memory_rd, data_memory_a, data_memory_rd, data_memory_we, data_memory_wd,
                register_a1, register_a2, register_a3, register_we3, register_wd3, register_rd1, register_rd2);
  // сигнал синхронизации
  input clk;
  // текущее значение регистра PC
  inout [31:0] pc;
  // новое значение регистра PC (адрес следующей команды)
  output [31:0] pc_new;
  // we для памяти данных
  output data_memory_we;
  // адреса памяти и данные для записи памяти данных
  output [31:0] instruction_memory_a, data_memory_a, data_memory_wd;
  // данные, полученные в результате чтения из памяти
  inout [31:0] instruction_memory_rd, data_memory_rd;
  // we3 для регистрового файла
  output register_we3;
  // номера регистров
  output [4:0] register_a1, register_a2, register_a3;
  // данные для записи в регистровый файл
  output [31:0] register_wd3;
  // данные, полученные в результате чтения из регистрового файла
  inout [31:0] register_rd1, register_rd2;

  // TODO: implementation

  wire memToReg, branch, regDst, aluSrc, branchNotEqual, jType, jal, jr;
  wire [2:0] aluControl;
  control_unit control(instruction_memory_rd[31:26], instruction_memory_rd[5:0], memToReg, data_memory_we, branch, aluControl, aluSrc, regDst, register_we3, jType, jal, jr);

  wire [31:0] signImm;
  sign_extend sign_extend(instruction_memory_rd[15:0], signImm);

  assign register_a1 = instruction_memory_rd[25:21];
  assign register_a2 = instruction_memory_rd[20:16];

  wire [4:0] tmpA3;
  mux2_5 muxToTmp(instruction_memory_rd[20:16], instruction_memory_rd[15:11], regDst, tmpA3);
  mux2_5 muxToReg(tmpA3, 5'b11111, jal, register_a3);

  wire [31:0] srcB;
  mux2_32 muxToAlu(register_rd2, signImm, aluSrc, srcB);

  wire zero;
  wire [31:0] aluResult;
  alu alu(register_rd1, srcB, aluControl, zero, aluResult);

  wire pcSrc;
  wire [31:0] tmpPcAddr;
  assign branchNotEqual = branch & instruction_memory_rd[26];
  assign pcSrc = (branch & zero & (~branchNotEqual)) | (branch & branchNotEqual & (~zero));
  // assign pcSrc = branch & zero;

  assign data_memory_wd = register_rd2;
  assign data_memory_a = aluResult;
  assign tmpPcAddr[31:28] = pcPlus4[31:28];
  assign tmpPcAddr[27:2] = instruction_memory_rd[25:0];
  assign tmpPcAddr[1:0] = 2'b00;

  wire [31:0] tmpWd3;
  mux2_32 mux2_32(aluResult, data_memory_rd, memToReg, tmpWd3);

  wire [31:0] tmpConst;
  shl_2 shl_2(signImm, tmpConst);

  wire [31:0] pcPlus4;
  adder adderToPc(pc, 4, pcPlus4);
  mux2_32 muxToWd3(tmpWd3, pcPlus4, jal, register_wd3);

  wire [31:0] pcBranch;
  adder adder(tmpConst, pcPlus4, pcBranch);

  wire [31:0] tmpPc, tmpPc1;
  mux2_32 muxToPc(pcPlus4, pcBranch, pcSrc, tmpPc);
  mux2_32 muxToPc1(tmpPc, tmpPcAddr, jType, tmpPc1);
  mux2_32 muxToPcNew(tmpPc1, register_rd1, jr, pc_new);

  assign instruction_memory_a = pc;

endmodule
