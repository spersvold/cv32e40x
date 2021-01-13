// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


package cv32e40x_tracer_pkg;
import cv32e40x_pkg::*;

// settings
parameter bit SymbolicRegs = 0; // show abi names for registers

// instruction masks (for tracer)
// parameter INSTR_CUSTOM0   = { 25'b?, OPCODE_CUST0 };
// parameter INSTR_CUSTOM1   = { 25'b?, OPCODE_CUST1 };
parameter INSTR_LUI       = { 25'b?, OPCODE_LUI };
parameter INSTR_AUIPC     = { 25'b?, OPCODE_AUIPC };
parameter INSTR_JAL       = { 25'b?, OPCODE_JAL };
parameter INSTR_JALR      = { 17'b?, 3'b000, 5'b?, OPCODE_JALR };
// BRANCH
parameter INSTR_BEQ      =  { 17'b?, 3'b000, 5'b?, OPCODE_BRANCH };
parameter INSTR_BNE      =  { 17'b?, 3'b001, 5'b?, OPCODE_BRANCH };
parameter INSTR_BLT      =  { 17'b?, 3'b100, 5'b?, OPCODE_BRANCH };
parameter INSTR_BGE      =  { 17'b?, 3'b101, 5'b?, OPCODE_BRANCH };
parameter INSTR_BLTU     =  { 17'b?, 3'b110, 5'b?, OPCODE_BRANCH };
parameter INSTR_BGEU     =  { 17'b?, 3'b111, 5'b?, OPCODE_BRANCH };
parameter INSTR_BEQIMM   =  { 17'b?, 3'b010, 5'b?, OPCODE_BRANCH };
parameter INSTR_BNEIMM   =  { 17'b?, 3'b011, 5'b?, OPCODE_BRANCH };
// OPIMM
parameter INSTR_ADDI     =  { 17'b?, 3'b000, 5'b?, OPCODE_OPIMM };
parameter INSTR_SLTI     =  { 17'b?, 3'b010, 5'b?, OPCODE_OPIMM };
parameter INSTR_SLTIU    =  { 17'b?, 3'b011, 5'b?, OPCODE_OPIMM };
parameter INSTR_XORI     =  { 17'b?, 3'b100, 5'b?, OPCODE_OPIMM };
parameter INSTR_ORI      =  { 17'b?, 3'b110, 5'b?, OPCODE_OPIMM };
parameter INSTR_ANDI     =  { 17'b?, 3'b111, 5'b?, OPCODE_OPIMM };
parameter INSTR_SLLI     =  { 7'b0000000, 10'b?, 3'b001, 5'b?, OPCODE_OPIMM };
parameter INSTR_SRLI     =  { 7'b0000000, 10'b?, 3'b101, 5'b?, OPCODE_OPIMM };
parameter INSTR_SRAI     =  { 7'b0100000, 10'b?, 3'b101, 5'b?, OPCODE_OPIMM };
// OP
parameter INSTR_ADD      =  { 7'b0000000, 10'b?, 3'b000, 5'b?, OPCODE_OP };
parameter INSTR_SUB      =  { 7'b0100000, 10'b?, 3'b000, 5'b?, OPCODE_OP };
parameter INSTR_SLL      =  { 7'b0000000, 10'b?, 3'b001, 5'b?, OPCODE_OP };
parameter INSTR_SLT      =  { 7'b0000000, 10'b?, 3'b010, 5'b?, OPCODE_OP };
parameter INSTR_SLTU     =  { 7'b0000000, 10'b?, 3'b011, 5'b?, OPCODE_OP };
parameter INSTR_XOR      =  { 7'b0000000, 10'b?, 3'b100, 5'b?, OPCODE_OP };
parameter INSTR_SRL      =  { 7'b0000000, 10'b?, 3'b101, 5'b?, OPCODE_OP };
parameter INSTR_SRA      =  { 7'b0100000, 10'b?, 3'b101, 5'b?, OPCODE_OP };
parameter INSTR_OR       =  { 7'b0000000, 10'b?, 3'b110, 5'b?, OPCODE_OP };
parameter INSTR_AND      =  { 7'b0000000, 10'b?, 3'b111, 5'b?, OPCODE_OP };

// FENCE
parameter INSTR_FENCE    =  { 4'b0, 8'b?, 13'b0, OPCODE_FENCE };
parameter INSTR_FENCEI   =  { 17'b0, 3'b001, 5'b0, OPCODE_FENCE };
// SYSTEM
parameter INSTR_CSRRW    =  { 17'b?, 3'b001, 5'b?, OPCODE_SYSTEM };
parameter INSTR_CSRRS    =  { 17'b?, 3'b010, 5'b?, OPCODE_SYSTEM };
parameter INSTR_CSRRC    =  { 17'b?, 3'b011, 5'b?, OPCODE_SYSTEM };
parameter INSTR_CSRRWI   =  { 17'b?, 3'b101, 5'b?, OPCODE_SYSTEM };
parameter INSTR_CSRRSI   =  { 17'b?, 3'b110, 5'b?, OPCODE_SYSTEM };
parameter INSTR_CSRRCI   =  { 17'b?, 3'b111, 5'b?, OPCODE_SYSTEM };
parameter INSTR_ECALL    =  { 12'b000000000000, 13'b0, OPCODE_SYSTEM };
parameter INSTR_EBREAK   =  { 12'b000000000001, 13'b0, OPCODE_SYSTEM };
parameter INSTR_URET     =  { 12'b000000000010, 13'b0, OPCODE_SYSTEM };
parameter INSTR_SRET     =  { 12'b000100000010, 13'b0, OPCODE_SYSTEM };
parameter INSTR_MRET     =  { 12'b001100000010, 13'b0, OPCODE_SYSTEM };
parameter INSTR_DRET     =  { 12'b011110110010, 13'b0, OPCODE_SYSTEM };
parameter INSTR_WFI      =  { 12'b000100000101, 13'b0, OPCODE_SYSTEM };

// RV32M
parameter INSTR_DIV      =  { 7'b0000001, 10'b?, 3'b100, 5'b?, OPCODE_OP };
parameter INSTR_DIVU     =  { 7'b0000001, 10'b?, 3'b101, 5'b?, OPCODE_OP };
parameter INSTR_REM      =  { 7'b0000001, 10'b?, 3'b110, 5'b?, OPCODE_OP };
parameter INSTR_REMU     =  { 7'b0000001, 10'b?, 3'b111, 5'b?, OPCODE_OP };
parameter INSTR_PMUL     =  { 7'b0000001, 10'b?, 3'b000, 5'b?, OPCODE_OP };
parameter INSTR_PMUH     =  { 7'b0000001, 10'b?, 3'b001, 5'b?, OPCODE_OP };
parameter INSTR_PMULHSU  =  { 7'b0000001, 10'b?, 3'b010, 5'b?, OPCODE_OP };
parameter INSTR_PMULHU   =  { 7'b0000001, 10'b?, 3'b011, 5'b?, OPCODE_OP };

// RV32F
parameter INSTR_FMADD    =  { 5'b?,     2'b00, 10'b?,      3'b?,   5'b?, OPCODE_OP_FMADD  };
parameter INSTR_FMSUB    =  { 5'b?,     2'b00, 10'b?,      3'b?,   5'b?, OPCODE_OP_FMSUB  };
parameter INSTR_FNMSUB   =  { 5'b?,     2'b00, 10'b?,      3'b?,   5'b?, OPCODE_OP_FNMSUB };
parameter INSTR_FNMADD   =  { 5'b?,     2'b00, 10'b?,      3'b?,   5'b?, OPCODE_OP_FNMADD };

parameter INSTR_FADD     =  { 5'b00000, 2'b00, 10'b?,      3'b?,   5'b?, OPCODE_OP_FP };
parameter INSTR_FSUB     =  { 5'b00001, 2'b00, 10'b?,      3'b?,   5'b?, OPCODE_OP_FP };
parameter INSTR_FMUL     =  { 5'b00010, 2'b00, 10'b?,      3'b?,   5'b?, OPCODE_OP_FP };
parameter INSTR_FDIV     =  { 5'b00011, 2'b00, 10'b?,      3'b?,   5'b?, OPCODE_OP_FP };
parameter INSTR_FSQRT    =  { 5'b01011, 2'b00, 5'b0, 5'b?, 3'b?,   5'b?, OPCODE_OP_FP };
parameter INSTR_FSGNJS   =  { 5'b00100, 2'b00, 10'b?,      3'b000, 5'b?, OPCODE_OP_FP };
parameter INSTR_FSGNJNS  =  { 5'b00100, 2'b00, 10'b?,      3'b001, 5'b?, OPCODE_OP_FP };
parameter INSTR_FSGNJXS  =  { 5'b00100, 2'b00, 10'b?,      3'b010, 5'b?, OPCODE_OP_FP };
parameter INSTR_FMIN     =  { 5'b00101, 2'b00, 10'b?,      3'b000, 5'b?, OPCODE_OP_FP };
parameter INSTR_FMAX     =  { 5'b00101, 2'b00, 10'b?,      3'b001, 5'b?, OPCODE_OP_FP };
parameter INSTR_FCVTWS   =  { 5'b11000, 2'b00, 5'b0, 5'b?, 3'b?, 5'b?, OPCODE_OP_FP };
parameter INSTR_FCVTWUS  =  { 5'b11000, 2'b00, 5'b1, 5'b?, 3'b?, 5'b?, OPCODE_OP_FP };
parameter INSTR_FMVXS    =  { 5'b11100, 2'b00, 5'b0, 5'b?, 3'b000, 5'b?, OPCODE_OP_FP };
parameter INSTR_FEQS     =  { 5'b10100, 2'b00, 10'b?,      3'b010, 5'b?, OPCODE_OP_FP };
parameter INSTR_FLTS     =  { 5'b10100, 2'b00, 10'b?,      3'b001, 5'b?, OPCODE_OP_FP };
parameter INSTR_FLES     =  { 5'b10100, 2'b00, 10'b?,      3'b000, 5'b?, OPCODE_OP_FP };
parameter INSTR_FCLASS   =  { 5'b11100, 2'b00, 5'b0, 5'b?, 3'b001, 5'b?, OPCODE_OP_FP };
parameter INSTR_FCVTSW   =  { 5'b11010, 2'b00, 5'b0, 5'b?, 3'b?, 5'b?, OPCODE_OP_FP };
parameter INSTR_FCVTSWU  =  { 5'b11010, 2'b00, 5'b1, 5'b?, 3'b?, 5'b?, OPCODE_OP_FP };
parameter INSTR_FMVSX    =  { 5'b11110, 2'b00, 5'b0, 5'b?, 3'b000, 5'b?, OPCODE_OP_FP };

// RV32A
parameter INSTR_LR       =  { AMO_LR  , 2'b?, 5'b0, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_SC       =  { AMO_SC  , 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_AMOSWAP  =  { AMO_SWAP, 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_AMOADD   =  { AMO_ADD , 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_AMOXOR   =  { AMO_XOR , 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_AMOAND   =  { AMO_AND , 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_AMOOR    =  { AMO_OR  , 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_AMOMIN   =  { AMO_MIN , 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_AMOMAX   =  { AMO_MAX , 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_AMOMINU  =  { AMO_MINU, 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };
parameter INSTR_AMOMAXU  =  { AMO_MAXU, 2'b?, 5'b?, 5'b?, 3'b010, 5'b?, OPCODE_AMO };

// to be used in tracer!

endpackage
