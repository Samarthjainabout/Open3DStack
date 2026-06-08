# Standard-cell OpenLane settings for the neutral 3D_TFT platform wrapper.

set ::env(LIB_SYNTH) "$::env(PDK_ROOT)/$::env(PDK)/libs.ref/$::env(STD_CELL_LIBRARY)/lib/typ_1p50v_25c.lib"
set ::env(LIB_TYPICAL) $::env(LIB_SYNTH)
set ::env(LIB_FASTEST) "$::env(PDK_ROOT)/$::env(PDK)/libs.ref/$::env(STD_CELL_LIBRARY)/lib/fast_1p65v_55c.lib"
set ::env(LIB_SLOWEST) "$::env(PDK_ROOT)/$::env(PDK)/libs.ref/$::env(STD_CELL_LIBRARY)/lib/slow_1p35v_m10c.lib"
set ::env(PL_LIB) $::env(LIB_TYPICAL)
set ::env(VERILOG_MODELS) [list \
    "$::env(PDK_ROOT)/$::env(PDK)/libs.ref/$::env(STD_CELL_LIBRARY)/verilog/tft3d_sc_t5.v" \
    "$::env(PDK_ROOT)/$::env(PDK)/libs.ref/$::env(STD_CELL_LIBRARY)/verilog/lib_udp.v" \
]

set ::env(PLACE_SITE) CoreSite_T5
set ::env(PLACE_SITE_WIDTH) 4.0
set ::env(PLACE_SITE_HEIGHT) 20.0

set ::env(SYNTH_DRIVING_CELL) INV_X2PC_T5
set ::env(SYNTH_DRIVING_CELL_PIN) Y
set ::env(OUTPUT_CAP_LOAD) 1.0
set ::env(SYNTH_MIN_BUF_PORT) "BUF_X2PC_T5 A Y"
set ::env(SYNTH_TIEHI_PORT) "TIEHI_T5 Y"
set ::env(SYNTH_TIELO_PORT) "TIELO_T5 Y"

set ::env(CTS_ROOT_BUFFER) CLKBUF_X8PC_T5
set ::env(ROOT_CLK_BUFFER) CLKBUF_X8PC_T5
set ::env(CTS_CLK_BUFFER_LIST) "CLKBUF_X8PC_T5 CLKBUF_X2PC_T5 BUF_X4PC_T5 BUF_X2PC_T5"
set ::env(CELL_CLK_PORT) A
set ::env(CTS_MAX_CAP) 2.0

set ::env(FILL_CELL) "FILL*_T5 FILLCAP*_T5"
set ::env(DECAP_CELL) "FILLCAP8_T5 FILLCAP4_T5 FILLCAP2_T5 FILLCAP1_T5"
set ::env(RE_BUFFER_CELL) BUF_X4PC_T5
set ::env(DIODE_CELL) ""
set ::env(FAKEDIODE_CELL) ""
set ::env(DIODE_CELL_PIN) ""

set ::env(FP_WELLTAP_CELL) ""
set ::env(FP_ENDCAP_CELL) ""
set ::env(GPL_CELL_PADDING) 0
set ::env(DPL_CELL_PADDING) 0
set ::env(CELL_PAD_EXCLUDE) "FILL*_T5 FILLCAP*_T5"
set ::env(MAX_TRANSITION_CONSTRAINT) 1000
set ::env(MAX_FANOUT_CONSTRAINT) 10
set ::env(MAX_CAPACITANCE_CONSTRAINT) 10
set ::env(TRISTATE_CELL_PREFIX) ""
