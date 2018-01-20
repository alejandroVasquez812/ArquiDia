`include "SPARC_Datapath.v"
`include "ControlUnit.v"

module MPU(output[6:0] state);

wire [6:0] State;

wire reg_win_en, rf_load_en, rf_clear_en, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, fr_ld, mc, mf, mm, mop, msa, MOC;

wire [4:0] clear_select;
wire [1:0] msc, type, ma, mb, mnp, mp;
wire [5:0] opxx;


DataPath DP(wIROut, MOC, BCOND, TCOND, Register_Windows_Enable, RF_Load_Enable, RF_Clear_Enable, Clear_Select, IR_Ld, MAR_Ld, MDR_Ld, WIM_Ld, TBR_Ld, TTR_Ld, PC_Ld, NPC_Ld, nPC_Clr, PSR_Ld, RW, MOV,type, FR_Ld, MA, MB, MC, MF, MM, MNP, MOP, MP, MSa, MSc, OpXX, Clk);


ControlUnit CU(State,reg_win_en, rf_load_en, rf_clear_en, clear_select, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, type, fr_ld, ma, mb, mc, mf, mm, mnp, mop, mp, msa, msc, opxx, IR, Cond, Clk, MOC, Clr);


endmodule
