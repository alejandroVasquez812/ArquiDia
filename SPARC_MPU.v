`include "SPARC_Datapath.v"
`include "ControlUnit.v"


module MPU(output[6:0] State , output [31:0] wIROut, input Clk, Clr);  

wire [6:0] State;

wire reg_win_en, rf_load_en, rf_clear_en, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, fr_ld, mc, mf, mm, mop, msa, MOC;

wire [4:0] clear_select;
wire [1:0] msc, type, ma, mb, mnp, mp;
wire [5:0] opxx;

DataPath DP(wIROut, MOC, BCOND, TCOND, reg_win_en, rf_load_en, rf_clear_en, clear_select, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, type, fr_ld, ma, mb, mc, mf, mm, mnp, mop, mp, msa, msc, opxx, Clk);

ControlUnit CU(State,reg_win_en, rf_load_en, rf_clear_en, clear_select, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, type, fr_ld, ma, mb, mc, mf, mm, mnp, mop, mp, msa, msc, opxx, wIROut, BCOND, Clk, MOC, Clr);
 

endmodule
